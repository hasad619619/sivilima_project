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
import resources.EmployeeAccount;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "updateEmployeeAccountServlet", urlPatterns = {"/updateEmployeeAccountServlet"})
public class updateEmployeeAccountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        if (request.getSession().getAttribute("administrator") != null) {

            HttpSession mainses = request.getSession(true);
            User admin = (User) mainses.getAttribute("administrator");
            if (admin != null) {

                if (admin.getLevel() == 1) {
                    String id = request.getParameter("id").trim();
                    String name = request.getParameter("name").trim();

                    if (id.equals("") || name.equals("")) {

                        out.print("0");

                    } else {

                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        Transaction tr = ses.beginTransaction();
                        EmployeeAccount de = (EmployeeAccount) ses.load(EmployeeAccount.class, Integer.parseInt(id));

                        de.setName(name);
                        de.setStatus(1);
                        ses.update(de);
                        tr.commit();
                        ses.close();

                        out.print("1");

                    }

                } else {

                    out.print("3");

                }

            } else {

                out.print("3");

            }

        } else {

            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
