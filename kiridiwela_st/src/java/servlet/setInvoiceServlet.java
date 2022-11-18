/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.invoiceModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import resources.Stock;
import resources.TypeCalc;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "setInvoiceServlet", urlPatterns = {"/setInvoiceServlet"})
public class setInvoiceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("stockid").equals("") || request.getParameter("stockid").equals("0")
                || request.getParameter("itemID").equals("") || request.getParameter("itemID").equals("0")
                || request.getParameter("qty").equals("") || request.getParameter("qty").equals("0")
                || request.getParameter("discount").equals("") || request.getParameter("discount").equals("0.0")
                || request.getParameter("price").equals("") || request.getParameter("price").equals("0.0")
                || request.getParameter("mess").equals("")) {

            out.print("0");

        } else {

            int STOCK_ID = Integer.parseInt(request.getParameter("stockid"));
            int ITEM_ID = Integer.parseInt(request.getParameter("itemID"));
            int MESS_ID = Integer.parseInt(request.getParameter("mess"));
            double PRICE = Double.parseDouble(request.getParameter("price"));
            double QTY = Double.parseDouble(request.getParameter("qty"));
            double DISCOUNT = Double.parseDouble(request.getParameter("discount"));
            double CHCK_QTYN = 0.0;

            ArrayList<invoiceModel> invoice = new ArrayList<invoiceModel>();

            Session ses = connection.getConnection.getSessionFactory().openSession();
            Stock STOCK = (Stock) ses.load(Stock.class, STOCK_ID);

            if (request.getSession().getAttribute("invoiceS") != null) {

                invoice = (ArrayList<invoiceModel>) request.getSession().getAttribute("invoiceS");
                for (invoiceModel IM : invoice) {
                    if (IM.getStockID() == STOCK_ID) {
                        CHCK_QTYN = CHCK_QTYN + IM.getQty_original();
                    }
                }
                if (MESS_ID != 0) {

                    TypeCalc CALC = (TypeCalc) ses.load(TypeCalc.class, MESS_ID);
                    String EQ = CALC.getFormula();

                    if (EQ != null) {
                        try {
                            ScriptEngineManager mgr = new ScriptEngineManager();
                            ScriptEngine engine = mgr.getEngineByName("JavaScript");
                            String foo = QTY + "*" + EQ;
                            String foo2 = (STOCK.getCost()) + "*" + EQ;

                            double NEWQTT = Double.parseDouble(engine.eval(foo).toString());
                            double NEWCOST = Double.parseDouble(engine.eval(foo2).toString());
                            if (STOCK.getQty() >= (CHCK_QTYN + NEWQTT)) {
                                if (NEWCOST < PRICE) {
                                    try {
                                        invoiceModel IM = new invoiceModel();
                                        IM.setBranch(STOCK.getBranch().getName());
                                        IM.setItemName(STOCK.getItems().getName());
                                        IM.setPrice(PRICE);
                                        IM.setQty(QTY);
                                        IM.setType(CALC.getTypeByType2().getName());
                                        IM.setStockID(STOCK_ID);
                                        IM.setItemID(ITEM_ID);

                                        BigDecimal BD_PRICE = new BigDecimal(PRICE);
                                        BigDecimal BD_QTY = new BigDecimal(QTY);
                                        BigDecimal BD_TOTAL = BD_PRICE.multiply(BD_QTY);
                                        IM.setDescount(DISCOUNT);
                                        IM.setTotal_descount(DISCOUNT * QTY);
                                        IM.setTotal(BD_TOTAL.doubleValue());
                                        IM.setQty_original(NEWQTT);
                                        IM.setCost(STOCK.getCost());
                                        invoice.add(IM);
                                        request.getSession().removeAttribute("invoiceS");
                                        request.getSession().setAttribute("invoiceS", invoice);
                                        out.print("1");
                                    } catch (Exception e) {
                                        out.print("4");
                                    }
                                } else {
                                    out.print("3");
                                }
                            } else {
                                out.print("2");
                            }

                        } catch (ScriptException | NumberFormatException e) {
                            out.print("4");
                        }
                    } else {
                        out.print("4");
                    }
                } else if (STOCK.getQty() >= (CHCK_QTYN + QTY)) {

                    if (STOCK.getCost() < PRICE) {
                        invoiceModel IM = new invoiceModel();
                        IM.setBranch(STOCK.getBranch().getName());
                        IM.setItemName(STOCK.getItems().getName());
                        IM.setPrice(PRICE);
                        IM.setQty(QTY);
                        IM.setStockID(STOCK_ID);
                        IM.setItemID(STOCK.getItems().getItemId());
                        IM.setQty_original(QTY);
                        IM.setType(STOCK.getItems().getType().getName());
                        BigDecimal BD_PRICE = new BigDecimal(PRICE);
                        BigDecimal BD_QTY = new BigDecimal(QTY);
                        BigDecimal BD_TOTAL = BD_PRICE.multiply(BD_QTY);
                        IM.setDescount(DISCOUNT);
                        IM.setTotal_descount(DISCOUNT * QTY);
                        IM.setTotal(BD_TOTAL.doubleValue());
                        IM.setTotal(BD_TOTAL.doubleValue());
                        IM.setCost(STOCK.getCost());
                        invoice.add(IM);
                        request.getSession().removeAttribute("invoiceS");
                        request.getSession().setAttribute("invoiceS", invoice);
                        out.print("1");

                    } else {
                        out.print("3");
                    }

                } else {
                    out.print("2");

                }
            } else if (MESS_ID != 0) {
                TypeCalc CALC = (TypeCalc) ses.load(TypeCalc.class, MESS_ID);
                String EQ = CALC.getFormula();
                if (EQ != null) {
                    try {
                        ScriptEngineManager mgr = new ScriptEngineManager();
                        ScriptEngine engine = mgr.getEngineByName("JavaScript");
                        String foo = QTY + "*" + EQ;
                        double NEWQTT = Double.parseDouble(engine.eval(foo).toString());
                        String foo2 = (STOCK.getCost()) + "*" + EQ;

                        double NEWCOST = Double.parseDouble(engine.eval(foo2).toString());
                        if (STOCK.getQty() >= NEWQTT) {
                            if (NEWCOST < PRICE) {
                                invoiceModel IM = new invoiceModel();
                                IM.setBranch(STOCK.getBranch().getName());
                                IM.setItemName(STOCK.getItems().getName());
                                IM.setPrice(PRICE);
                                IM.setType(CALC.getTypeByType2().getName());
                                IM.setQty(QTY);
                                IM.setStockID(STOCK_ID);
                                IM.setItemID(STOCK.getItems().getItemId());
                                BigDecimal BD_PRICE = new BigDecimal(PRICE);
                                BigDecimal BD_QTY = new BigDecimal(QTY);
                                BigDecimal BD_TOTAL = BD_PRICE.multiply(BD_QTY);
                                IM.setTotal(BD_TOTAL.doubleValue());
                                IM.setQty_original(NEWQTT);
                                IM.setDescount(DISCOUNT);
                                IM.setTotal_descount(DISCOUNT * QTY);
                                IM.setTotal(BD_TOTAL.doubleValue());
                                IM.setCost(STOCK.getCost());
                                invoice.add(IM);
                                request.getSession().setAttribute("invoiceS", invoice);
                                out.print("1");
                            } else {
                                out.print("3");
                            }
                        } else {
                            out.print("2");
                        }

                    } catch (ScriptException | NumberFormatException e) {
                        out.print("4");
                    }
                } else {
                    out.print("4");
                }
            } else {

                double CHCK_QTY = QTY;

                if (STOCK.getQty() >= CHCK_QTY) {
                    if (STOCK.getCost() < PRICE) {
                        invoiceModel IM = new invoiceModel();
                        IM.setBranch(STOCK.getBranch().getName());
                        IM.setItemName(STOCK.getItems().getName());
                        IM.setPrice(PRICE);
                        IM.setQty(QTY);
                        IM.setStockID(STOCK_ID);
                        IM.setItemID(STOCK.getItems().getItemId());
                        IM.setQty_original(QTY);
                        IM.setType(STOCK.getItems().getType().getName());
                        BigDecimal BD_PRICE = new BigDecimal(PRICE);
                        BigDecimal BD_QTY = new BigDecimal(QTY);
                        BigDecimal BD_TOTAL = BD_PRICE.multiply(BD_QTY);
                        IM.setTotal(BD_TOTAL.doubleValue());
                        IM.setCost(STOCK.getCost());
                        IM.setDescount(DISCOUNT);
                        IM.setTotal_descount(DISCOUNT * QTY);
                        IM.setTotal(BD_TOTAL.doubleValue());
                        invoice.add(IM);
                        request.getSession().setAttribute("invoiceS", invoice);
                        out.print("1");
                    } else {
                        out.print("3");
                    }

                } else {
                    out.print("2");

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
