/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Set;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import resources.Account;
import resources.CustomerTypeCustomer;
import resources.Items;
import resources.Stock;
import resources.StockPrice;
import resources.TypeCalc;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "getItemPriceAsCustomer", urlPatterns = {"/getItemPriceAsCustomer"})
public class getItemPriceAsCustomer extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (request.getParameter("itemid") == null || request.getParameter("itemid").equals("")
                    || request.getParameter("stockid") == null || request.getParameter("stockid").equals("")
                    || request.getParameter("mesid") == null || request.getParameter("mesid").equals("-1")
                    || request.getParameter("cust") == null || request.getParameter("cust").equals("")) {

                out.print("0-0");

            } else {
                try {
                    Session ses = connection.getConnection.getSessionFactory().openSession();
                    Items ITEM = (Items) ses.load(Items.class, Integer.parseInt(request.getParameter("itemid")));
                    Stock STOCK = (Stock) ses.load(Stock.class, Integer.parseInt(request.getParameter("stockid")));
                    Account CUSTOMER = (Account) ses.load(Account.class, Integer.parseInt(request.getParameter("cust")));
                    int messid = Integer.parseInt(request.getParameter("mesid"));
                    TypeCalc MESSTYPE = null ;
                    if (messid > 0) {
                        MESSTYPE = (TypeCalc) ses.load(TypeCalc.class, Integer.parseInt(request.getParameter("mesid")));
                    }
                    double PRICE = 0.0;
                    if (messid == 0) {
                        Set<CustomerTypeCustomer> CT = CUSTOMER.getCustomerTypeCustomers();

                        if (CT.size() == 1) {
                            for (CustomerTypeCustomer CTT : CT) {
                                int TYPE = CTT.getIdcustomerTypeCustomer();
                                Set<StockPrice> stockPrices = STOCK.getStockPrices();
                                if (stockPrices.isEmpty()){
                                    
                                    PRICE = STOCK.getPrice();
                                } else {
                                    for (StockPrice SP : stockPrices) {
                                        
                                        if (SP.getCustomerType().getCustomerTypeId() == TYPE && SP.getStatus() == 1) {
                                            PRICE = SP.getPrice();
                                            
                                        } 
                                    }
                                    if(PRICE == 0.0){
                                    PRICE = STOCK.getPrice();
                                    }
                                }

                            }
                        } else if (CT.size() > 1 | CT.isEmpty()) {
                            PRICE = STOCK.getPrice();
                        }
                    } else {
                        //is messuring equlation available
                        

                        Set<CustomerTypeCustomer> CT = CUSTOMER.getCustomerTypeCustomers();

                        if (CT.size() == 1) {
                            for (CustomerTypeCustomer CTT : CT) {
                                int TYPE = CTT.getIdcustomerTypeCustomer();
                                Set<StockPrice> stockPrices = STOCK.getStockPrices();
                                if (stockPrices.isEmpty()) {
                                    PRICE = STOCK.getPrice();
                                } else {
                                    for (StockPrice SP : stockPrices) {
                                        if (SP.getCustomerType().getCustomerTypeId() == TYPE && SP.getStatus() == 1) {
                                            PRICE = SP.getPrice();
                                            System.out.println("A");
                                        } 
                                    }
                                    if(PRICE == 0.0){
                                    PRICE = STOCK.getPrice();
                                    }
                                }

                            }
                        } else if (CT.size() > 1 | CT.isEmpty()) {
                            PRICE = STOCK.getPrice();
                        }
                        ScriptEngineManager mgr = new ScriptEngineManager();
                        ScriptEngine engine = mgr.getEngineByName("JavaScript");
                        String foo2 = (PRICE + "*" + MESSTYPE.getFormula());

                        double NEWPRICE = Double.parseDouble(engine.eval(foo2).toString());
                        BigDecimal bd = new BigDecimal(NEWPRICE);
                        bd = bd.setScale(2, RoundingMode.HALF_UP);
                        NEWPRICE = bd.doubleValue();
                        PRICE=NEWPRICE;

                    }

                    out.print("1-" + PRICE);
                    ses.close();
                } catch (HibernateException | NumberFormatException | ScriptException e) {
                    e.printStackTrace();
                    out.print("0-0");
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
