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
import resources.Category;
import resources.ItemReorder;
import resources.SubCategory;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "updateROLServlet", urlPatterns = {"/updateROLServlet"})
public class updateROLServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        if (request.getSession().getAttribute("administrator") != null) {

            HttpSession mainses = request.getSession(true);
            User admin = (User) mainses.getAttribute("administrator");
            if (admin != null) {

                if (admin.getLevel() == 1) {

                    if (request.getParameter("id") == null || request.getParameter("id").equals("") 
                            || request.getParameter("name") == null || request.getParameter("name").equals("")
                            || request.getParameter("rol") == null || request.getParameter("rol").equals("")
                            || request.getParameter("empty") == null || request.getParameter("empty").equals("")
                            || request.getParameter("rolp") == null || request.getParameter("rolp").equals("")
                            ) {

                        out.print("0");

                    } else {
                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        int id = Integer.parseInt(request.getParameter("id"));
                        double rol = Double.parseDouble(request.getParameter("rol"));
                        double empty = Double.parseDouble(request.getParameter("empty"));
                        double rolp = Double.parseDouble(request.getParameter("rolp"));
                        Transaction tr = ses.beginTransaction();
                        ItemReorder de = (ItemReorder) ses.load(ItemReorder.class, id);

                        de.setRol(rol);
                        de.setAddIsEmpty(empty);
                        de.setAddReOrderPassed(rolp);
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
