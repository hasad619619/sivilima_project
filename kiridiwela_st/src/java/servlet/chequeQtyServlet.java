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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import resources.Stock;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "chequeQtyServlet", urlPatterns = {"/chequeQtyServlet"})
public class chequeQtyServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (request.getParameter("itemid").equals("") || request.getParameter("itemid").equals("0")
                    || request.getParameter("qty").equals("") || request.getParameter("qty").equals("0")
                    || request.getParameter("branch").equals("") || request.getParameter("branch").equals("0")) {
                out.print("0-0");

            } else {

                double qty = Double.parseDouble(request.getParameter("qty"));
                int itrmid = Integer.parseInt(request.getParameter("itemid"));
                int branchid = Integer.parseInt(request.getParameter("branch"));

                if (request.getSession().getAttribute("invr") != null) {
                    ArrayList<itemModel> invoice = (ArrayList<itemModel>) request.getSession().getAttribute("invr");
                    for (itemModel IM : invoice) {
                        if (IM.getItemId() == itrmid) {
                            qty = qty + IM.getQty();
                        }

                    }
                }
                Session ses = connection.getConnection.getSessionFactory().openSession();
                Stock CURRST = (Stock) ses.load(Stock.class, itrmid);
                if (CURRST != null) {

                    if (CURRST.getQty() >= qty) {
                        out.print("1-0");
                    } else {
                        out.print("2-" + "(" + CURRST.getQty() + CURRST.getItems().getType().getName() + ")");
                    }

                } else {
                    out.print("3-0");
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
