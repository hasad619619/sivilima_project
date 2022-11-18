/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.helper;
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
import resources.Category;
import resources.ExpencessAccount;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveExpensesAccountServlet", urlPatterns = {"/saveExpensesAccountServlet"})
public class saveExpensesAccountServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            if (request.getSession().getAttribute("administrator") != null) {
                HttpSession mainses = request.getSession(true);
                User admin = (User) mainses.getAttribute("administrator");

                if (admin.getLevel() == 1 || admin.getLevel() == 2) {

                    String name = request.getParameter("name");
                    if (name.equals("")) {

                        out.print("0");

                    } else {

                        
                        helper help =  new helper();
                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        Transaction tr = ses.beginTransaction();
                        ExpencessAccount ad = new ExpencessAccount();
                        ad.setName(name);
                        ad.setStatus(1);
                        ad.setAddedDate(help.getDate());
                        ad.setAddedTime(help.getTime());
                        ad.setUser(admin);
                        ad.setBranch(admin.getBranch());
                        ses.save(ad);
                        tr.commit();
                        out.print("1");

                    }

                } else {

                    out.print("3");

                }

            } else {

                out.print("3");

            }

        } catch (Exception e) {

            e.printStackTrace();

        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    

}
