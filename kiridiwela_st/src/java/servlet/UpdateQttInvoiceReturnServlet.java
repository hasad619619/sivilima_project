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
import resources.SaleInvoiceItem;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "UpdateQttInvoiceReturnServlet", urlPatterns = {"/UpdateQttInvoiceReturnServlet"})
public class UpdateQttInvoiceReturnServlet extends HttpServlet {

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
            Session ses = connection.getConnection.getSessionFactory().openSession();
            if (request.getParameter("hash").equals("") || request.getParameter("qty").equals("")) {

                out.print("0");

            } else {

                int hash = Integer.parseInt(request.getParameter("hash"));
                double qty = Double.parseDouble(request.getParameter("qty"));

                ArrayList<invoiceReturnModel> invoice = new ArrayList();
                if (request.getSession().getAttribute("invoiceReturn") != null) {

                    invoice = (ArrayList<invoiceReturnModel>) request.getSession().getAttribute("invoiceReturn");
                    invoiceReturnModel get = invoice.get(hash);
                    SaleInvoiceItem SII = (SaleInvoiceItem) ses.load(SaleInvoiceItem.class, get.getId());
                    if (qty <= SII.getQtt()) {
                        double invoice_desc = get.getItem_desk()  * qty;
                        get.setQty(qty);
                        double tot,nettot,desc;
                        tot = (qty) * get.getPrice();
                        tot = (double) Math.round(tot * 100.0) / 100.0;
                        desc=SII.getDescount() / SII.getQtt();
                        nettot=tot-(desc * qty);
                        nettot = (double) Math.round(nettot * 100.0) / 100.0;
                        get.setTotal(tot);
                        get.setDescount(desc * qty);
                        get.setDescount_from_total(invoice_desc);
                        get.setNet_total(nettot - ( invoice_desc) );
                        invoice.remove(hash);
                        invoice.add(get);
                        request.getSession().setAttribute("invoiceReturn", invoice);
                        out.print("1");
                    } else {
                        out.print("2");

                    }
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
