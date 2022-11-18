/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.do_data;
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
@WebServlet(name = "ChangeDOQtySertvlet", urlPatterns = {"/ChangeDOQtySertvlet"})
public class ChangeDOQtySertvlet extends HttpServlet {

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
            if (request.getParameter("hash").equals("") && request.getParameter("qty").equals("")) {
                
                out.print("0");
                
            } else {
                
                int hash = Integer.parseInt(request.getParameter("hash"));
                double qt = Double.parseDouble(request.getParameter("qty"));
                ArrayList<do_data> id_item_list = new ArrayList();
                
                if (request.getSession().getAttribute("do_item_list") != null) {
                    id_item_list = (ArrayList<do_data>) request.getSession().getAttribute("do_item_list");
                    do_data dodata = id_item_list.get(hash);
                    if (qt > 0.0) {
                        if ((dodata.getQty() - dodata.getQty_sended()) >= qt) {
                            dodata.setQty_send(qt);
                            
                            id_item_list.remove(hash);
                            id_item_list.add(dodata);
                            request.getSession().setAttribute("do_item_list", id_item_list);
                            out.print("1");
                        } else {
                            out.print("2");
                        }
                    } else {
                        out.print("3");
                    }
                    
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
