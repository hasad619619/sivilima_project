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
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "viewUserServlet", urlPatterns = {"/viewUserServlet"})
public class viewUserServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("id") != null && !request.getParameter("id").equals("")) {
            int ID = Integer.parseInt(request.getParameter("id"));
            Session ses = connection.getConnection.getSessionFactory().openSession();
            User ac = (User) ses.load(User.class, ID);
            
                    
            
            out.print("<div class=\"col-md-6\">");
            out.print("<p><span class=\"font-weight-bold\">Name:</span>"+ac.getName()+"</p>");
            out.print("<p><span class=\"font-weight-bold\">Contact:</span>"+ac.getContact()+"</p>");
            out.print("<p><span class=\"font-weight-bold\">Username no:</span>"+ac.getUsername()+"</p>");
            out.print("<p><span class=\"font-weight-bold\">Branch:</span>"+ac.getBranch().getName() +"</p>");
            if(ac.getLevel()==1){
            out.print("<p><span class=\"font-weight-bold\">Acces Level: </span>"+"Administrator"+"</p>");
            }else{
            
            out.print("<p><span class=\"font-weight-bold\">Acces Level: </span>"+"Inspector"+"</p>");
            }
            
            
            
            
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
