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
import java.util.Set;
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
@WebServlet(name = "SetInvoiceServletPo1", urlPatterns = {"/SetInvoiceServletPo1"})
public class SetInvoiceServletPo1 extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("qty").equals("") || request.getParameter("itemid").equals("")) {

            out.print("0");

        } else {

            int itemId = Integer.parseInt(request.getParameter("itemid"));
            double qqty = Double.parseDouble(request.getParameter("qty"));

            ArrayList<itemModel> invoice = new ArrayList();
            if (request.getSession().getAttribute("invpo") != null) {
                invoice = (ArrayList<itemModel>) request.getSession().getAttribute("invpo");
                Session ses = connection.getConnection.getSessionFactory().openSession();
                Items Item = (Items) ses.load(Items.class, itemId);
                double Cost = 0.0;
                Set<Stock> stocks = Item.getStocks();
                if (!stocks.isEmpty()) {
                    for (Stock ST : stocks) {
                        Cost = ST.getCost();
                    }

                }
                double NEW_QTY = 0;
                itemModel itemMR = null;
                for (itemModel inMo : invoice) {
                    if (inMo.getItemId() == itemId) {

                        NEW_QTY = inMo.getQty();
                        itemMR = inMo;

                    }

                }
                if (NEW_QTY > 0) {
                    itemModel IM = new itemModel();
                    IM.setItemId(itemId);
                    IM.setQty(qqty + NEW_QTY);
                    IM.setCost(Cost);
                    IM.setTotal((qqty + NEW_QTY) * Cost);
                    IM.setType(Item.getType().getName());
                    IM.setItemName(Item.getName());
                    invoice.add(IM);
                } else {
                    itemModel IM = new itemModel();
                    IM.setItemId(itemId);
                    IM.setQty(qqty);
                    IM.setCost(Cost);
                    IM.setTotal((qqty) * Cost);
                    IM.setType(Item.getType().getName());
                    IM.setItemName(Item.getName());

                    invoice.add(IM);

                }

                if (itemMR != null) {
                    invoice.remove(itemMR);
                }
                request.getSession().setAttribute("invpo", invoice);
                ses.close();
                System.out.println("sesion alredy created !");
                out.print("1");
            } else {

                Session ses = connection.getConnection.getSessionFactory().openSession();
                Items Item = (Items) ses.load(Items.class, itemId);
                double Cost = 0.0;
                Set<Stock> stocks = Item.getStocks();
                if (!stocks.isEmpty()) {
                    for (Stock ST : stocks) {
                        Cost = ST.getCost();
                    }

                }
                itemModel IM = new itemModel();
                IM.setItemId(itemId);
                IM.setQty(qqty);

                IM.setType(Item.getType().getName());
                IM.setItemName(Item.getName());
                IM.setCost(Cost);
                IM.setTotal((qqty) * Cost);
                invoice.add(IM);

                request.getSession().setAttribute("invpo", invoice);
                ses.close();
                System.out.println("Session created !");
                out.print("1");

            }

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
