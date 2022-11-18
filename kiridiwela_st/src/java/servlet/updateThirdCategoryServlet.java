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
import resources.SubCategory;
import resources.ThirdCategory;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "updateThirdCategoryServlet", urlPatterns = {"/updateThirdCategoryServlet"})
public class updateThirdCategoryServlet extends HttpServlet {

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
                            || request.getParameter("cat") == null || request.getParameter("cat").equals("")) {

                        out.print("0");

                    } else {

                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        String id = request.getParameter("id").trim();
                        String name = request.getParameter("name").trim();
                        String ct = request.getParameter("cat").trim();
                        SubCategory category=(SubCategory) ses.load(SubCategory.class, Integer.parseInt(ct));
                        Transaction tr = ses.beginTransaction();
                        ThirdCategory de = (ThirdCategory) ses.load(ThirdCategory.class, Integer.parseInt(id));

                        de.setName(name);
                        de.setSubCategory(category);
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
