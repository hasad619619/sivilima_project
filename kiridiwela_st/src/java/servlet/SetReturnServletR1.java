/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.itemModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import resources.Items;
import resources.Stock;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "SetReturnServletR1", urlPatterns = {"/SetReturnServletR1"})
public class SetReturnServletR1 extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("qty").equals("")  || request.getParameter("itemid").equals("") || request.getParameter("branch").equals("")) {

            out.print("0");

        } else {
            
            int itemId=Integer.parseInt(request.getParameter("itemid"));
            int branchId=Integer.parseInt(request.getParameter("branch"));
            double qqty=Double.parseDouble(request.getParameter("qty"));
            double desc=0.0;

            ArrayList<itemModel> invoice = new ArrayList();
            if (request.getSession().getAttribute("invr") != null) {
                invoice = (ArrayList<itemModel>) request.getSession().getAttribute("invr");
                Session ses=connection.getConnection.getSessionFactory().openSession();
                Stock Item=(Stock) ses.load(Stock.class, itemId);
                itemModel IM=new itemModel();
                IM.setItemId(itemId);
                IM.setDesc(desc);
                IM.setQty(qqty);
                IM.setCost(Item.getCost());
                IM.setType(Item.getItems().getType().getName());
                IM.setItemName(Item.getItems().getName() );
               
                
                BigDecimal b_desc=new BigDecimal(desc);
                BigDecimal b_qty=new BigDecimal(qqty);
                BigDecimal b_cost=new BigDecimal(Item.getCost());
                BigDecimal b_100=new BigDecimal(100);
                
                BigDecimal b_1=b_desc.multiply(b_cost);
                BigDecimal b_2=b_1.divide(b_100);
                
                BigDecimal b_tot1= b_cost.multiply(b_qty);
                
                BigDecimal b_tot_desc=b_qty.multiply(b_2);
                BigDecimal b_tot_tot=b_tot1.subtract(b_tot_desc);
                
                
                IM.setTotal(b_tot_tot.doubleValue());
                invoice.add(IM);
                
                
                request.getSession().setAttribute("invr",invoice);
                ses.close();
                System.out.println("sesion alredy created !");
                out.print("1");
            }else{
                
                Session ses=connection.getConnection.getSessionFactory().openSession();
                Stock Item=(Stock) ses.load(Stock.class, itemId);
                itemModel IM=new itemModel();
                IM.setItemId(itemId);
                IM.setDesc(desc);
                IM.setCost(Item.getCost());
                IM.setQty(qqty);
                IM.setType(Item.getItems().getType().getName());
                IM.setItemName(Item.getItems().getName() );
                
                
                BigDecimal b_desc=new BigDecimal(desc);
                BigDecimal b_qty=new BigDecimal(qqty);
                BigDecimal b_cost=new BigDecimal(Item.getCost());
                BigDecimal b_100=new BigDecimal(100);
                
                BigDecimal b_1=b_desc.multiply(b_cost);
                BigDecimal b_2=b_1.divide(b_100);
                
                BigDecimal b_tot1= b_cost.multiply(b_qty);
                
                BigDecimal b_tot_desc=b_qty.multiply(b_2);
                BigDecimal b_tot_tot=b_tot1.subtract(b_tot_desc);
                
                
                IM.setTotal(b_tot_tot.doubleValue());
                invoice.add(IM);
                
                request.getSession().setAttribute("invr",invoice);
                ses.close();
                System.out.println("Session created !");
                out.print("1");
            
            }

        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


}
