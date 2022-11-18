/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.helper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Account;
import resources.HoldInvoiceItem;
import resources.Items;
import resources.OtherTrans;
import resources.PaymentType;
import resources.SaleInvoiceItem;
import resources.SalesReturn;
import resources.SalesReturnItems;
import resources.Stock;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveReturnInvoiceHoldServlet", urlPatterns = {"/saveReturnInvoiceHoldServlet"})
public class saveReturnInvoiceHoldServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            Stock STT = null;
            if (request.getSession().getAttribute("invoiceReturnHold") != null) {
                ArrayList<invoiceReturnModel> invoice = (ArrayList<invoiceReturnModel>) request.getSession().getAttribute("invoiceReturnHold");

                Session ses2 = connection.getConnection.getSessionFactory().openSession();
                Transaction tr2 = ses2.beginTransaction();

                double tot = 0.0;
                String REMARK = "HOLD RETURN";
                if (request.getParameter("r") != null) {
                    REMARK = REMARK + " : " + request.getParameter("r");
                }
                for (invoiceReturnModel IRM : invoice) {
                    if(IRM.getQty() > 0){
                        tot = tot + IRM.getNet_total();
                    }
                }
                tot = (double) Math.round(tot * 100.0) / 100.0;
                if (tot > 0.0) {
                    //SalesReturn SR = new SalesReturn();
                    //SR.setAmount(tot);
                    //SR.setRemark(REMARK);
                    //SR.setDate(new helper().getDate());
                    //SR.setTime(new helper().getTime());
                    //SR.setStatus(1);
                    HttpSession mainses = request.getSession(true);
                    User admin = (User) mainses.getAttribute("administrator");
                    //SR.setUser(admin);
                    //ses2.save(SR);
                    int ACC = 0;
                    for (invoiceReturnModel IRM : invoice) {
                        //SalesReturnItems RI = new SalesReturnItems();
                        //RI.setQty(IRM.getQty());
                        //RI.setPrice(IRM.getPrice());
                        //RI.setTotal(IRM.getTotal());
                        //RI.setType(IRM.getType());
                        //Items IT = (Items) ses2.load(Items.class, IRM.getItem_ID());
                        //RI.setItems(IT);
                        HoldInvoiceItem SII = (HoldInvoiceItem) ses2.load(HoldInvoiceItem.class, IRM.getInvoice_id());
                        Stock STOCK = (Stock) ses2.load(Stock.class, IRM.getStock_id());

                        if (STOCK != null) {
                            double TOTQTY = STOCK.getQty() + IRM.getQty();
                            TOTQTY = (double) Math.round(TOTQTY * 100.0) / 100.0;
                            STOCK.setQty(TOTQTY);
                            ses2.update(STOCK);
                        }

                        //RI.setSaleInvoiceItem(SII);
                        //RI.setSalesReturn(SR);
                        ACC = IRM.getAccount_id();
                        //ses2.save(RI);
                    }

                    PaymentType pay_type = (PaymentType) ses2.load(PaymentType.class, 2);
                    Account AC = (Account) ses2.load(Account.class, ACC);

                    OtherTrans PIR = new OtherTrans();
                    PIR.setDebit(0);
                    PIR.setCredit(1);
                    PIR.setAmount(tot);
                    PIR.setCheNumber("");
                    PIR.setCheRegDate("");
                    PIR.setCheDate("");
                    PIR.setCheAmount(0.0);
                    PIR.setStatus(1);
                    PIR.setRemarks(REMARK);
                    PIR.setCheStatus(0);
                    PIR.setDate(new helper().getDate());
                    PIR.setPaymentType(pay_type);
                    PIR.setBranch(admin.getBranch());
                    PIR.setUser(admin);
                    PIR.setChequeBranch("");
                    PIR.setAccountBySupplier(AC);

                    ses2.save(PIR);

                    double d = AC.getDebitBalance();
                    double ddd = d + tot;
                    ddd = (double) Math.round(ddd * 100.0) / 100.0;
                    AC.setDebitBalance(ddd);
                    ses2.update(AC);

                    out.print("1-" + "1");

                    if (request.getSession().getAttribute("invoiceReturnHold") != null) {
                        request.getSession().removeAttribute("invoiceReturnHold");

                    }
                } else {
                    out.print("3-0");
                }

                tr2.commit();
                ses2.close();
            } else {
                out.print("0-0");

            }

        } catch (IOException | HibernateException e) {
            System.out.println(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
