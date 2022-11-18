/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.helper;
import dataclass.invoiceModel;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
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
import resources.HoldInvoice;
import resources.HoldInvoiceItem;
import resources.HoldRecipt;
import resources.PaymentType;
import resources.Stock;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveHoCashServlet", urlPatterns = {"/saveHoCashServlet"})
public class saveHoCashServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("dd").equals("") || request.getParameter("payment").equals("") || request.getParameter("desc").equals("") || request.getParameter("trans").equals("") || request.getParameter("ret").equals("") || request.getSession().getAttribute("i1") == null || request.getSession().getAttribute("invoiceS") == null) {

                out.print("0-0");

            } else {

                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                ArrayList<invoiceModel> invoice = (ArrayList<invoiceModel>) request.getSession().getAttribute("invoiceS");
                String[] AA = (String[]) request.getSession().getAttribute("i1");

                if (invoice.size() > 0) {

                    int paymentType = Integer.parseInt(AA[1]);
                    String Date = new helper().getDate();
                     String Time = new helper().getTime();
                    int Customer = Integer.parseInt(AA[0]);

                    double grand_desc = Double.parseDouble(request.getParameter("desc"));
                    double return_amount = Double.parseDouble(request.getParameter("ret"));
                    double transport = Double.parseDouble(request.getParameter("trans"));
                    double total_cost;
                    double payment = Double.parseDouble(request.getParameter("payment"));

                    BigDecimal tot = new BigDecimal(0);
                    BigDecimal oc_total = new BigDecimal(0);
                    BigDecimal oc_;
                    for (invoiceModel IM : invoice) {
                         BigDecimal now = new BigDecimal(IM.getTotal()-IM.getTotal_descount());
                        tot = now.add(tot);
                        
                        BigDecimal o_qtt = new BigDecimal(IM.getQty_original());
                        BigDecimal o_cost = new BigDecimal(IM.getCost());
                        oc_ = o_cost.multiply(o_qtt);
                        oc_total = oc_total.add(oc_);
                    }
                    double grandtotal = tot.doubleValue();
                    total_cost = oc_total.doubleValue();

                    BigDecimal t_desc = new BigDecimal(grand_desc);
                    BigDecimal t_amount = new BigDecimal(grandtotal);
                    
                    BigDecimal t_tot_tot = t_amount.subtract(t_desc);

                    double netTotal = t_tot_tot.doubleValue();

                    

                    Account CustAccount = (Account) ses.load(Account.class, Customer);
                    User User = (User) request.getSession().getAttribute("administrator");
                    PaymentType pay_type = (PaymentType) ses.load(PaymentType.class, paymentType);

                    HoldInvoice PI = new HoldInvoice();
                    PI.setDate(Date);
                     PI.setStatus(1);
                    PI.setDeleveryDate(request.getParameter("dd"));
                    PI.setTime(Time);
                    PI.setNetTotal(grandtotal);
                    PI.setDescount(grand_desc);
                    PI.setTotal(netTotal - return_amount);

                    double payble = netTotal - return_amount;
                    double apita_denna = CustAccount.getCreditBalance();
                    double api_denna = CustAccount.getDebitBalance();
                    double balance = CustAccount.getBalance();

                    if (payment == payble) {
                        PI.setPaid(payment);
                        PI.setPaible(0.0);

                    } else if (payment > payble) {
                        PI.setPaid(payment);
                        PI.setPaible(0.0);

                        double ithuru = payment - payble;
                        if (apita_denna >= ithuru) {
                            CustAccount.setCreditBalance(apita_denna - ithuru);

                        } else {
                            CustAccount.setCreditBalance(0.0);
                            CustAccount.setBalance(balance + (ithuru - apita_denna));

                        }

                    } else if (payment < payble) {
                        PI.setPaid(payment);
                        PI.setPaible(payble - payment);
                        double ithuru_payble = payble - payment;

                        if (api_denna == 0 && balance == 0) {
                            CustAccount.setCreditBalance(ithuru_payble + apita_denna);
                        } else {
                            double apita_ganna_mulu = ithuru_payble + apita_denna;
                            if (balance == 0) {

                                if (apita_ganna_mulu >= api_denna) {
                                    CustAccount.setDebitBalance(0.0);
                                    CustAccount.setCreditBalance(apita_ganna_mulu - api_denna);
                                } else {
                                    CustAccount.setCreditBalance(0.0);
                                    CustAccount.setDebitBalance(api_denna - apita_ganna_mulu);

                                }

                            } else if (apita_ganna_mulu >= api_denna) {
                                double ithuru = apita_ganna_mulu - api_denna;

                                CustAccount.setDebitBalance(0.0);

                                if (ithuru >= balance) {
                                    CustAccount.setBalance(0.0);
                                    CustAccount.setCreditBalance(ithuru - balance);
                                } else {
                                    CustAccount.setBalance(balance - ithuru);
                                    CustAccount.setCreditBalance(0.0);
                                }

                            } else {
                                //api denna thiyana gaana > apita ganna thiyana mulu gaanata
                                CustAccount.setCreditBalance(0.0);
                                CustAccount.setDebitBalance(api_denna - apita_ganna_mulu);

                            }
                        }

                    }
                    

                    PI.setReturnAmount(return_amount);
                    PI.setAccount(CustAccount);
                    PI.setUser(User);
                    PI.setBranch(User.getBranch());
                    PI.setPaymentType(pay_type);
                    PI.setTransport(transport);
                    PI.setTotalCost(total_cost);
                    PI.setTotalProfit(netTotal - (total_cost) );

                    //ses.update(CustAccount);
                    ses.save(PI);
                    for (invoiceModel IM : invoice) {

                        Stock stock = (Stock) ses.load(Stock.class, IM.getStockID());

                        

                        HoldInvoiceItem PII = new HoldInvoiceItem();
                        PII.setQtt(IM.getQty());
                        PII.setUnitPrice(IM.getPrice());
                        PII.setDescountRate(0.0);

                        BigDecimal b_qtt = new BigDecimal(IM.getQty_original());
                        BigDecimal b_cost = new BigDecimal(IM.getCost());
                        BigDecimal b_tot1 = b_cost.multiply(b_qtt);
                        
                        

                        PII.setDescount(IM.getTotal_descount());
                        PII.setTotal(IM.getTotal());
                        PII.setNetTotal(IM.getTotal()-IM.getTotal_descount());
                        PII.setStatus(1);
                        PII.setHoldInvoice(PI);
                        PII.setItems(stock.getItems());
                        PII.setCost(b_tot1.doubleValue());
                        PII.setOriginalCostPerItem(b_cost.doubleValue());
                        PII.setNowType(IM.getType());
                        PII.setOriginalType(stock.getItems().getType().getName());
                        PII.setOriginalQtt(IM.getQty_original());
                        PII.setLocation(stock.getBranch().getName());
                        PII.setStock(stock);
                        PII.setProfit(IM.getTotal()-((IM.getCost() * IM.getQty_original())+IM.getTotal_descount()));
                        PII.setQtySended(0.0);
                        ses.save(PII);

                    }
                    
                    HoldRecipt PIR=new HoldRecipt();
                    PIR.setAmount(payment);
                    PIR.setCheNumber("");
                    PIR.setCheRegDate("");
                    PIR.setCheDate("");
                    PIR.setCheAmount(0.0);
                    PIR.setStatus(0);
                    PIR.setRemarks("HOLD INVOICE");
                    PIR.setCheStatus(0);
                    PIR.setDate(Date);
                    PIR.setPaymentType(pay_type);
                    PIR.setBranch(User.getBranch());
                    PIR.setUser(User);
                    PIR.setChequeBranch("");
                    PIR.setTime(Time);
                    PIR.setAccountByCustomer(CustAccount);
                    PIR.setHoldInvoice(PI);
                
                    ses.save(PIR);

                    tr.commit();
                    ses.close();
                    request.getSession().removeAttribute("invoiceS");
                    request.getSession().removeAttribute("i1");
                    out.print("1-" + PI.getIdholdInvoice());
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
