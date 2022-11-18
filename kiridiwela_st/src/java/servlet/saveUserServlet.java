/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.errorHandler;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Branch;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveUserServlet", urlPatterns = {"/saveUserServlet"})
public class saveUserServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if(request.getParameter("branch") != null && !  request.getParameter("branch").equals("") 
                    && request.getParameter("level") != null && !  request.getParameter("level").equals("") 
                    && request.getParameter("name") != null && !  request.getParameter("name").equals("")
                    && request.getParameter("contact") != null && !  request.getParameter("contact").equals("")
                    && request.getParameter("username") != null && !  request.getParameter("username").equals("")
                    && request.getParameter("password") != null && !  request.getParameter("password").equals("")
                    ){
                
                int BRANCH_ID=Integer.parseInt(request.getParameter("branch"));
                int LEVEL=Integer.parseInt(request.getParameter("level"));
                
                String NAME=request.getParameter("name");
                String CONTACT=request.getParameter("contact");
                String USERNAME=request.getParameter("username");
                String PASSWORD=request.getParameter("password");
                
                
                
                
                
                Session ses=connection.getConnection.getSessionFactory().openSession();
                Transaction tr=ses.beginTransaction();
                
                Branch BRANCH=(Branch) ses.load(Branch.class, BRANCH_ID);
                User us=new User();
                us.setName(NAME);
                us.setContact(CONTACT);
                us.setLevel(LEVEL);
                us.setUsername(USERNAME);
                us.setPassword(PASSWORD);
                us.setBranch(BRANCH);
                us.setStatus(1);
                
                
                ses.save(us);
                tr.commit();
                ses.close();
                out.print(1);
                
                
            }else{
                out.print(0);
            }
            
            
            
        } catch (NumberFormatException | HibernateException e) {
            new errorHandler().saveLog(e);
            
        }
    }

    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    

}
