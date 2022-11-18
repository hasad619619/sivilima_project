/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.do_id;
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
@WebServlet(name = "ChangeDOTransSertvlet", urlPatterns = {"/ChangeDOTransSertvlet"})
public class ChangeDOTransSertvlet extends HttpServlet {

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
            if (request.getParameter("hash").equals("") && request.getParameter("tt").equals("")) {

                out.print("0");

            } else {

                int hash = Integer.parseInt(request.getParameter("hash"));
                double trans = Double.parseDouble(request.getParameter("tt"));
                ArrayList<do_id> id_id_list = new ArrayList();

                if (request.getSession().getAttribute("do_id_list") != null) {
                    id_id_list = (ArrayList<do_id>) request.getSession().getAttribute("do_id_list");
                    do_id dodata = id_id_list.get(hash);
                    if (trans > 0.0) {

                        dodata.setTranport(trans);

                        id_id_list.remove(hash);
                        id_id_list.add(dodata);
                        request.getSession().setAttribute("do_id_list", id_id_list);
                        out.print("1");

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
