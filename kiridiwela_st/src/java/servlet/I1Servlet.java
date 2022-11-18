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
@WebServlet(name = "I1Servlet", urlPatterns = {"/I1Servlet"})
public class I1Servlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getSession().getAttribute("i1") == null) {
            if (request.getParameter("type").equals("") ||  request.getParameter("cust").equals("")) {

                out.print("0");

            } else {
                String[] AR = new String[4];
                AR[1] = request.getParameter("type");
                AR[0] = request.getParameter("cust");
                Session ses=connection.getConnection.getSessionFactory().openSession();
                Account ac=(Account) ses.load(Account.class, Integer.parseInt(request.getParameter("cust")));
                AR[2] ="(credit limit RS:"+ac.getCreditLimit()+")(credit sales RS:"+ac.getCreditBalance()+")";
                ses.close();
                
                
                request.getSession().setAttribute("i1", AR);
                out.print("1");
            }
        } else {

            request.getSession().removeAttribute("i1");
            if (request.getParameter("type").equals("") || request.getParameter("cust").equals("")) {

                out.print("0");

            } else {
                String[] AR = new String[4];
                AR[1] = request.getParameter("type");
                AR[0] = request.getParameter("cust");
                Session ses=connection.getConnection.getSessionFactory().openSession();
                Account ac=(Account) ses.load(Account.class, Integer.parseInt(request.getParameter("cust")));
                AR[2] ="(credit limit RS:"+ac.getCreditLimit()+")(credit sales RS:"+ac.getCreditBalance()+")";
                ses.close();
                
                request.getSession().setAttribute("i1", AR);
                out.print("1");
            }

        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    

}
