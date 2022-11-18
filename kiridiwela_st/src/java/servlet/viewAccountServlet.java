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
import resources.Account;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "viewAccountServlet", urlPatterns = {"/viewAccountServlet"})
public class viewAccountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("id") != null && !request.getParameter("id").equals("")) {
            int ID = Integer.parseInt(request.getParameter("id"));
            Session ses = connection.getConnection.getSessionFactory().openSession();
            Account ac = (Account) ses.load(Account.class, ID);
            
                    
            
            out.print("<div class=\"col-md-6\">");
            out.print("<p><span class=\"font-weight-bold\">Name:</span>"+ac.getName()+"</p>");
            out.print("<p><span class=\"font-weight-bold\">Address:</span>"+ac.getAddress()+"</p>");
            out.print("<p><span class=\"font-weight-bold\">Contact no:</span>"+ac.getContact()+"</p>");
            out.print("<p><span class=\"font-weight-bold\">Email:</span>"+ac.getEmail()+"</p>");
            out.print("<p><span class=\"font-weight-bold\">Receivable Amount:RS </span>"+ac.getCreditBalance()+"</p>");
            out.print("<p><span class=\"font-weight-bold\">Payable Amount:RS </span>"+ac.getDebitBalance()+"</p>");
            out.print("</div>");
            out.print("<div class=\"col-md-6\">");
            out.print("<p><span class=\"font-weight-bold\">Account Types:</span></p>");
            if(ac.getBank()==1){
                out.print("<p><span class=\"badge badge-dark\">bank</span></p>"); 
            }
            if(ac.getCustomer()==1){
                out.print("<p><span class=\"badge badge-primary\">customer</span></p>"); 
            }
            if(ac.getSupplier()==1){
                out.print("<p><span class=\"badge badge-secondary\">supplier</span></p>"); 
            }
            if(ac.getExpences()==1){
                out.print("<p><span class=\"badge badge-success\">expences</span></p>"); 
            }
            if(ac.getEmployee()==1){
                out.print("<p><span class=\"badge badge-warning\">employee</span></p>"); 
            }
            out.print("</div>");
            
            
            
        } else {

            out.print("<div class=\"col-md-6\">");
            out.print("<p>no any data found on server</p>");
            out.print("</div>");

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
