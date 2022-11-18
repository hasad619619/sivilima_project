/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.itemModel;
import dataclass.quotationModel;
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

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "setQuatSesssionServlet", urlPatterns = {"/setQuatSesssionServlet"})
public class setQuatSesssionServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("qty").equals("")  || request.getParameter("itemid").equals("") || request.getParameter("price").equals("")) {

            out.print("0");

        } else {
            
            int itemId=Integer.parseInt(request.getParameter("itemid"));
            double qqty=Double.parseDouble(request.getParameter("qty"));
            double price=Double.parseDouble(request.getParameter("price"));
            

            ArrayList<quotationModel> invoice = new ArrayList();
            if (request.getSession().getAttribute("invpu") != null) {
                invoice = (ArrayList<quotationModel>) request.getSession().getAttribute("invpu");
                Session ses=connection.getConnection.getSessionFactory().openSession();
                Items Item=(Items) ses.load(Items.class, itemId);
                quotationModel IM=new quotationModel();
                IM.setItemId(itemId);
                IM.setQty(qqty);
                IM.setPrice(price);
                IM.setType(Item.getType().getName());
                IM.setItemName(Item.getName() );
               
                
                BigDecimal b_desc=new BigDecimal(0.0);
                BigDecimal b_qty=new BigDecimal(qqty);
                BigDecimal b_cost=new BigDecimal(price);
                BigDecimal b_100=new BigDecimal(100);
                
                BigDecimal b_1=b_desc.multiply(b_cost);
                BigDecimal b_2=b_1.divide(b_100);
                
                BigDecimal b_tot1= b_cost.multiply(b_qty);
                
                BigDecimal b_tot_desc=b_qty.multiply(b_2);
                BigDecimal b_tot_tot=b_tot1.subtract(b_tot_desc);
                
                
                IM.setTotal(b_tot_tot.doubleValue());
                invoice.add(IM);
                
                
                request.getSession().setAttribute("invpu",invoice);
                ses.close();
                System.out.println("sesion alredy created !");
                out.print("1");
            }else{
                
                Session ses=connection.getConnection.getSessionFactory().openSession();
                Items Item=(Items) ses.load(Items.class, itemId);
                quotationModel IM=new quotationModel();
                IM.setItemId(itemId);
                IM.setQty(qqty);
                IM.setPrice(price);
                IM.setType(Item.getType().getName());
                IM.setItemName(Item.getName() );
                
                
                BigDecimal b_desc=new BigDecimal(0.0);
                BigDecimal b_qty=new BigDecimal(qqty);
                BigDecimal b_cost=new BigDecimal(price);
                BigDecimal b_100=new BigDecimal(100);
                
                BigDecimal b_1=b_desc.multiply(b_cost);
                BigDecimal b_2=b_1.divide(b_100);
                
                BigDecimal b_tot1= b_cost.multiply(b_qty);
                
                BigDecimal b_tot_desc=b_qty.multiply(b_2);
                BigDecimal b_tot_tot=b_tot1.subtract(b_tot_desc);
                
                
                IM.setTotal(b_tot_tot.doubleValue());
                invoice.add(IM);
                
                request.getSession().setAttribute("invpu",invoice);
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
