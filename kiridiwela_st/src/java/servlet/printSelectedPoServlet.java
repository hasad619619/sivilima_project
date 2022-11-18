/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.po_print_data;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import resources.PoOrderItems;
import resources.PurchaseInvoiceOrder;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "printSelectedPoServlet", urlPatterns = {"/printSelectedPoServlet"})
public class printSelectedPoServlet extends HttpServlet {

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
            if (request.getParameter("p") != null) {
                  if (request.getSession().getAttribute("po_print") != null) {
                      request.getSession().removeAttribute("po_print");
                  }
                Session ses = connection.getConnection.getSessionFactory().openSession();
                ArrayList<po_print_data> podata = new ArrayList();
                String[] Data = request.getParameter("p").split(",");
                for (String d : Data) {
                    PurchaseInvoiceOrder PO = (PurchaseInvoiceOrder) ses.load(PurchaseInvoiceOrder.class, Integer.parseInt(d));
                    Set<PoOrderItems> poi = PO.getPoOrderItemses();
                    for (PoOrderItems pi : poi) {
                        if (request.getSession().getAttribute("po_print") != null) {
                            podata = (ArrayList<po_print_data>) request.getSession().getAttribute("po_print");
                            int ItemId = pi.getItems().getItemId();
                            boolean flag = false;
                            po_print_data ppd = null;
                            for (po_print_data q : podata) {
                                if (ItemId == q.getItem_Id()) {
                                    flag = true;
                                    ppd = q;
                                }
                            }
                            if (flag) {

                                if (ppd != null) {
                                    po_print_data pop = ppd;
                                    double qq = pi.getQty() - pi.getQtyRecived();
                                    if (qq > 0) {
                                        pop.setQty(ppd.getQty() + qq);
                                    } else {
                                        pop.setQty(ppd.getQty());
                                    }
                                    podata.remove(ppd);
                                    podata.add(pop);
                                }

                            } else {
                                po_print_data pop = new po_print_data();
                                pop.setItem_Id(pi.getItems().getItemId());
                                pop.setItem(pi.getItems().getName());
                                double qq = pi.getQty() - pi.getQtyRecived();
                                if (qq > 0) {
                                    pop.setQty(qq);
                                } else {
                                    pop.setQty(0);
                                }
                                podata.add(pop);
                            }
                            request.getSession().setAttribute("po_print", podata);
                        } else {
                            po_print_data pop = new po_print_data();
                            pop.setItem_Id(pi.getItems().getItemId());
                            pop.setItem(pi.getItems().getName());
                            double qq = pi.getQty() - pi.getQtyRecived();
                            if (qq > 0) {
                                pop.setQty(qq);
                                podata.add(pop);
                                request.getSession().setAttribute("po_print", podata);
                            } else {
                                pop.setQty(0);
                            }
                            
                        }
                    }
                    out.print("1");

                }

            } else {
                out.print("0");
            }

        } catch (Exception ex) {
            System.out.println(ex);
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
