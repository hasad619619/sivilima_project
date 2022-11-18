/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.helper;
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
import org.hibernate.Session;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import resources.Items;
import resources.Stock;
import resources.TypeCalc;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "getMessListServlet", urlPatterns = {"/getMessListServlet"})
public class getMessListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("p2") != null) {
            int itemID = Integer.parseInt(request.getParameter("p2"));
            Session ses = connection.getConnection.getSessionFactory().openSession();
            helper h=new helper();
            Stock STOCK = (Stock) ses.load(Stock.class, itemID);
            Items ITEM = STOCK.getItems();
            String MT = ITEM.getType().getName();
            Set<TypeCalc>  typeCalc = ITEM.getTypeCalcs();
            
            
            
            JSONArray arr = new JSONArray();
            if (typeCalc.size() > 0) {
                try {
                    JSONObject obj2 = new JSONObject();
                    obj2.append("id", "0");
                    obj2.append("name", ITEM.getType().getName()+" ( "+STOCK.getCost()+" )");
                    arr.put(obj2);
                    for (TypeCalc P : typeCalc) {

                        if (P.getTypeByType1().getName().equals(MT)) {
                            
                            ScriptEngineManager mgr = new ScriptEngineManager();
                            ScriptEngine engine = mgr.getEngineByName("JavaScript");
                            String foo2 = (STOCK.getCost()  + "*" + P.getFormula());

                            double NEWCOST = Double.parseDouble(engine.eval(foo2).toString());
                            BigDecimal bd = new BigDecimal(NEWCOST);
                            bd = bd.setScale(2, RoundingMode.HALF_UP);
                            NEWCOST=bd.doubleValue();
                            
                            JSONObject obj = new JSONObject();
                            obj.append("id", P.getIdtypeCalc());
                            obj.append("name", P.getTypeByType2().getName()+" "+" ("+NEWCOST+")");
                            obj.append("cost", NEWCOST);
                            arr.put(obj);
                        }

                    }

                    out.print(arr);
                    ses.close();
                } catch (JSONException ex) {
                    System.out.println(ex);
                } catch (ScriptException ex) {
                    System.out.println(ex);
                }
            } else {
                try {
                    JSONObject obj2 = new JSONObject();
                    obj2.append("id", "0");
                    obj2.append("name", ITEM.getType().getName()+" "+" ("+STOCK.getCost()+")");
                    obj2.append("cost", STOCK.getCost());
                    arr.put(obj2);
                    out.print(arr);
                    ses.close();
                } catch (JSONException ex) {
                    System.out.println(ex);
                }
            }

        } else {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
