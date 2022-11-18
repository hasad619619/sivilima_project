/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import resources.Account;
import resources.ChequeBook;
import resources.SubCategory;
import resources.ThirdCategory;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveChequeBookServlet", urlPatterns = {"/saveChequeBookServlet"})
public class saveChequeBookServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            if (request.getSession().getAttribute("administrator") != null) {
                HttpSession mainses = request.getSession(true);
                User admin = (User) mainses.getAttribute("administrator");

                if (admin.getLevel() == 1 || admin.getLevel() == 2) {

                    if (request.getParameter("name") == null || request.getParameter("name").equals("") || request.getParameter("sct") == null) {

                        out.print("0");

                    } else {
                        boolean flag = false;
                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        String name = request.getParameter("name");
                        String ct = request.getParameter("sct");
                        Account category=(Account) ses.load(Account.class, Integer.parseInt(ct));
                        Criteria cr = ses.createCriteria(ChequeBook.class);
                        cr.add(Restrictions.eq("status", 1));
                        List<ChequeBook> list = cr.list();
                        for (ChequeBook LI : list) {
                            if (name.equals(LI.getChequeNumber()) && ct.equals(LI.getAccount().getIdaccount().toString())) {
                                flag = true;
                            }

                        }

                        if (!flag) {
                        Transaction tr = ses.beginTransaction();
                        ChequeBook ad = new ChequeBook();

                        ad.setChequeNumber(name);
                        ad.setAccount(category);
                        ad.setStatus(1);
                        ses.save(ad);
                        tr.commit();
                        out.print("1");
                        
                        }else{
                             out.print("4");
                            
                        }

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
