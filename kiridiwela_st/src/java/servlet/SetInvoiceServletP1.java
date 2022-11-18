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
import resources.PoOrderItems;
import resources.PurchaseInvoiceOrder;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "SetInvoiceServletP1", urlPatterns = {"/SetInvoiceServletP1"})
public class SetInvoiceServletP1 extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("qty").equals("") || request.getParameter("itemid").equals("") || request.getParameter("pr").equals("") || request.getParameter("co").equals("") || request.getParameter("po").equals("")) {

            out.print("0");

        } else {

            int itemId = Integer.parseInt(request.getParameter("itemid"));
            int ponumber = Integer.parseInt(request.getParameter("po"));
            double qqty = Double.parseDouble(request.getParameter("qty"));
            double pr = Double.parseDouble(request.getParameter("pr"));
            double cost = Double.parseDouble(request.getParameter("co"));
            double desc = 0.0;
            int i = 0;

            Session s = connection.getConnection.getSessionFactory().openSession();
            PurchaseInvoiceOrder po = (PurchaseInvoiceOrder) s.load(PurchaseInvoiceOrder.class, ponumber);
            Set<PoOrderItems> POI = po.getPoOrderItemses();
            if (!POI.isEmpty()) {
                for (PoOrderItems p : POI) {
                    if (p.getItems().getItemId() == itemId) {
                        i = 1;
                    }
                }

            } else {
                out.print("8");
            }
            if (i == 1) {
                ArrayList<itemModel> invoice = new ArrayList();
                if (request.getSession().getAttribute("invp") != null) {
                    invoice = (ArrayList<itemModel>) request.getSession().getAttribute("invp");
                    Session ses = connection.getConnection.getSessionFactory().openSession();
                    Items Item = (Items) ses.load(Items.class, itemId);
                    double NEW_QTY = 0;
                    itemModel itemMR = null;
                    for (itemModel inMo : invoice) {
                        if (inMo.getItemId() == Item.getItemId()) {

                            NEW_QTY = inMo.getQty();
                            itemMR = inMo;

                        }

                    }

                    if (NEW_QTY > 0) {
                        itemModel IM = new itemModel();
                        IM.setItemId(itemId);
                        IM.setDesc(desc);
                        IM.setQty(qqty + NEW_QTY);
                        IM.setCost(cost);
                        IM.setPrice(pr);
                        IM.setType(Item.getType().getName());
                        IM.setItemName(Item.getName());

                        BigDecimal b_desc = new BigDecimal(desc);
                        BigDecimal b_qty = new BigDecimal(qqty + NEW_QTY);
                        BigDecimal b_cost = new BigDecimal(cost);
                        BigDecimal b_100 = new BigDecimal(100);

                        BigDecimal b_1 = b_desc.multiply(b_cost);
                        BigDecimal b_2 = b_1.divide(b_100);

                        BigDecimal b_tot1 = b_cost.multiply(b_qty);

                        BigDecimal b_tot_desc = b_qty.multiply(b_2);
                        BigDecimal b_tot_tot = b_tot1.subtract(b_tot_desc);

                        IM.setTotal(b_tot_tot.doubleValue());
                        invoice.add(IM);

                        request.getSession().setAttribute("invp", invoice);
                        out.print("1");
                    } else {
                        itemModel IM = new itemModel();
                        IM.setItemId(itemId);
                        IM.setDesc(desc);
                        IM.setQty(qqty);
                        IM.setCost(cost);
                        IM.setPrice(pr);
                        IM.setType(Item.getType().getName());
                        IM.setItemName(Item.getName());

                        BigDecimal b_desc = new BigDecimal(desc);
                        BigDecimal b_qty = new BigDecimal(qqty);
                        BigDecimal b_cost = new BigDecimal(cost);
                        BigDecimal b_100 = new BigDecimal(100);

                        BigDecimal b_1 = b_desc.multiply(b_cost);
                        BigDecimal b_2 = b_1.divide(b_100);

                        BigDecimal b_tot1 = b_cost.multiply(b_qty);

                        BigDecimal b_tot_desc = b_qty.multiply(b_2);
                        BigDecimal b_tot_tot = b_tot1.subtract(b_tot_desc);

                        IM.setTotal(b_tot_tot.doubleValue());
                        invoice.add(IM);

                        request.getSession().setAttribute("invp", invoice);
                        out.print("1");
                    }
                    if (itemMR != null) {
                        invoice.remove(itemMR);
                    }
                    ses.close();

                    System.out.println("sesion alredy created !");

                } else {

                    Session ses = connection.getConnection.getSessionFactory().openSession();
                    Items Item = (Items) ses.load(Items.class, itemId);

                    itemModel IM = new itemModel();
                    IM.setItemId(itemId);
                    IM.setDesc(desc);
                    IM.setQty(qqty);
                    IM.setCost(cost);
                    IM.setPrice(pr);
                    IM.setType(Item.getType().getName());
                    IM.setItemName(Item.getName());

                    BigDecimal b_desc = new BigDecimal(desc);
                    BigDecimal b_qty = new BigDecimal(qqty);
                    BigDecimal b_cost = new BigDecimal(cost);
                    BigDecimal b_100 = new BigDecimal(100);

                    BigDecimal b_1 = b_desc.multiply(b_cost);
                    BigDecimal b_2 = b_1.divide(b_100);

                    BigDecimal b_tot1 = b_cost.multiply(b_qty);

                    BigDecimal b_tot_desc = b_qty.multiply(b_2);
                    BigDecimal b_tot_tot = b_tot1.subtract(b_tot_desc);

                    IM.setTotal(b_tot_tot.doubleValue());
                    invoice.add(IM);

                    request.getSession().setAttribute("invp", invoice);
                    ses.close();
                    System.out.println("Session created !");
                    out.print("1");

                }

            } else {
                out.print("8");
            }
            s.close();

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
