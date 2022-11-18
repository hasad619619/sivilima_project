/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Stock;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "updateStockCostServlet", urlPatterns = {"/updateStockCostServlet"})
public class updateStockCostServlet extends HttpServlet {

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
            if(request.getParameter("id") == null || request.getParameter("id").equals("") || 
                    request.getParameter("cost") == null || request.getParameter("cost").equals("") || request.getParameter("cost").equals("0")){
                    out.print("0");
            }else{
                int STOCK_ID=Integer.parseInt(request.getParameter("id"));
                double NEW_COST=Double.parseDouble(request.getParameter("cost"));
                if(NEW_COST > 0){
                    Session s=connection.getConnection.getSessionFactory().openSession();
                    Stock STOCK =(Stock) s.load(Stock.class, STOCK_ID);
                    
                    if(STOCK.getPrice() > NEW_COST){
                          Transaction tr=s.beginTransaction();
                          STOCK.setCost(NEW_COST);
                          s.update(STOCK);
                          tr.commit();
                          out.print("1");
                    }else{
                        out.print("4");
                    }
                    s.close();
                }else{
                    out.print("3");
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
