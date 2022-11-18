/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.helper;
import dataclass.itemModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Account;
import resources.Branch;
import resources.Items;
import resources.PoOrderItems;
import resources.PurchaseInvoiceOrder;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "savePOServlet", urlPatterns = {"/savePOServlet"})
public class savePOServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("re").equals("")  ||request.getParameter("re").equals("")) {

                out.print("0-0");

            } else {

                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                ArrayList<itemModel> invoice = (ArrayList<itemModel>) request.getSession().getAttribute("invpo");
                String[] AA = (String[]) request.getSession().getAttribute("po1");

                if (invoice.size() > 0) {

                    String Date = new helper().getDate();
                    int User = Integer.parseInt(AA[2]);
                    int Supp = Integer.parseInt(AA[3]); 
                    
                    int b = Integer.parseInt(AA[4]);
                    Branch BRANCH=(Branch) ses.load(Branch.class, b);
                    
                    Account Suppp_Account = (Account) ses.load(Account.class, Supp);
                    User Usser = (User) ses.load(User.class, User);
                    double total=0.0;
                    for (itemModel IM : invoice) {

                        total=total+IM.getTotal();

                    }
                    
                    PurchaseInvoiceOrder PI = new PurchaseInvoiceOrder();
                    PI.setTotal(total);
                    PI.setPoDate(Date);
                    PI.setAccount(Suppp_Account);
                    PI.setUser(Usser);
                    PI.setRemarks(request.getParameter("re"));
                    PI.setStatus(1);
                    PI.setBranch(BRANCH);
                    PI.setDate(new helper().getDate());
                    PI.setTime(new helper().getTime());
                    
                    
                    ses.save(PI);

                    for (itemModel IM : invoice) {

                        PoOrderItems PII = new PoOrderItems();
                        Items item = (Items) ses.load(Items.class, IM.getItemId());
                        PII.setQty(IM.getQty());
                        PII.setQtyRecived(0.0);
                        PII.setCost(IM.getCost());
                        PII.setTotal(IM.getTotal());
                        PII.setItems(item);
                        PII.setStatus(1);
                        PII.setPurchaseInvoiceOrder(PI);
                        
                        
                        
                        ses.save(PII);

                    }

                    tr.commit();
                    ses.close();
                    request.getSession().removeAttribute("invpo");
                    request.getSession().removeAttribute("po1");
                    out.print("1-"+PI.getIdpurchaseInvoiceOrder());
                } else {
                    out.print("0-0");
                }

            }
        } catch (HibernateException | NumberFormatException e) {
            
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
