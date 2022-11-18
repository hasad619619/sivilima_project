package servlet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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
import resources.Items;
import resources.Stock;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(urlPatterns = {"/getItemJsonServlet"})
public class getItemJsonServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            Session ses = connection.getConnection.getSessionFactory().openSession();
            Criteria cr=ses.createCriteria(Items.class);
            cr.add(Restrictions.eq("status", 1));
            
            List<Items>  ItemList = cr.list();
            
            
            
            JSONArray arr = new JSONArray();
            if (ItemList.size() > 0) {
                for(Items IT : ItemList){
                try {
                    JSONObject obj2 = new JSONObject();
                    obj2.put("id", ""+IT.getBarcodeId());
                    obj2.put("name", ""+IT.getName()+"-"+IT.getBarcodeId());
                    arr.put(obj2);
                    
                    
                } catch (JSONException ex) {
                    System.out.println(ex);
                }
                }
                }else{
                try {
                    JSONObject obj2 = new JSONObject();
                    obj2.put("id", "0");
                    obj2.put("name", "NO ITEM LIST FOUND");
                    arr.put(obj2);
                    
                   
                } catch (JSONException ex) {
                    System.out.println(ex);
                }
            }
            out.print(arr);
            ses.close();
    }

    } 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    

}
