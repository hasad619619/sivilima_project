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
import org.hibernate.Session;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import resources.Category;
import resources.SubCategory;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "getSubCatListServlet", urlPatterns = {"/getSubCatListServlet"})
public class getSubCatListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("p2") != null) {
            int catID = Integer.parseInt(request.getParameter("p2"));
            Session ses = connection.getConnection.getSessionFactory().openSession();
            if(catID > 0){
            Category CAT = (Category) ses.load(Category.class, catID);
            if (CAT != null) {
            Set<SubCategory> SubCat = CAT.getSubCategories();

            JSONArray arr = new JSONArray();

            try {
                for (SubCategory SB : SubCat) {
                    JSONObject obj2 = new JSONObject();
                    obj2.append("id", SB.getSubcategoryId());
                    obj2.append("name", SB.getName());
                    arr.put(obj2);
                }
                out.print(arr);
                ses.close();
            } catch (JSONException ex) {
                System.out.println(ex);
            }
            }
            }

        } else {

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
