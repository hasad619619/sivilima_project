/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.helper;
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
import resources.Branch;
import resources.Stock;
import resources.StockDamage;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveDamageServlet", urlPatterns = {"/saveDamageServlet"})
public class saveDamageServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            if (request.getSession().getAttribute("administrator") != null) {
                HttpSession mainses = request.getSession(true);
                User admin = (User) mainses.getAttribute("administrator");

                if (admin.getLevel() == 1) {

                    String com = request.getParameter("com");
                    String qtt = request.getParameter("qty");
                    String sup = request.getParameter("sup");
                    
                    if (qtt.equals("") || sup.equals("") || sup.equals("0") ) {

                        out.print("0");

                    } else {

                        if (com.equals("")) {
                            com = "N/A";
                        }

                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        Transaction tr = ses.beginTransaction();

                        Stock item = (Stock) ses.load(Stock.class, Integer.parseInt(sup));
                        
                        Stock CURRST = item;

                        if (CURRST != null) {
                            if (CURRST.getQty() >= Double.parseDouble(qtt)) {
                                StockDamage ad = new StockDamage();
                                ad.setQty(Integer.parseInt(qtt));
                                ad.setDate(new helper().getDate());
                                ad.setComment(com);
                                ad.setBranch(item.getBranch());
                                ad.setStock(item);
                                ad.setStatus(1);
                                ses.save(ad);
                                tr.commit();
                                out.print("1");
                            } else {
                                out.print("5");
                            }
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

             out.print("4");

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
