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
import javax.servlet.http.HttpSession;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Branch;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "updateUserServlet", urlPatterns = {"/updateUserServlet"})
public class updateUserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (request.getSession().getAttribute("administrator") != null) {

            HttpSession mainses = request.getSession(true);
            User admin = (User) mainses.getAttribute("administrator");
            if (admin != null) {

                if (admin.getLevel() == 1) {

                    try {
                        if (request.getParameter("branch") != null && !request.getParameter("branch").equals("")
                                && request.getParameter("level") != null && !request.getParameter("level").equals("")
                                && request.getParameter("name") != null && !request.getParameter("name").equals("")
                                && request.getParameter("contact") != null && !request.getParameter("contact").equals("")
                                && request.getParameter("username") != null && !request.getParameter("username").equals("")
                                && request.getParameter("id") != null && !request.getParameter("id").equals("")) {

                            int BRANCH_ID = Integer.parseInt(request.getParameter("branch"));
                            int LEVEL = Integer.parseInt(request.getParameter("level"));
                            int ID = Integer.parseInt(request.getParameter("id"));

                            String NAME = request.getParameter("name");
                            String CONTACT = request.getParameter("contact");;
                            String USERNAME = request.getParameter("username");

                            Session ses = connection.getConnection.getSessionFactory().openSession();
                            Transaction tr = ses.beginTransaction();

                            Branch BRANCH = (Branch) ses.load(Branch.class, BRANCH_ID);
                            User us = (User) ses.load(User.class, ID);
                            us.setName(NAME);
                            us.setContact(CONTACT);
                            us.setLevel(LEVEL);
                            us.setUsername(USERNAME);
                            us.setBranch(BRANCH);
                            us.setStatus(1);

                            ses.update(us);
                            tr.commit();
                            ses.close();
                            out.print(1);

                        } else {
                            out.print(0);
                        }
                    } catch (NumberFormatException | HibernateException e) {
                        new errorHandler().saveLog(e);

                    }

                } else {

                    out.print("3");

                }

            } else {

                out.print("3");

            }

        } else {
            out.print("4");

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
