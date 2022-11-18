/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import resources.Stock;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "getSupplierServlet", urlPatterns = {"/getSupplierServlet"})
public class getSupplierServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("p2") != null && request.getParameter("b") != null) {
            int sup=Integer.parseInt(request.getParameter("p2"));
            int bran=Integer.parseInt(request.getParameter("b"));
            Session ses = connection.getConnection.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(Stock.class);
            cr.add(Restrictions.eq("status", 1));
            List<Stock> item = cr.list();
            JSONArray arr = new JSONArray();
               for (Stock P : item) {
                try {
                    if(P.getBranch().getIdbranch() == bran && P.getItems().getAccount().getIdaccount() == sup){
                        JSONObject obj=new JSONObject();
                        obj.append("id", P.getStockId().toString());
                        obj.append("name", P.getItems().getName()+"("+P.getItems().getType().getName()+")"+" " + P.getQty()+"  Available");
                        arr.put(obj);
                    }
                    
                } catch (JSONException ex) {
                    ex.printStackTrace();
                }
                }
                
                out.print(arr);

                }else {
               
                }
            }

            @Override
            protected void doPost
            (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                processRequest(request, response);
            }

            @Override
            protected void doGet
            (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                processRequest(request, response);
            }
        }
