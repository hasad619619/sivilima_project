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
import org.hibernate.Transaction;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "changeUserPasswordServlet", urlPatterns = {"/changeUserPasswordServlet"})
public class changeUserPasswordServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("id").equals("") || request.getParameter("op").equals("") || request.getParameter("np").equals("")) {

            out.print(0);

        } else {
            int id=Integer.parseInt(request.getParameter("id"));
            String OP=request.getParameter("op");
            String NP=request.getParameter("np");
            Session ses=connection.getConnection.getSessionFactory().openSession();
            Transaction tr=ses.beginTransaction();
            User us=(User) ses.load(User.class, id);
            if(us.getPassword().equals(OP)){
                us.setPassword(NP);
                ses.update(us);
                out.print("1");
                
            }else{
                out.print("2");
            
            }
         
            tr.commit();
            ses.close();
            
        }
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


}
