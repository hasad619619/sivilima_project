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
import resources.Shortcut;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "deleteShortcutServlet", urlPatterns = {"/deleteShortcutServlet"})
public class deleteShortcutServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String id = request.getParameter("id").trim();
                if (id.equals("")) {

                    out.print("0");

                } else {

                    Session ses = connection.getConnection.getSessionFactory().openSession();
                    Transaction tr = ses.beginTransaction();
                    Shortcut de = (Shortcut) ses.load(Shortcut.class, Integer.parseInt(id));
                    de.setStatus(0);
                    

                    ses.update(de);
                    tr.commit();
                    ses.close();
                    out.print("1");

                }
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    

}
