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
import resources.CustomerType;
import resources.CustomerTypeCustomer;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "updateCustomerCategoryServlet", urlPatterns = {"/updateCustomerCategoryServlet"})
public class updateCustomerCategoryServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        if (request.getSession().getAttribute("administrator") != null) {

            HttpSession mainses = request.getSession(true);
            User admin = (User) mainses.getAttribute("administrator");
            if (admin != null) {

                if (admin.getLevel() == 1) {
                    String id = request.getParameter("id").trim();
                    String type = request.getParameter("type").trim();

                    if (id.equals("") || type.equals("")) {

                        out.print("0");

                    } else {

                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        Transaction tr = ses.beginTransaction();
                        CustomerTypeCustomer de = (CustomerTypeCustomer) ses.load(CustomerTypeCustomer.class, Integer.parseInt(id));
                        CustomerType CT=(CustomerType) ses.load(CustomerType.class, Integer.parseInt(type));
                        de.setCustomerType(CT);
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
