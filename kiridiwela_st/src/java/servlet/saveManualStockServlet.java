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
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import resources.Branch;
import resources.Items;
import resources.Stock;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveManualStockServlet", urlPatterns = {"/saveManualStockServlet"})
public class saveManualStockServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            if (request.getParameter("amount") == null || request.getParameter("amount").equals("0")
                    || request.getParameter("account") == null || request.getParameter("account").equals("0")
                    || request.getParameter("type") == null || request.getParameter("type").equals("0")
                    || request.getParameter("branch") == null || request.getParameter("branch").equals("0")
                    || request.getSession().getAttribute("administrator") == null) {

                out.print("0");
            } else {
                int ITEM = Integer.parseInt(request.getParameter("account"));
                int TYPE = Integer.parseInt(request.getParameter("type"));
                int BRANCH = Integer.parseInt(request.getParameter("branch"));

                double QTY = Double.parseDouble(request.getParameter("amount"));

                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                Stock ACC = null;

                Criteria cr = ses.createCriteria(Stock.class);
                cr.add(Restrictions.eq("status", 1));
                List<Stock> ST = cr.list();
                for (Stock st : ST) {
                    if (st.getItems().getItemId() == ITEM && st.getBranch().getIdbranch() == BRANCH) {
                        ACC = st;
                    }
                }

                switch (TYPE) {
                    case 1:

                        if (ACC != null) {
                            ACC.setQty(QTY + ACC.getQty());
                            ses.update(ACC);
                            tr.commit();
                            ses.close();
                            out.print("1");
                        } else {
                            Stock STOCK=new Stock();
                            STOCK.setBranch((Branch) ses.load(Branch.class, BRANCH));
                            STOCK.setItems((Items) ses.load(Items.class, ITEM));
                            STOCK.setStatus(1);
                            STOCK.setQty(QTY);
                            ses.save(STOCK);
                            tr.commit();
                            ses.close();
                            out.print("1");
                            
                        }

                        break;
                    case 2:
                        if (ACC != null) {
                            ACC.setQty(ACC.getQty() - QTY);
                            ses.update(ACC);
                            tr.commit();
                            ses.close();
                            out.print("1");
                        } else {
                            out.print("2");
                        }
                        break;
                    default:
                        out.print("0");
                        break;
                }
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
