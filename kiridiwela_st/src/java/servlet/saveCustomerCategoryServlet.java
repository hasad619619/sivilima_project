/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Account;
import resources.CustomerType;
import resources.CustomerTypeCustomer;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveCustomerCategoryServlet", urlPatterns = {"/saveCustomerCategoryServlet"})
public class saveCustomerCategoryServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            if (request.getSession().getAttribute("administrator") != null) {
                HttpSession mainses = request.getSession(true);
                User admin = (User) mainses.getAttribute("administrator");

                if (admin.getLevel() == 1 || admin.getLevel() == 2) {

                    if (request.getParameter("cust") == null || request.getParameter("cat") == null) {

                        out.print("0");

                    } else {
                        String custID = request.getParameter("cust");
                        String catID = request.getParameter("cat");

                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        CustomerType CUST_TYPE = (CustomerType) ses.load(CustomerType.class, Integer.parseInt(catID));
                        Account CUST = (Account) ses.load(Account.class, Integer.parseInt(custID));

                        Set<CustomerTypeCustomer> CTS = CUST.getCustomerTypeCustomers();
                        if (CTS.isEmpty()) {
                            Transaction tr = ses.beginTransaction();
                            CustomerTypeCustomer ad = new CustomerTypeCustomer();

                            ad.setCustomerType(CUST_TYPE);
                            ad.setAccount(CUST);
                            ad.setStatus(1);
                            ses.save(ad);
                            tr.commit();
                            out.print("1");
                        } else {

                            out.print("4");
                        }

                        ses.close();

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
