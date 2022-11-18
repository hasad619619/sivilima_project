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
import java.math.BigDecimal;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Account;
import resources.Branch;
import resources.OtherTrans;
import resources.PaymentType;
import resources.ReturnItem;
import resources.Stock;
import resources.StockReturn;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "SaveRservlet", urlPatterns = {"/SaveRservlet"})
public class SaveRservlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            if (request.getSession().getAttribute("r1") == null || request.getSession().getAttribute("invr") == null) {

                out.print("0");

            } else {
                HttpSession mainses = request.getSession(true);
                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                ArrayList<itemModel> invoice = new ArrayList();

                invoice = (ArrayList<itemModel>) request.getSession().getAttribute("invr");
                String[] AA = (String[]) request.getSession().getAttribute("r1");

                if (invoice.size() > 0) {

                    String Date = new helper().getDate();
                    User user = (User) request.getSession().getAttribute("administrator");
                    int Supp = Integer.parseInt(AA[0]);
                    double grandtotal;

                    BigDecimal tot = new BigDecimal(0);
                    int i = 0;
                    for (itemModel IM : invoice) {
                        BigDecimal now = new BigDecimal(IM.getTotal());
                        tot = now.add(tot);
                    }
                    grandtotal = tot.doubleValue();

                    Account Suppp = (Account) ses.load(Account.class, Supp);
                    int b = Integer.parseInt(AA[1]);
                    Branch BRANCH = (Branch) ses.load(Branch.class, b);

                    StockReturn PI = new StockReturn();
                    PI.setDate(Date);
                    PI.setAmount(grandtotal);
                    PI.setAccount(Suppp);
                    PI.setStatus(1);
                    PI.setUser(user);
                    PI.setBranch(user.getBranch());

                    ses.save(PI);

                    for (itemModel IM : invoice) {

                        ReturnItem PII = new ReturnItem();
                        int branch_id =  BRANCH.getIdbranch();
                        Stock CURST =(Stock) ses.load(Stock.class, IM.getItemId());
                        
                        if (CURST != null) {
                            double Q = IM.getQty();
                            double curr_qty = CURST.getQty();
                            CURST.setQty(curr_qty - Q);
                            ses.update(CURST);
                            
                        }

                        BigDecimal b_qtt = new BigDecimal(IM.getQty());
                        BigDecimal b_cost = new BigDecimal(IM.getCost());
                        BigDecimal b_tot1 = b_cost.multiply(b_qtt);

                        PII.setQtt(IM.getQty());
                        PII.setAmount(b_tot1.doubleValue());
                        PII.setCost(IM.getCost());
                        PII.setStatus(1);
                        PII.setStock(CURST);
                        PII.setStockReturn(PI);
                        PII.setBranch(BRANCH);
                        ses.save(PII);

                    }
                    PaymentType pay_type = (PaymentType) ses.load(PaymentType.class, 2);
                    OtherTrans PIR = new OtherTrans();
                    PIR.setDebit(1);
                    PIR.setCredit(0);
                    PIR.setAmount(grandtotal);
                    PIR.setCheNumber("");
                    PIR.setCheRegDate("");
                    PIR.setCheDate("");
                    PIR.setCheAmount(0.0);
                    PIR.setStatus(1);
                    PIR.setRemarks("STOCK RETURN #ID : "+PI.getIdstockReturn());
                    PIR.setCheStatus(0);
                    PIR.setDate(new helper().getDate());
                    PIR.setPaymentType(pay_type);
                    PIR.setBranch(user.getBranch());
                    PIR.setUser(user);
                    PIR.setChequeBranch("");
                    PIR.setAccountBySupplier(Suppp);
                    ses.save(PIR);
                    tr.commit();
                    ses.close();
                    request.getSession().removeAttribute("invr");
                    request.getSession().removeAttribute("r1");
                    out.print("1");
                } else {
                    out.print("0");
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
