/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import resources.PurchaseInvoiceOrder;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "P1Servlet", urlPatterns = {"/P1Servlet"})
public class P1Servlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getSession().getAttribute("p1") == null) {
            if (request.getParameter("type").equals("") || request.getParameter("date").equals("") || request.getParameter("user").equals("") || request.getParameter("po").equals("")) {

                out.print("0");

            } else {
                Session ses = connection.getConnection.getSessionFactory().openSession();
                PurchaseInvoiceOrder PO;
                try {
                    PO = (PurchaseInvoiceOrder) ses.load(PurchaseInvoiceOrder.class, Integer.parseInt(request.getParameter("po")));
                    if (PO != null) {
                        String[] AR = new String[6];
                        AR[0] = request.getParameter("type");
                        AR[1] = request.getParameter("date");
                        AR[2] = request.getParameter("user");
                        AR[3] = ""+PO.getAccount().getIdaccount();
                        AR[4] = ""+PO.getBranch().getIdbranch();
                        AR[5] = request.getParameter("po");

                        request.getSession().setAttribute("p1", AR);
                        out.print("1");
                    } else {
                        out.print("2");

                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    out.print("2");
                }
                ses.close();

            }
        } else {

            request.getSession().removeAttribute("p1");
            if (request.getParameter("type").equals("") || request.getParameter("date").equals("") || request.getParameter("user").equals("") || request.getParameter("po").equals("")) {

                out.print("0");

            } else {
                Session ses = connection.getConnection.getSessionFactory().openSession();
                PurchaseInvoiceOrder PO;
                try {
                    PO = (PurchaseInvoiceOrder) ses.load(PurchaseInvoiceOrder.class, Integer.parseInt(request.getParameter("po")));
                    if (PO != null) {
                        String[] AR = new String[6];
                        AR[0] = request.getParameter("type");
                        AR[1] = request.getParameter("date");
                        AR[2] = request.getParameter("user");
                        AR[3] = ""+PO.getAccount().getIdaccount();
                        AR[4] = ""+PO.getBranch().getIdbranch();
                        AR[5] = request.getParameter("po");

                        request.getSession().setAttribute("p1", AR);
                        out.print("1");
                    } else {
                        out.print("2");

                    }

                } catch (Exception e) {
                    out.print("2");
                    e.printStackTrace();
                }
                ses.close();

            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
