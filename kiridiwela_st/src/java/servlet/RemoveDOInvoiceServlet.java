/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.do_data;
import dataclass.do_id;
import dataclass.invoiceModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "RemoveDOInvoiceServlet", urlPatterns = {"/RemoveDOInvoiceServlet"})
public class RemoveDOInvoiceServlet extends HttpServlet {

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
            if (request.getParameter("hash").equals("")) {

                out.print("0");

            } else {

                int hash = Integer.parseInt(request.getParameter("hash"));
                ArrayList<do_id> id_list = new ArrayList();
                ArrayList<do_data> id_item_list = new ArrayList();
                if (request.getSession().getAttribute("do_id_list") != null) {
                    id_list = (ArrayList<do_id>) request.getSession().getAttribute("do_id_list");
                    do_id il = id_list.get(hash);
                    id_list.remove(hash);
                    if (request.getSession().getAttribute("do_item_list") != null) {
                        id_item_list = (ArrayList<do_data>) request.getSession().getAttribute("do_item_list");
                        for (do_data dd : id_item_list) {

                            if (il.getHold_id() == dd.getHold_Invoice_Number()) {
                                id_item_list.remove(dd);
                            }

                        }
                    }

                    request.getSession().setAttribute("do_id_list", id_list);
                    request.getSession().setAttribute("do_item_list", id_item_list);
                    out.print("1");
                   

                }
                 
            }
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   

}
