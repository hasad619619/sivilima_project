/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.errorHandler;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Account;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "updateAccountServlet", urlPatterns = {"/updateAccountServlet"})
public class updateAccountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (request.getSession().getAttribute("administrator") != null) {

            HttpSession mainses = request.getSession(true);
            User admin = (User) mainses.getAttribute("administrator");
            if (admin != null) {

                if (admin.getLevel() == 1) {

                    try {
                        if (request.getParameter("name") != null && !request.getParameter("name").equals("")  && request.getParameter("id") != null && !request.getParameter("id").equals("")) {
                            String NAME = request.getParameter("name");
                            int ID = Integer.parseInt(request.getParameter("id"));

                            String CONTACT;
                            String EMAIL;
                            String ADDRESS;
                            String REMARKS;
                            
                            int cu,su,ex,em,ba;

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
                            if (request.getParameter("cu") != null && request.getParameter("cu").equals("1")) {
                                cu=1;
                            } else {
                                cu=0;
                            }
                            if (request.getParameter("su") != null && request.getParameter("su").equals("1")) {
                                su=1;
                            } else {
                                su=0;
                            }
                            if (request.getParameter("ex") != null && request.getParameter("ex").equals("1")) {
                                ex=1;
                            } else {
                                ex=0;
                            }
                            if (request.getParameter("em") != null && request.getParameter("em").equals("1")) {
                                em=1;
                            } else {
                                em=0;
                            }
                            if (request.getParameter("ba") != null && request.getParameter("ba").equals("1")) {
                                ba=1;
                            } else {
                                ba=0;
                            }
                            System.out.println(ba);

                            Session ses = connection.getConnection.getSessionFactory().openSession();
                            Transaction tr = ses.beginTransaction();
                            Account ac = (Account) ses.load(Account.class, ID);
                            ac.setName(NAME);
                            ac.setContact(CONTACT);
                            ac.setEmail(EMAIL);
                            ac.setAddress(ADDRESS);
                            ac.setRemarks(REMARKS);
                            ac.setCreditLimit(CREDIT_LIMIT);
                            ac.setCustomer(cu);
                            ac.setSupplier(su);
                            ac.setExpences(ex);
                            ac.setEmployee(em);
                            ac.setBank(ba);
                            ac.setStatus(1);
                         
                            ses.update(ac);
                            tr.commit();
                            ses.close();
                            out.print(1);

                        } else {
                            out.print(0);
                        }

                    } catch (NumberFormatException | HibernateException e) {
                        new errorHandler().saveLog(e);

                    }

                } else {

                    out.print("3");

                }

            } else {

                out.print("3");

            }

        } else {
            out.print("4");

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
