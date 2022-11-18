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
import resources.Shortcut;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveShortcutServlet", urlPatterns = {"/saveShortcutServlet"})
public class saveShortcutServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (request.getParameter("name").equals("") || request.getParameter("url").equals("")) {

                out.print("0");

            } else if (request.getSession().getAttribute("administrator") != null) {
                HttpSession mainses = request.getSession(true);
                User admin = (User) mainses.getAttribute("administrator");
                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                Shortcut ad = new Shortcut();

                ad.setName(request.getParameter("name"));
                ad.setUrl(request.getParameter("url"));
                ad.setUser(admin);
                ad.setStatus(1);
                ses.save(ad);
                tr.commit();
                out.print("1");
            } else {
                out.print("0");
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
