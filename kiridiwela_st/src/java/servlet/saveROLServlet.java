/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.ItemReorder;
import resources.Items;
import resources.SubCategory;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveROLServlet", urlPatterns = {"/saveROLServlet"})
public class saveROLServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            if (request.getSession().getAttribute("administrator") != null) {
                HttpSession mainses = request.getSession(true);
                User admin = (User) mainses.getAttribute("administrator");

                if (admin.getLevel() == 1 || admin.getLevel() == 2) {

                    if (request.getParameter("name") == null || request.getParameter("name").equals("") || request.getParameter("ct") == null
                            || request.getParameter("rol") == null || request.getParameter("rol").equals("")
                            || request.getParameter("empty") == null || request.getParameter("empty").equals("")) {

                        out.print("0");

                    } else {
                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        double ROL = Double.parseDouble(request.getParameter("name"));
                        double ADD_IF_EMPTY = Double.parseDouble(request.getParameter("empty"));
                        double ADD_IF_ROL_PASSED = Double.parseDouble(request.getParameter("rol"));
                        int ITEM_ID = Integer.parseInt(request.getParameter("ct"));
                        Items item = (Items) ses.load(Items.class, ITEM_ID);
                        boolean flag = false;
                        Criteria cr = ses.createCriteria(ItemReorder.class);
                        List<ItemReorder> de = cr.list();

                        if (de.size() > 0) {
                            for (ItemReorder DE : de) {
                                if (DE.getItems().getItemId() == ITEM_ID) {
                                    flag = true;
                                }
                            }
                        }

                        if (!flag) {
                            Transaction tr = ses.beginTransaction();

                            ItemReorder ad = new ItemReorder();

                            ad.setItems(item);
                            ad.setAddIsEmpty(ADD_IF_EMPTY);
                            ad.setAddReOrderPassed(ADD_IF_ROL_PASSED);
                            ad.setRol(ROL);
                            ad.setStatus(1);
                            ses.save(ad);
                            tr.commit();
                            out.print("1");

                        } else {

                            out.print("4");
                        }

                    }

                } else {

                    out.print("3");

                }

            } else {

                out.print("3");

            }

        } catch (Exception e) {

            e.printStackTrace();

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
