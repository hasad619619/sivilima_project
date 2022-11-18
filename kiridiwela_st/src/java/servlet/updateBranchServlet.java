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
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Branch;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "updateBranchServlet", urlPatterns = {"/updateBranchServlet"})
public class updateBranchServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("name") != null && !request.getParameter("name").equals("")
                    && request.getParameter("contact") != null && !request.getParameter("contact").equals("")
                    && request.getParameter("email") != null && !request.getParameter("email").equals("")
                    && request.getParameter("address") != null && !request.getParameter("address").equals("")
                    && request.getParameter("fax") != null && !request.getParameter("fax").equals("")
                    && request.getParameter("id") != null && !request.getParameter("id").equals("")
                    && request.getParameter("image") != null && !request.getParameter("image").equals("")) {
                
                Session ses=connection.getConnection.getSessionFactory().openSession();
                Transaction tr=ses.beginTransaction();
                
                Branch br=(Branch) ses.load(Branch.class, Integer.parseInt(request.getParameter("id")));
                br.setName(request.getParameter("name"));
                br.setStatus(1);
                br.setEmail(request.getParameter("email"));
                br.setContact(request.getParameter("contact"));
                br.setFax(request.getParameter("fax"));
                br.setAddress(request.getParameter("address"));
                br.setImage(request.getParameter("image"));
                ses.update(br);
                tr.commit();
                ses.close();
                out.print("1~"+br.getIdbranch());
                
                
            } else {
                out.print("0~0");
            }
            
        } catch (Exception e) {
            
            out.print("0~0");
            
        }
    }

    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    

}
