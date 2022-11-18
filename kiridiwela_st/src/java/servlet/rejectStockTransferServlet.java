/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.helper;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.StockTransfer;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "rejectStockTransferServlet", urlPatterns = {"/rejectStockTransferServlet"})
public class rejectStockTransferServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("id") != null && !request.getParameter("id").equals("") && !request.getParameter("id").equals("0")) {
                
                int ID_STOCK_TRANSFER = Integer.parseInt(request.getParameter("id"));
                
                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                StockTransfer ST = (StockTransfer) ses.load(StockTransfer.class, ID_STOCK_TRANSFER);
                if (ST.getStatus() == 1) {
                    //status 0=request reject 1=pending  2 = accept from him  3 - cancell from requester 4-accept from me
                    User User = (User) request.getSession().getAttribute("administrator");
                    helper help = new helper();
                    ST.setStatus(0);
                    ST.setUserByAcceptedUser(User);
                    ST.setSendDate(help.getDate());
                    ST.setSendTime(help.getTime());
                    ses.update(ST);
                    out.print("1");
                } else {
                    out.print("3");                    
                }
                tr.commit();
                ses.close();
                
            } else {
                out.print("0");
            }
        } catch (NumberFormatException | HibernateException e) {
            out.print("0");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
}
