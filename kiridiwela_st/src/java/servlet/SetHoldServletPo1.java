/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.itemModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import resources.HoldInvoiceItem;
import resources.Items;
import resources.Stock;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "SetHoldServletPo1", urlPatterns = {"/SetHoldServletPo1"})
public class SetHoldServletPo1 extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("sp").equals("")) {

            out.print("0");

        } else {

            ArrayList<itemModel> invoice = new ArrayList();
            int SUP_ID = Integer.parseInt(request.getParameter("sp"));
            if (request.getSession().getAttribute("invpo") != null) {

                invoice = (ArrayList<itemModel>) request.getSession().getAttribute("invpo");
                Session ses = connection.getConnection.getSessionFactory().openSession();

                Criteria cr = ses.createCriteria(Items.class);
                cr.add(Restrictions.eq("status", 1));
                List<Items> ITEM_LIST = cr.list();
                for (Items IT : ITEM_LIST) {
                    if (IT.getAccount().getIdaccount() == SUP_ID) {
                        int itemID = IT.getItemId();
                        double CURRUNT_QTY = 0.0;
                        double ADDBLE_QTY = 0.0;

                        double Cost = 0.0;
                        Set<Stock> stocks = IT.getStocks();
                        if (!stocks.isEmpty()) {
                            for (Stock ST : stocks) {
                                Cost = ST.getCost();
                            }

                        }

                        Set<Stock> STOCKS = IT.getStocks();
                        if (!STOCKS.isEmpty()) {
                            for (Stock STO : STOCKS) {
                                CURRUNT_QTY = CURRUNT_QTY + STO.getQty();
                            }
                        }
                        Set<HoldInvoiceItem> IR = IT.getHoldInvoiceItems();
                        if (!IR.isEmpty()) {
                            for (HoldInvoiceItem IRM : IR) {

                                ADDBLE_QTY = ADDBLE_QTY + IRM.getOriginalQtt();

                            }
                        }

                        if (ADDBLE_QTY > 0 && ADDBLE_QTY > CURRUNT_QTY) {
                            ADDBLE_QTY = ADDBLE_QTY - CURRUNT_QTY;
                            double NEW_QTY = 0;
                            itemModel itemMR = null;
                            for (itemModel inMo : invoice) {
                                if (inMo.getItemId() == itemID) {

                                    NEW_QTY = inMo.getQty();
                                    itemMR = inMo;

                                }

                            }
                            if (NEW_QTY > 0) {
                                itemModel IM = new itemModel();
                                IM.setItemId(itemID);
                                IM.setQty(ADDBLE_QTY + NEW_QTY);
                                IM.setCost(Cost);
                                IM.setTotal((ADDBLE_QTY + NEW_QTY) * Cost);

                                IM.setType(IT.getType().getName());
                                IM.setItemName(IT.getName());
                                invoice.add(IM);
                            } else {
                                itemModel IM = new itemModel();
                                IM.setItemId(itemID);
                                IM.setQty(ADDBLE_QTY);
                                IM.setCost(Cost);
                                IM.setTotal((ADDBLE_QTY) * Cost);

                                IM.setType(IT.getType().getName());
                                IM.setItemName(IT.getName());

                                invoice.add(IM);

                            }

                            if (itemMR != null) {
                                invoice.remove(itemMR);
                            }

                        }
                    }
                }

                request.getSession().setAttribute("invpo", invoice);
                ses.close();
                System.out.println("sesion alredy created !");
                out.print("1");

            } else {

                Session ses = connection.getConnection.getSessionFactory().openSession();
                Criteria cr = ses.createCriteria(Items.class);
                cr.add(Restrictions.eq("status", 1));
                List<Items> ITEM_LIST = cr.list();
                for (Items IT : ITEM_LIST) {
                    if (IT.getAccount().getIdaccount() == SUP_ID) {
                        int itemID = IT.getItemId();
                        double CURRUNT_QTY = 0.0;
                        double ADDBLE_QTY = 0.0;
                        
                        double Cost = 0.0;
                        Set<Stock> stocks = IT.getStocks();
                        if (!stocks.isEmpty()) {
                            for (Stock ST : stocks) {
                                Cost = ST.getCost();
                            }

                        }

                        Set<Stock> STOCKS = IT.getStocks();
                        if (!STOCKS.isEmpty()) {
                            for (Stock STO : STOCKS) {
                                CURRUNT_QTY = CURRUNT_QTY + STO.getQty();
                            }
                        }
                        Set<HoldInvoiceItem> IR = IT.getHoldInvoiceItems();
                        if (!IR.isEmpty()) {
                            for (HoldInvoiceItem IRM : IR) {

                                ADDBLE_QTY = ADDBLE_QTY + IRM.getOriginalQtt();

                            }
                        }

                        if (ADDBLE_QTY > 0 && ADDBLE_QTY > CURRUNT_QTY) {
                            ADDBLE_QTY = ADDBLE_QTY - CURRUNT_QTY;

                            itemModel IM = new itemModel();
                            IM.setItemId(itemID);
                            IM.setQty(ADDBLE_QTY);
                            IM.setCost(Cost);
                            IM.setTotal((ADDBLE_QTY) * Cost);

                            IM.setType(IT.getType().getName());
                            IM.setItemName(IT.getName());

                            invoice.add(IM);

                        }
                    }
                }

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
