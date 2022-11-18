/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.errorHandler;
import dataclass.userHolder;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Account;
import resources.CustomerBranch;
import resources.User;

@WebServlet(name = "saveAccountServlet", urlPatterns = {"/saveAccountServlet"})
public class saveAccountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("name") != null && !request.getParameter("name").equals("") && request.getParameter("type") != null && !request.getParameter("type").equals("")) {
                String NAME = request.getParameter("name");
                int TYPE = Integer.parseInt(request.getParameter("type"));

                String CONTACT;
                String EMAIL;
                String ADDRESS;
                String REMARKS;

                double DEBIT_BALANCE = 0.0;
                double CREDIT_BALANCE = 0.0;
                double CREDIT_LIMIT;

                if (request.getParameter("contact") != null && !request.getParameter("contact").equals("")) {
                    CONTACT = request.getParameter("contact");
                } else {
                    CONTACT = "0000000000";
                }

                if (request.getParameter("email") != null && !request.getParameter("email").equals("")) {
                    EMAIL = request.getParameter("email");
                } else {
                    EMAIL = "N/A";
                }

                if (request.getParameter("address") != null && !request.getParameter("address").equals("")) {
                    ADDRESS = request.getParameter("address");
                } else {
                    ADDRESS = "N/A";
                }

                if (request.getParameter("remarks") != null && !request.getParameter("remarks").equals("")) {
                    REMARKS = request.getParameter("remarks");
                } else {
                    REMARKS = "N/A";
                }

                if (request.getParameter("credit") != null && !request.getParameter("credit").equals("")) {
                    CREDIT_LIMIT = Double.parseDouble(request.getParameter("credit"));
                } else {
                    CREDIT_LIMIT = 0.0;
                }

                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                Account ac = new Account();
                ac.setName(NAME);
                ac.setContact(CONTACT);
                ac.setEmail(EMAIL);
                ac.setAddress(ADDRESS);
                ac.setRemarks(REMARKS);
                ac.setCreditBalance(CREDIT_BALANCE);
                ac.setDebitBalance(DEBIT_BALANCE);
                ac.setCreditLimit(CREDIT_LIMIT);
                ac.setStatus(1);
                ac.setBalance(0.0);

                switch (TYPE) {
                    case 1:

                        ac.setBank(0);
                        ac.setCustomer(1);
                        ac.setSupplier(0);
                        ac.setEmployee(0);
                        ac.setExpences(0);

                        break;
                    case 2:

                        ac.setBank(0);
                        ac.setCustomer(0);
                        ac.setSupplier(1);
                        ac.setEmployee(0);
                        ac.setExpences(0);
                        break;
                    case 3:

                        ac.setBank(0);
                        ac.setCustomer(0);
                        ac.setSupplier(0);
                        ac.setEmployee(0);
                        ac.setExpences(1);
                        break;
                    case 4:

                        ac.setBank(0);
                        ac.setCustomer(0);
                        ac.setSupplier(0);
                        ac.setEmployee(1);
                        ac.setExpences(0);
                        break;
                    case 5:

                        ac.setBank(1);
                        ac.setCustomer(0);
                        ac.setSupplier(0);
                        ac.setEmployee(0);
                        ac.setExpences(0);
                        break;
                    default:

                        ac.setBank(0);
                        ac.setCustomer(0);
                        ac.setSupplier(0);
                        ac.setEmployee(0);
                        ac.setExpences(0);
                        break;
                }

                ses.save(ac);
                userHolder USER = null;

                if (request.getSession().getAttribute("userHolder") != null) {
                    USER = (userHolder) request.getSession().getAttribute("userHolder");
                    User US = (User) ses.load(User.class, USER.getId());
                    CustomerBranch cb = new CustomerBranch();
                    cb.setAccount(ac);
                    cb.setBranch(US.getBranch());
                    ses.save(cb);
                    
                }

                tr.commit();
                ses.close();
                out.print("1~" + ac.getIdaccount());

            } else {
                out.print("0~0");
            }

        } catch (NumberFormatException | HibernateException e) {
           out.print("0~0");

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
