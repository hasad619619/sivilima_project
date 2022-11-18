/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import resources.SaleInvoice;
import resources.SaleInvoiceItem;
import resources.SalesReturnItems;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "setReturnInvoice", urlPatterns = {"/setReturnInvoice"})
public class setReturnInvoice extends HttpServlet {

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
            String ID = "";
            if (request.getParameter("q") != null && !request.getParameter("q").equals("")) {

                try {
                    if (request.getSession().getAttribute("invoiceReturn") != null) {
                        request.getSession().removeAttribute("invoiceReturn");

                    }
                    Session Hses = connection.getConnection.getSessionFactory().openSession();

                    ID = request.getParameter("q");
                    ArrayList<invoiceReturnModel> invoice = new ArrayList();
                    SaleInvoice SI = (SaleInvoice) Hses.load(SaleInvoice.class, Integer.parseInt(ID));
                    Set<SaleInvoiceItem> SII = SI.getSaleInvoiceItems();
                    double tot_qty = 0;
                    double ITEM_DESCOUNT_FROM_MAIN = 0;
                    for (SaleInvoiceItem sii : SII) {
                        tot_qty = tot_qty + sii.getQtt();
                    }
                    if (SI.getDescount() > 0) {
                        ITEM_DESCOUNT_FROM_MAIN = (SI.getDescount()) / tot_qty;
                    }
                    ITEM_DESCOUNT_FROM_MAIN = Math.round(ITEM_DESCOUNT_FROM_MAIN * 100.0) / 100.0;
                    for (SaleInvoiceItem sii : SII) {
                        invoiceReturnModel IM = new invoiceReturnModel();
                        Set<SalesReturnItems> SRI = sii.getSalesReturnItemses();
                        double ALREDY_RETURN_QTY = 0.0;
                        if (!SRI.isEmpty()) {
                            for (SalesReturnItems sri : SRI) {

                                ALREDY_RETURN_QTY = ALREDY_RETURN_QTY + sri.getQty();
                            }
                        }
                        IM.setId(sii.getIdsaleInvoiceItem());
                        IM.setBranch(sii.getLocation());
                        IM.setItem(sii.getItems().getName());
                        IM.setItem_ID(sii.getItems().getItemId());
                        IM.setStock_id(sii.getStock().getStockId());
                        IM.setNet_total(sii.getNetTotal() - (ITEM_DESCOUNT_FROM_MAIN * sii.getQtt()));
                        IM.setTotal(sii.getTotal());
                        IM.setType(sii.getOriginalType());
                        IM.setNow_type(sii.getNowType());
                        IM.setType_ID(0);
                        double QTY_NOW = sii.getQtt() - ALREDY_RETURN_QTY;
                        QTY_NOW = (double) Math.round(QTY_NOW * 100.0) / 100.0;
                        IM.setQty(QTY_NOW);
                        IM.setAlredy_return(ALREDY_RETURN_QTY);
                        IM.setPrice(sii.getUnitPrice());
                        IM.setItem_desk(ITEM_DESCOUNT_FROM_MAIN);
                        IM.setAccount_id(sii.getSaleInvoice().getAccount().getIdaccount());
                        IM.setInvoice_id(sii.getIdsaleInvoiceItem());
                        IM.setDescount(sii.getDescount());
                        IM.setDescount_from_total((ITEM_DESCOUNT_FROM_MAIN * sii.getQtt()));
                        invoice.add(IM);

                    }

                    request.getSession().setAttribute("invoiceReturn", invoice);

                } catch (Exception e) {
                    if (request.getSession().getAttribute("invoiceReturn") != null) {
                        request.getSession().removeAttribute("invoiceReturn");

                    }

                }

            }

            response.sendRedirect("returninvoice.jsp?q=" + ID);
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
