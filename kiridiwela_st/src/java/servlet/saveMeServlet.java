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
import resources.Account;
import resources.Mess;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveMeServlet", urlPatterns = {"/saveMeServlet"})
public class saveMeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            if (request.getSession().getAttribute("administrator") != null) {
                HttpSession mainses = request.getSession(true);
                User admin = (User) mainses.getAttribute("administrator");

                if (admin.getLevel() == 1 || admin.getLevel() == 2) {

                    if (request.getParameter("c") == null || request.getParameter("c").equals("") || request.getParameter("e") == null || request.getParameter("e").equals("")
                           
                            || request.getParameter("d") == null || request.getParameter("d").equals("")) {

                        out.print("0");

                    } else {
                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        int c = Integer.parseInt(request.getParameter("c"));
                        int e = Integer.parseInt(request.getParameter("e"));
                        Account customer=(Account) ses.load(Account.class, c);
                        Account employee=(Account) ses.load(Account.class, e);
                        
                        String Date=request.getParameter("d");
                        String Remarks="N/A";
                        if(request.getParameter("r") != null && ! request.getParameter("c").equals("")){
                            Remarks=request.getParameter("r");
                        }
                        
                        Transaction tr = ses.beginTransaction();
                        Mess ad = new Mess();
                        ad.setAccountByCustomer(customer);
                        ad.setAccountByEmployee(employee);
                        ad.setDate(Date);
                        ad.setRemarks(Remarks);
                        ad.setStatus(1);
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
