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
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import resources.Items;
import resources.Stock;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "getItemStockServletEmptyQty", urlPatterns = {"/getItemStockServletEmptyQty"})
public class getItemStockServletEmptyQty extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            if (request.getParameter("hash").equals("")) {
                out.print("0-0");

            } else {
                String id = request.getParameter("hash");
                Session ses = connection.getConnection.getSessionFactory().openSession();
                JSONArray arr = new JSONArray();
                Items ad = (Items) ses.load(Items.class, Integer.parseInt(id));
                if (ad.getItemId() <= 0 || ad.getItemId().toString() == null) {
                    out.print("0-0");
                } else {
                    Set<Stock> ST = ad.getStocks();
                    if (ST.size() > 0) {
                        for (Stock IT : ST) {
                            JSONObject obj2 = new JSONObject();
                            if (IT.getStatus() == 1) {
                                obj2.put("sid", IT.getStockId());
                                obj2.put("branch", IT.getBranch().getName());
                                obj2.put("qty", IT.getQty());
                                obj2.put("date", IT.getDate());
                                obj2.put("cost", IT.getCost());
                                arr.put(obj2);
                            }
                            if (obj2.length() == 0) {

                                obj2.put("sid", "0");
                                obj2.put("branch", "NO STOCK AVAILABLE");
                                obj2.put("qty", "0");
                                obj2.put("date", "YYYY-MM-DD");
                                obj2.put("cost", "0.00");
                                arr.put(obj2);
                            }

                        }
                    } else {
                        JSONObject obj2 = new JSONObject();
                        obj2.put("sid", "0");
                        obj2.put("branch", "NO STOCK AVAILABLE");
                        obj2.put("qty", "0");
                        obj2.put("date", "YYYY-MM-DD");
                        obj2.put("cost", "0.00");
                        arr.put(obj2);
                    }
                }
                out.print(arr);
                ses.close();
            }

        } catch (HibernateException | NumberFormatException | JSONException e) {
            e.printStackTrace();
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
