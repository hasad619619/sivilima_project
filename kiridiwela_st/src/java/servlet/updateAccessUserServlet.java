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
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "updateAccessUserServlet", urlPatterns = {"/updateAccessUserServlet"})
public class updateAccessUserServlet extends HttpServlet {

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
        if (request.getParameter("id") == null || request.getParameter("id").equals("") || request.getParameter("id").equals("0")) {

            out.print("0");

        } else {

            try {
                Session ses=connection.getConnection.getSessionFactory().openSession();
                Transaction tr=ses.beginTransaction();
                int ID=Integer.parseInt(request.getParameter("id"));
                
                String ACCOUNT=request.getParameter("ac");
                String CREATE=request.getParameter("cr");
                String ADMIN=request.getParameter("ad");
                String INVOICING=request.getParameter("in");
                String STOCKS=request.getParameter("st");
                String ACCOUNTING=request.getParameter("acc");
                String CHEQUE=request.getParameter("ch");
                String OTHER=request.getParameter("ot");
                String REPORTS=request.getParameter("re");
                
                User user=(User) ses.load(User.class, ID);
                user.setAc(ACCOUNT);
                user.setCr(CREATE);
                user.setAd(ADMIN);
                user.setInv(INVOICING);
                user.setSt(STOCKS);
                user.setAc(ACCOUNT);
                user.setCh(CHEQUE);
                user.setRe(REPORTS);
                user.setOt(OTHER);
                user.setAcc(ACCOUNTING);
                ses.update(user);
                tr.commit();
                ses.close();
                
                out.print("1");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
