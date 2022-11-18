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
import resources.StockReturn;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "getReturnServlet", urlPatterns = {"/getReturnServlet"})
public class getReturnServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("p2") != null) {

            Session ses = connection.getConnection.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(StockReturn.class);
            cr.add(Restrictions.eq("status", 1));
            List<StockReturn> item = cr.list();
            JSONArray arr = new JSONArray();
            
                for (StockReturn P : item) {
                try {
                    if(request.getParameter("p2").equals(P.getAccount().getIdaccount().toString())){
                    JSONObject obj=new JSONObject();
                    obj.append("id", P.getIdstockReturn().toString());
                    obj.append("name", P.getDate()+"&nbsp;&nbsp;---&nbspRS"+Math.round(P.getAmount() * 100.0)/100.0);
                    arr.put(obj);
                    }
                    
                } catch (JSONException ex) {
                    System.out.println(ex);
                }
                }
                
                out.print(arr);

                }else {
               
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
