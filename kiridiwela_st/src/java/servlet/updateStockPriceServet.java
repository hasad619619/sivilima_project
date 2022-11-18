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
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.CustomerType;
import resources.Stock;
import resources.StockPrice;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "updateStockPriceServet", urlPatterns = {"/updateStockPriceServet"})
public class updateStockPriceServet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            if (request.getParameter("st") == null || request.getParameter("st").equals("") || request.getParameter("cu") == null || request.getParameter("cu").equals("") || request.getParameter("price") == null || request.getParameter("price").equals("")) {

                out.print("0");

            } else if (request.getSession().getAttribute("administrator") != null) {

                HttpSession mainses = request.getSession(true);
                User admin = (User) mainses.getAttribute("administrator");
                if (admin != null) {

                    if (admin.getLevel() == 1) {
                        int STOCK_ID = Integer.parseInt(request.getParameter("st"));
                        int CUSTOMER_TYPE_ID = Integer.parseInt(request.getParameter("cu"));
                        double PRICE = Double.parseDouble(request.getParameter("price"));

                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        Transaction tr = ses.beginTransaction();

                        Stock SI = (Stock) ses.load(Stock.class, STOCK_ID);
                        CustomerType CT = (CustomerType) ses.load(CustomerType.class, CUSTOMER_TYPE_ID);

                        if (SI.getCost() > PRICE) {
                            out.print("2");

                        } else {
                            Set<StockPrice> SP = SI.getStockPrices();

                            if (SP.isEmpty()) {
                                StockPrice ST = new StockPrice();
                                ST.setPrice(PRICE);
                                ST.setStatus(1);
                                ST.setStock(SI);
                                ST.setCustomerType(CT);
                                ses.save(ST);
                                out.print("1");
                            } else {
                                StockPrice SPP = null;
                                for (StockPrice sp : SP) {

                                    if (sp.getCustomerType().getCustomerTypeId() == CUSTOMER_TYPE_ID) {
                                        SPP = sp;
                                    } else {

                                    }

                                }

                                if (SPP != null) {
                                    SPP.setPrice(PRICE);
                                    ses.update(SPP);
                                    out.print("1");

                                } else {
                                    StockPrice ST = new StockPrice();
                                    ST.setPrice(PRICE);
                                    ST.setStatus(1);
                                    ST.setStock(SI);
                                    ST.setCustomerType(CT);
                                    ses.save(ST);
                                    out.print("1");
                                }

                            }

                            tr.commit();
                            ses.close();

                        }
                    } else {
                        out.print("3");
                    }

                } else {
                    out.print("3");
                }
            } else {

                out.print("3");
            }
        } catch (IOException | NumberFormatException | HibernateException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
