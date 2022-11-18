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
import resources.HoldInvoice;
import resources.HoldInvoiceItem;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "setReturnHoldInvoice", urlPatterns = {"/setReturnHoldInvoice"})
public class setReturnHoldInvoice extends HttpServlet {

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
                    if (request.getSession().getAttribute("HoldInvoiceReturn") != null) {
                        request.getSession().removeAttribute("HoldInvoiceReturn");

                    }
                    Session Hses = connection.getConnection.getSessionFactory().openSession();

                    ID = request.getParameter("q");
                    ArrayList<invoiceReturnModel> invoice = new ArrayList();
                    HoldInvoice SI = (HoldInvoice) Hses.load(HoldInvoice.class, Integer.parseInt(ID));
                    Set<HoldInvoiceItem> SII = SI.getHoldInvoiceItems();
                    for (HoldInvoiceItem sii : SII) {
                        
                        invoiceReturnModel IM = new invoiceReturnModel();
                        IM.setId(sii.getIdholdInvoiceItem());
                        IM.setBranch(sii.getLocation());
                        IM.setItem(sii.getItems().getName());
                        IM.setItem_ID(sii.getItems().getItemId());
                        IM.setStock_id(sii.getStock().getStockId());
                        IM.setNet_total(sii.getNetTotal());
                        IM.setTotal(sii.getTotal());
                        IM.setType(sii.getOriginalType());
                        IM.setNow_type(sii.getNowType());
                        IM.setType_ID(0);
                        double QTY_NOW = sii.getQtt();
                        QTY_NOW = (double) Math.round(QTY_NOW * 100.0) / 100.0;
                        IM.setQty(QTY_NOW);
                        IM.setAlredy_return(0);
                        IM.setPrice(sii.getUnitPrice());
                        IM.setAccount_id(sii.getHoldInvoice().getAccount().getIdaccount());
                        IM.setInvoice_id(sii.getIdholdInvoiceItem());
                        invoice.add(IM);

                    }

                    request.getSession().setAttribute("HoldInvoiceReturn", invoice);

                } catch (Exception e) {
                    if (request.getSession().getAttribute("HoldInvoiceReturn") != null) {
                        request.getSession().removeAttribute("HoldInvoiceReturn");

                    }

                }

            }

            response.sendRedirect("edithold.jsp?q=" + ID);
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
