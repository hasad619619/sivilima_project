/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "getStockCostServlet", urlPatterns = {"/getStockCostServlet"})
public class getStockCostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (request.getParameter("st") == null || request.getParameter("st").equals("") || request.getParameter("st").equals("0")
                    || request.getParameter("qty") == null || request.getParameter("qty").equals("") || request.getParameter("qty").equals("0")
                    || request.getParameter("p") == null || request.getParameter("p").equals("") || request.getParameter("p").equals("0")
                    || request.getParameter("mess").equals("")) {
                out.print("1~0.00~0.00~0.00~0.00~0.00~0.00");

            } else {

                String DE = "0.00";
                if (request.getParameter("des") != null && !request.getParameter("des").equals("")) {
                    DE = request.getParameter("des");
                }
                int MESS = Integer.parseInt(request.getParameter("mess"));
                int STOCK_ID = Integer.parseInt(request.getParameter("st"));
                double QTY = Double.parseDouble(request.getParameter("qty"));
                double PRICE = Double.parseDouble(request.getParameter("p"));
                double DES = Double.parseDouble(DE);

                Session ses = connection.getConnection.getSessionFactory().openSession();
                if (MESS <= 0) {
                    Stock st = (Stock) ses.load(Stock.class, STOCK_ID);
                    double net = Math.round(QTY * PRICE * 100) / 100;
                    double netcost = Math.round(QTY * st.getCost() * 100) / 100;
                    double totaldes = Math.round(QTY * DES * 100) / 100;
                    String COST = st.getCost().toString();
                    String NET_TOTAL = "" + (net - totaldes);
                    String NET_COST = "" + netcost;
                    String NET_PROFIT = "" + (net - (netcost + totaldes));
                    String NET_DES = "" + (totaldes);
                    out.print("1~" + COST + "~" + NET_COST + "~" + NET_TOTAL + "~" + NET_PROFIT + "~" + NET_DES + "~0");

                } else {
                    double NEWQTT=0;
                    TypeCalc TC = (TypeCalc) ses.load(TypeCalc.class, MESS);
                    String EQ = TC.getFormula();
                    try {
                        ScriptEngineManager mgr = new ScriptEngineManager();
                        ScriptEngine engine = mgr.getEngineByName("JavaScript");
                        String foo = QTY + "*" + EQ;

                        NEWQTT = Double.parseDouble(engine.eval(foo).toString());
                       
                    } catch (ScriptException | NumberFormatException e) {
                        out.print("1~0.00~0.00~0.00~0.00~0.00~0.00");
                    }

                    Stock st = (Stock) ses.load(Stock.class, STOCK_ID);
                    double net = Math.round(QTY * PRICE * 100) / 100;
                    double netcost = Math.round(NEWQTT * st.getCost() * 100) / 100;
                    double totaldes = Math.round(QTY * DES * 100) / 100;
                    String COST = st.getCost().toString();
                    String NET_TOTAL = "" + (net - totaldes);
                    String NET_COST = "" + netcost;
                    String NET_PROFIT = "" + (net - (netcost + totaldes));
                    String NET_DES = "" + (totaldes);
                    out.print("1~" + COST + "~" + NET_COST + "~" + NET_TOTAL + "~" + NET_PROFIT + "~" + NET_DES + "~0");
                }

                ses.close();
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
