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
import resources.Items;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "getItemJsonServlet2", urlPatterns = {"/getItemJsonServlet2"})
public class getItemJsonServlet2 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
                    obj2.put("id", ""+IT.getItemId());
                    obj2.put("name", ""+IT.getName()+"("+IT.getType().getName()+")");
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
