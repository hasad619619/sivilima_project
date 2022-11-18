/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
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
import resources.Branch;
import resources.Items;
import resources.ReturnItem;
import resources.Stock;
import resources.StockDamage;
import resources.StockReturn;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "returnDamageServlet", urlPatterns = {"/returnDamageServlet"})
public class returnDamageServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            if (request.getParameter("id").equals("")) {

                out.print("0");

            } else {

                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                HttpSession mainses = request.getSession(true);
                User admin = (User) mainses.getAttribute("administrator");
                StockDamage SD = (StockDamage) ses.load(StockDamage.class, Integer.parseInt(request.getParameter("id")));

                if (SD != null) {

                    if (SD.getStatus() == 1) {

                        double qty = SD.getQty();
                        Stock item = SD.getStock();
                        String date = SD.getDate();
                        Branch branch = SD.getBranch();
                        

                        BigDecimal cost = new BigDecimal(item.getCost());
                        BigDecimal QTT = new BigDecimal(qty);
                        BigDecimal B = QTT.multiply(cost);

                        double total = B.doubleValue();

                        if (true) {

                            Stock CURRST = item;

                            if (true) {
                                if (CURRST.getQty() >= qty) {
                                    double newQty=CURRST.getQty() - qty;
                                    CURRST.setQty((double) Math.round(newQty * 100) / 100);

                                    StockReturn SR = new StockReturn();
                                    SR.setDate(date);
                                    SR.setAmount(total);
                                    SR.setAccount(CURRST.getItems().getAccount());
                                    SR.setStatus(1);
                                    SR.setUser(admin);
                                    SR.setBranch(admin.getBranch());
                                    ses.save(SR);

                                    ReturnItem RI = new ReturnItem();
                                    RI.setQtt(qty);
                                    RI.setCost(item.getCost());
                                    RI.setAmount(total);
                                    RI.setStockReturn(SR);
                                    RI.setStock(item);
                                    RI.setBranch(branch);
                                    RI.setStatus(1);
                                    ses.save(RI);

                                    SD.setStatus(2);
                                    ses.update(SD);
                                    ses.update(CURRST);
                                    tr.commit();
                                    ses.close();

                                    out.print("1");
                                } else {
                                    out.print("5");
                                }
                            } else {
                                out.print("4");
                            }

                        } else {
                            out.print("4");
                        }

                    } else {

                        out.print("7");

                    }
                } else {
                    out.print("0");
                }

            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
