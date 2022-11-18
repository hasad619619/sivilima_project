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
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import resources.Account;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "balanceAccountsServlet", urlPatterns = {"/balanceAccountsServlet"})
public class balanceAccountsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            PrintWriter out = response.getWriter();

            Session ses = connection.getConnection.getSessionFactory().openSession();
            Transaction tr = ses.beginTransaction();
            int A = 0;
            if (request.getParameter("q") != null) {
                A = Integer.parseInt(request.getParameter("q"));
            } else {
                A = 0;
            }

            if (A > 0) {

                Account CustAccount = (Account) ses.load(Account.class, A);

                double apita_ganna_mulu = CustAccount.getCreditBalance();
                double api_denna = CustAccount.getDebitBalance();
                double balance = CustAccount.getBalance();

                if (api_denna == 0 && balance == 0) {

                } else if (balance == 0) {

                    if (apita_ganna_mulu >= api_denna) {
                        CustAccount.setDebitBalance(0.0);
                        CustAccount.setCreditBalance(apita_ganna_mulu - api_denna);
                    } else {
                        CustAccount.setCreditBalance(0.0);
                        CustAccount.setDebitBalance(api_denna - apita_ganna_mulu);

                    }

                } else if (apita_ganna_mulu >= api_denna) {
                    double ithuru = apita_ganna_mulu - api_denna;

                    CustAccount.setDebitBalance(0.0);

                    if (ithuru >= balance) {
                        out.print("2");
                        CustAccount.setBalance(0.0);
                        CustAccount.setCreditBalance(ithuru - balance);
                    } else {
                        CustAccount.setBalance(balance - ithuru);
                        CustAccount.setCreditBalance(0.0);
                    }

                } else //api denna thiyana gaana > apita ganna thiyana mulu gaanata
                {
                    if (balance > 0) {
                        CustAccount.setCreditBalance(0.0);
                        CustAccount.setDebitBalance((api_denna - apita_ganna_mulu) + balance);
                        CustAccount.setBalance(0.0);
                    } else {

                        CustAccount.setCreditBalance(0.0);
                        CustAccount.setDebitBalance(api_denna - apita_ganna_mulu);
                    }
                }

                ses.update(CustAccount);
                CustAccount.setCreditBalance((double) Math.round(CustAccount.getCreditBalance() * 100) / 100);
                CustAccount.setDebitBalance((double) Math.round(CustAccount.getDebitBalance() * 100) / 100);
                CustAccount.setBalance((double) Math.round(CustAccount.getBalance() * 100) / 100);
                tr.commit();
                ses.close();
                out.print("1");

            } else {

                Criteria cr = ses.createCriteria(Account.class);
                cr.add(Restrictions.eq("status", 1));
                List<Account> ac_list = cr.list();
                for (Account CustAccount : ac_list) {

                    double apita_ganna_mulu = CustAccount.getCreditBalance();
                    double api_denna = CustAccount.getDebitBalance();
                    double balance = CustAccount.getBalance();

                    if (api_denna == 0 && balance == 0) {

                    } else if (balance == 0) {

                        if (apita_ganna_mulu >= api_denna) {
                            CustAccount.setDebitBalance(0.0);
                            CustAccount.setCreditBalance(apita_ganna_mulu - api_denna);
                        } else {
                            CustAccount.setCreditBalance(0.0);
                            CustAccount.setDebitBalance(api_denna - apita_ganna_mulu);

                        }

                    } else if (apita_ganna_mulu >= api_denna) {
                        double ithuru = apita_ganna_mulu - api_denna;

                        CustAccount.setDebitBalance(0.0);

                        if (ithuru >= balance) {
                            CustAccount.setBalance(0.0);
                            CustAccount.setCreditBalance(ithuru - balance);
                        } else {
                            CustAccount.setBalance(balance - ithuru);
                            CustAccount.setCreditBalance(0.0);
                        }

                    } else //api denna thiyana gaana > apita ganna thiyana mulu gaanata
                    if (balance > 0) {
                        CustAccount.setCreditBalance(0.0);
                        CustAccount.setDebitBalance((api_denna - apita_ganna_mulu) + balance);
                        CustAccount.setBalance(0.0);
                    } else {

                        CustAccount.setCreditBalance(0.0);
                        CustAccount.setDebitBalance(api_denna - apita_ganna_mulu);
                    }

                    ses.update(CustAccount);
                    CustAccount.setCreditBalance((double) Math.round(CustAccount.getCreditBalance() * 100) / 100);
                    CustAccount.setDebitBalance((double) Math.round(CustAccount.getDebitBalance() * 100) / 100);
                    CustAccount.setBalance((double) Math.round(CustAccount.getBalance() * 100) / 100);
                }

                tr.commit();
                ses.close();
                out.print("1");

            }
        } catch (IOException | HibernateException | NumberFormatException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
