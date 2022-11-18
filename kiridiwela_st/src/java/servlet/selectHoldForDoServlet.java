/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.do_data;
import dataclass.do_id;
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
import resources.HoldInvoice;
import resources.HoldInvoiceItem;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "selectHoldForDoServlet", urlPatterns = {"/selectHoldForDoServlet"})
public class selectHoldForDoServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (request.getParameter("id") != null && !request.getParameter("id").equals("")) {

                Session ses = connection.getConnection.getSessionFactory().openSession();
                int hold_id = Integer.parseInt(request.getParameter("id"));
                HoldInvoice HI = (HoldInvoice) ses.load(HoldInvoice.class, hold_id);

                ArrayList<do_id> do_id_list = new ArrayList();
                ArrayList<do_data> do_item_list = new ArrayList();

                if (request.getSession().getAttribute("do_id_list") != null) {
                    do_id_list = (ArrayList<do_id>) request.getSession().getAttribute("do_id_list");

                    boolean flag = false;
                    for (do_id il : do_id_list) {
                        if (il.getHold_id() == hold_id) {
                            flag = true;
                        }
                    }

                    if (!flag) {
                        do_id d = new do_id();
                        d.setHold_id(hold_id);
                        do_id_list.add(d);

                        if (request.getSession().getAttribute("do_item_list") != null) {
                            do_item_list = (ArrayList<do_data>) request.getSession().getAttribute("do_item_list");
                        }
                        Set<HoldInvoiceItem> HII = HI.getHoldInvoiceItems();
                        for (HoldInvoiceItem HT : HII) {

                            if (HT.getQtt() > HT.getQtySended()) {
                                
                                do_data dd = new do_data();
                                dd.setDiscount(HT.getDescount());
                                dd.setHold_Invoice_Number(hold_id);
                                dd.setItem_ID(HT.getItems().getItemId());
                                dd.setItem_Name(HT.getItems().getName());
                                dd.setPrice(HT.getUnitPrice());
                                dd.setQty(HT.getQtt());
                                dd.setQty_sended(HT.getQtySended());
                                dd.setTotal(HT.getTotal());
                                dd.setQty_send((HT.getQtt()-HT.getQtySended()));
                                dd.setStock_id(HT.getStock().getStockId());
                                dd.setHold_Id(HT.getIdholdInvoiceItem());
                                do_item_list.add(dd);
                                
                            }

                        }
                        request.getSession().setAttribute("do_id_list", do_id_list);
                        request.getSession().setAttribute("do_item_list", do_item_list);
                        out.print("1");
                    } else {
                        out.print("2");
                    }

                } else {
                    do_id d = new do_id();
                    d.setHold_id(hold_id);
                    do_id_list.add(d);
                    if (request.getSession().getAttribute("do_item_list") != null) {
                        do_item_list = (ArrayList<do_data>) request.getSession().getAttribute("do_item_list");
                    }
                    Set<HoldInvoiceItem> HII = HI.getHoldInvoiceItems();
                    for (HoldInvoiceItem HT : HII) {
                        if (HT.getQtt() > HT.getQtySended()) {
                            do_data dd = new do_data();
                            dd.setDiscount(HT.getDescount());
                            dd.setHold_Invoice_Number(hold_id);
                            dd.setItem_ID(HT.getItems().getItemId());
                            dd.setItem_Name(HT.getItems().getName());
                            dd.setPrice(HT.getUnitPrice());
                            dd.setQty(HT.getQtt());
                            dd.setQty_send((HT.getQtt()-HT.getQtySended()));
                            dd.setQty_sended(HT.getQtySended());
                            dd.setTotal(HT.getTotal());
                            dd.setStock_id(HT.getStock().getStockId());
                            dd.setHold_Id(HT.getIdholdInvoiceItem());
                            do_item_list.add(dd);
                        }

                    }

                    request.getSession().setAttribute("do_id_list", do_id_list);
                    request.getSession().setAttribute("do_item_list", do_item_list);
                    out.print("1");

                }

                ses.close();

            } else {
                out.print("0");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
