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
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Account;
import resources.Branch;
import resources.Items;
import resources.PaymentType;
import resources.PoOrderItems;
import resources.PurchaseInvoiceOrder;
import resources.PurchusInvoice;
import resources.PurchusInvoiceItem;
import resources.PurchusInvoiceRecipt;
import resources.Stock;
import resources.StockReturn;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "savePCashServlet", urlPatterns = {"/savePCashServlet"})
public class savePCashServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("desc").equals("") || request.getParameter("po").equals("") || request.getParameter("ret").equals("") || request.getSession().getAttribute("p1") == null || request.getSession().getAttribute("invp") == null) {

                out.print("0-0");

            } else {

                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                PurchaseInvoiceOrder PO = (PurchaseInvoiceOrder) ses.load(PurchaseInvoiceOrder.class, Integer.parseInt(request.getParameter("po")));
                
                ArrayList<itemModel> invoice = (ArrayList<itemModel>) request.getSession().getAttribute("invp");
                String[] AA = (String[]) request.getSession().getAttribute("p1");

                if (invoice.size() > 0) {

                    int paymentType = Integer.parseInt(AA[0]);
                    String Date = new helper().getDate();
                    String Time = new helper().getTime();
                    int User = Integer.parseInt(AA[2]);
                    int Supp = Integer.parseInt(AA[3]);
                    
                    int b = Integer.parseInt(AA[4]);
                    Branch BRANCH=(Branch) ses.load(Branch.class, b);
                    
                    double grand_desc = Double.parseDouble(request.getParameter("desc"));
                    int return_id = Integer.parseInt(request.getParameter("ret"));

                    BigDecimal tot = new BigDecimal(0);
                    for (itemModel IM : invoice) {
                        BigDecimal now = new BigDecimal(IM.getTotal());
                        tot = now.add(tot);
                    }
                    double grandtotal = tot.doubleValue();

                    BigDecimal t_desc = new BigDecimal(grand_desc);
                    BigDecimal t_amount = new BigDecimal(grandtotal);
                    BigDecimal b_100 = new BigDecimal(100);

                    BigDecimal b_1 = t_desc.multiply(t_amount);
                    BigDecimal b_2 = b_1.divide(b_100);

                    BigDecimal t_tot_tot = t_amount.subtract(b_2);

                    double netTotal = t_tot_tot.doubleValue();
                    double return_amount = 0.0;
                    if (return_id > 0) {
                        StockReturn SR = (StockReturn) ses.load(StockReturn.class, return_id);
                        return_amount = SR.getAmount();
                        SR.setStatus(2);
                        ses.update(SR);
                    }

                    Account Suppp_Account = (Account) ses.load(Account.class, Supp);
                    User Usser = (User) ses.load(User.class, User);
                    PaymentType pay_type = (PaymentType) ses.load(PaymentType.class, paymentType);

                    PurchusInvoice PI = new PurchusInvoice();
                    PI.setDate(Date);
                    PI.setCash(0.0);
                    PI.setBalance(0.0);
                    PI.setNetTotal(grandtotal);
                    PI.setDescount(grand_desc);
                    PI.setTotal(netTotal - return_amount);
                    
                    double payble = netTotal - return_amount;
                    PI.setPaid(payble);
                    PI.setPaible(0.0);
                    PI.setReturnAmount(return_amount);
                    PI.setAccount(Suppp_Account);
                    PI.setUser(Usser);
                    PI.setBranch(BRANCH);
                    PI.setPaymentType(pay_type);
                    PI.setTime(Time);
                    PI.setPurchaseInvoiceOrder(PO);
                    ses.save(PI);
                    
                    PurchusInvoiceRecipt PIR=new PurchusInvoiceRecipt();
                    PIR.setAmount(payble);
                    PIR.setCheNumber("");
                    PIR.setCheRegDate("");
                    PIR.setCheDate("");
                    PIR.setCheAmount(0.0);
                    PIR.setStatus(1);
                    PIR.setCheStatus(0);
                    PIR.setDate(Date);
                    PIR.setTime(Time);
                    PIR.setPaymentType(pay_type);
                    PIR.setBranch(BRANCH);
                    PIR.setUser(Usser);
                    PIR.setRemarks("PURCHASE");
                    PIR.setChequeBranch("");
                    PIR.setAccountBySupplier(Suppp_Account);
                    PIR.setPurchusInvoice(PI);
                    
                    
                    ses.save(PIR);
                    

                    for (itemModel IM : invoice) {

                        PurchusInvoiceItem PII = new PurchusInvoiceItem();
                        Items item = (Items) ses.load(Items.class, IM.getItemId());

                        //stocks
                        double Q = IM.getQty();
                        int branch_id = BRANCH.getIdbranch();
                        Set<Stock> stock = item.getStocks();
                        Stock CURST = null;
                        for (Stock st : stock) {
                            if (st.getBranch().getIdbranch() == branch_id && st.getStatus() == 1 && st.getCost() == IM.getCost() && st.getPrice() == IM.getPrice()) {
                                CURST = st;
                            }
                        }

                        if (CURST != null) {
                            double curr_qty = CURST.getQty();
                            double F = Q + curr_qty;
                            F = (double) Math.round(F * 100) / 100;
                            CURST.setQty(F);
                            CURST.setDate(Date);
                            CURST.setTime(Time);
                            ses.update(CURST);
                        } else {
                            CURST = new Stock();
                            CURST.setQty(Q);
                            CURST.setBranch(BRANCH);
                            CURST.setItems(item);
                            CURST.setCost(IM.getCost());
                            CURST.setPrice(IM.getPrice());
                            CURST.setDate(Date);
                            CURST.setTime(Time);
                            CURST.setStatus(1);
                            ses.save(CURST);
                        }
                        //stocks
                        //po setup
                        Set<PoOrderItems> PIOI = PO.getPoOrderItemses();
                        int O_ITEM_ID = item.getItemId();
                        int I = 0;
                        if (!PIOI.isEmpty()) {
                            for (PoOrderItems p : PIOI) {

                                if (p.getItems().getItemId() == O_ITEM_ID) {
                                    
                                    double QTY = IM.getQty();
                                    p.setQtyRecived(p.getQtyRecived()+QTY);
                                    ses.update(p);
                                }
                                
                                if(p.getQty() > p.getQtyRecived()){
                                    I++;
                                }
                            }

                        }
                        if(I == 0){
                            PO.setStatus(3);
                            ses.update(PO);
                        }

                        //posetup

                        PII.setQtt(IM.getQty());
                        PII.setUnitPrice(IM.getCost());
                        PII.setDescountRate(IM.getDesc());

                        BigDecimal b_qtt = new BigDecimal(IM.getQty());
                        BigDecimal b_cost = new BigDecimal(IM.getCost());
                        BigDecimal b_tot1 = b_cost.multiply(b_qtt);

                        PII.setDescount(b_tot1.doubleValue() - IM.getTotal());
                        PII.setTotal(b_tot1.doubleValue());
                        PII.setNetTotal(IM.getTotal());
                        PII.setStatus(1);
                        PII.setPurchusInvoice(PI);
                        PII.setItems(item);
                        
                        ses.update(item);
                        ses.save(PII);

                    }

                    tr.commit();
                    ses.close();
                    request.getSession().removeAttribute("invp");
                    request.getSession().removeAttribute("p1");
                    out.print("1-"+PI.getIdpurchusInvoice());
                } else {
                    out.print("0-0");
                }

            }
        } catch (Exception e) {
        }
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   

}
