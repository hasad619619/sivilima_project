/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.HoldInvoice;
import resources.HoldInvoiceItem;
import resources.Stock;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveReturnHoldInvoiceServlet", urlPatterns = {"/saveReturnHoldInvoiceServlet"})
public class saveReturnHoldInvoiceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            Stock STT = null;
            if (request.getSession().getAttribute("HoldInvoiceReturn") != null) {
                ArrayList<invoiceReturnModel> invoice = (ArrayList<invoiceReturnModel>) request.getSession().getAttribute("HoldInvoiceReturn");

                Session ses2 = connection.getConnection.getSessionFactory().openSession();
                Transaction tr2 = ses2.beginTransaction();
                double tot = 0.0;
                double tot_profit = 0.0;
                double tot_cost = 0.0;
                
                for (invoiceReturnModel IRM : invoice) {
                    if(IRM.getQty() > 0){
                        HoldInvoiceItem RI = (HoldInvoiceItem) ses2.load(HoldInvoiceItem.class, IRM.getInvoice_id());
                        tot = tot + IRM.getNet_total();
                        tot_cost = tot_cost + (IRM.getQty() * RI.getOriginalCostPerItem());
                        tot_profit = tot_profit + (IRM.getNet_total()-(IRM.getQty() * RI.getOriginalCostPerItem()));
                    }
                }

                for (invoiceReturnModel IRM : invoice) {
                    HoldInvoiceItem RI = (HoldInvoiceItem) ses2.load(HoldInvoiceItem.class, IRM.getInvoice_id());
                    RI.setQtt(IRM.getQty());
                    RI.setTotal(IRM.getTotal());
                    RI.setNetTotal(IRM.getNet_total());
                    RI.setDescount(IRM.getTotal() -IRM.getNet_total());
                    RI.setCost(IRM.getQty() * RI.getOriginalCostPerItem());
                    RI.setProfit(IRM.getNet_total()-(IRM.getQty() * RI.getOriginalCostPerItem()));
                    HoldInvoice HI = RI.getHoldInvoice();
                    HI.setTotal(tot - HI.getDescount());
                    HI.setTotalCost(tot_cost);
                    HI.setTotalProfit(tot_profit - HI.getDescount());
                    ses2.update(RI);
                    ses2.update(HI);
                }

                out.print("1-1");

                if (request.getSession().getAttribute("HoldInvoiceReturn") != null) {
                    request.getSession().removeAttribute("HoldInvoiceReturn");

                }

                tr2.commit();
                ses2.close();
            } else {
                out.print("0-0");

            }

        } catch (IOException | HibernateException e) {
            System.out.println(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
