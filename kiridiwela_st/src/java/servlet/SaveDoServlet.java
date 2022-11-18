/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.do_data;
import dataclass.do_id;
import dataclass.helper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Deo;
import resources.DoHoldItem;
import resources.DoItem;
import resources.HoldInvoice;
import resources.HoldInvoiceItem;
import resources.Stock;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "SaveDoServlet", urlPatterns = {"/SaveDoServlet"})
public class SaveDoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                if (request.getSession().getAttribute("do_id_list") != null && request.getSession().getAttribute("do_item_list") != null) {
                ArrayList<do_data> id_item_list = (ArrayList<do_data>) request.getSession().getAttribute("do_item_list");
                ArrayList<do_id> id_ist = (ArrayList<do_id>) request.getSession().getAttribute("do_id_list");

                helper help = new helper();
                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                String REMARK = "N/A";
                if (request.getParameter("re") != null && !request.getParameter("re").equals("")) {
                    REMARK = request.getParameter("re");

                }

                Deo doe = new Deo();
                doe.setDate(help.getDate());
                doe.setTime(help.getTime());
                doe.setRemark(REMARK);
                doe.setStatus(1);
                ses.save(doe);

                for (do_data d : id_item_list) {
                    Stock st = (Stock) ses.load(Stock.class, d.getStock_id());
                    HoldInvoiceItem hii = (HoldInvoiceItem) ses.load(HoldInvoiceItem.class, d.getHold_Id());
                    hii.setQtySended(d.getQty());
                    double NEW_QTY = st.getQty() - d.getQty();
                    NEW_QTY = (double) Math.round(NEW_QTY * 100.0) / 100.0;
                    st.setQty(NEW_QTY);
                    ses.update(st);
                    ses.update(hii);

                }
                for (do_id id : id_ist) {
                    
                    
                    DoItem di = new DoItem();
                    di.setCustomerRecieved(0);
                    di.setDeo(doe);
                    HoldInvoice hii = (HoldInvoice) ses.load(HoldInvoice.class, id.getHold_id() );
                    di.setHoldInvoice(hii);
                    di.setSendDate(help.getDate());
                    di.setSendTime(help.getTime());
                    di.setStatus(1);
                    di.setTransport(id.getTranport());
                    ses.save(di);

                    Set<HoldInvoiceItem> HIT = hii.getHoldInvoiceItems();
                    int i = 0;
                    for (HoldInvoiceItem h : HIT) {

                        if (h.getQtt() > h.getQtySended()) {
                            i = 1;
                            break;
                        }

                    }

                    if (i == 0) {
                        hii.setStatus(2);
                        ses.update(hii);
                    }
                    for (do_data d : id_item_list) {
                        if (id.getHold_id() == d.getHold_Invoice_Number() ) {
                            DoHoldItem dh = new DoHoldItem();
                            dh.setQty(d.getQty());
                            dh.setStatus(1);
                            dh.setDoItem(di);
                            HoldInvoiceItem hi = (HoldInvoiceItem) ses.load(HoldInvoiceItem.class, d.getHold_Id());
                            dh.setHoldInvoiceItem(hi);
                            ses.save(dh);
                        }
                    }

                }

                request.getSession().removeAttribute("do_id_list");
                request.getSession().removeAttribute("do_item_list");
                tr.commit();
                ses.close();
                out.print("1~" + doe.getIddo());
            } else {
                out.print("0~0");
            }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
