/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.invoiceModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "RemoveInvoiceServletI1", urlPatterns = {"/RemoveInvoiceServletI1"})
public class RemoveInvoiceServletI1 extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (request.getParameter("hash").equals("")) {

                out.print("0");

            } else {

                int hash = Integer.parseInt(request.getParameter("hash"));
                
                ArrayList<invoiceModel> invoice = new ArrayList();
                if (request.getSession().getAttribute("invoiceS") != null) {
                    invoice = (ArrayList<invoiceModel>) request.getSession().getAttribute("invoiceS");
                    invoice.remove(hash);
                    request.getSession().setAttribute("invoiceS",invoice);
                    out.print("1");
                    

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
