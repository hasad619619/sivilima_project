/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.helper;
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
import org.hibernate.Transaction;
import resources.Stock;
import resources.StockTransfer;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "acceptStockReceiveServlet", urlPatterns = {"/acceptStockReceiveServlet"})
public class acceptStockReceiveServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("id") != null && !request.getParameter("id").equals("") && !request.getParameter("id").equals("0")
                    && request.getParameter("stock") != null && !request.getParameter("stock").equals("") && !request.getParameter("stock").equals("0")) {
                
                int ID_STOCK_TRANSFER = Integer.parseInt(request.getParameter("id"));
                int ID_STOCK= Integer.parseInt(request.getParameter("stock"));
                
                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                StockTransfer ST = (StockTransfer) ses.load(StockTransfer.class, ID_STOCK_TRANSFER);
                Stock STOCK = (Stock) ses.load(Stock.class, ID_STOCK);
                if (STOCK.getQty() >= ST.getRequestQty()) {
                    //status 0=request reject 1=pending  2 = accept from him  3 - cancell from requester 4-accept from me
                    User User = (User) request.getSession().getAttribute("administrator");
                    helper help = new helper();
                    int branchId= User.getBranch().getIdbranch();
                    double COST =  STOCK.getCost();
                    double PRICE = STOCK.getPrice();
                    
                    Stock NEW = null;
                    Set<Stock> st = ST.getItems().getStocks();
                    for(Stock s:st){
                        if(s.getBranch().getIdbranch() == branchId && s.getCost() == COST && s.getPrice() == PRICE ){
                            NEW = s;
                        }
                    
                    }
                    if(NEW != null){
                        double CUR_QTY = NEW.getQty();
                        NEW.setQty(CUR_QTY + ST.getSendQty());
                        STOCK.setQty(STOCK.getQty() - ST.getSendQty());
                        ses.update(STOCK);
                        ses.update(NEW);
                    }else{
                        Stock T = new Stock();
                        T.setQty(ST.getSendQty());
                        T.setStatus(1);
                        T.setItems(ST.getItems());
                        T.setBranch(User.getBranch());
                        T.setDate(help.getDate());
                        T.setCost(COST);
                        T.setPrice(PRICE);
                        T.setTime(help.getTime());
                        ses.save(T);
                        STOCK.setQty(STOCK.getQty() - ST.getSendQty());
                        ses.update(STOCK);
                        
                    }
                    
                    
                    ST.setStatus(4);
                    ST.setRecieveDate(help.getDate());
                    ST.setRecieveTime(help.getTime());
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
