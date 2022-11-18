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
import org.hibernate.Session;
import resources.HoldInvoiceItem;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "UpdateQttHoldInvoiceReturnNewServlet", urlPatterns = {"/UpdateQttHoldInvoiceReturnNewServlet"})
public class UpdateQttHoldInvoiceReturnNewServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Session ses = connection.getConnection.getSessionFactory().openSession();
            if (request.getParameter("hash").equals("") || request.getParameter("qty").equals("")) {

                out.print("0");

            } else {

                int hash = Integer.parseInt(request.getParameter("hash"));
                double qty = Double.parseDouble(request.getParameter("qty"));

                ArrayList<invoiceReturnModel> invoice = new ArrayList();
                if (request.getSession().getAttribute("invoiceReturnHold") != null) {

                    invoice = (ArrayList<invoiceReturnModel>) request.getSession().getAttribute("invoiceReturnHold");
                    invoiceReturnModel get = invoice.get(hash);
                    HoldInvoiceItem SII = (HoldInvoiceItem) ses.load(HoldInvoiceItem.class, get.getId());

                    get.setQty(qty);
                    double tot, nettot, desc;
                    tot = (qty) * get.getPrice();
                    tot = (double) Math.round(tot * 100.0) / 100.0;
                    desc = SII.getDescountRate();
                    nettot = tot - (qty * desc);
                    nettot = (double) Math.round(nettot * 100.0) / 100.0;
                    get.setTotal(tot);
                    get.setNet_total(nettot);
                    invoice.remove(hash);
                    invoice.add(get);
                    request.getSession().setAttribute("invoiceReturnHold", invoice);
                    out.print("1");

                    ses.close();

                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
