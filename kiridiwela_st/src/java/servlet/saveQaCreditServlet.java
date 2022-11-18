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
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Account;
import resources.PaymentType;
import resources.QuotationInvoice;
import resources.QuotationInvoiceItem;
import resources.Stock;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveQaCreditServlet", urlPatterns = {"/saveQaCreditServlet"})
public class saveQaCreditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("desc").equals("") || request.getParameter("trans").equals("") || request.getParameter("ret").equals("") || request.getSession().getAttribute("i1") == null || request.getSession().getAttribute("invoiceS") == null) {

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

                    QuotationInvoice PI = new QuotationInvoice();
                    PI.setDate(Date);
                    PI.setTime(Time);
                    PI.setNetTotal(grandtotal);
                    PI.setDescount(grand_desc);
                    PI.setTotal(netTotal);
                    PI.setPaid(0.0);
                    double payble = netTotal - return_amount;
                    PI.setPaible(payble);
                    PI.setReturnAmount(return_amount);
                    PI.setAccount(CustAccount);
                    PI.setUser(User);
                    PI.setBranch(User.getBranch());
                    PI.setPaymentType(pay_type);
                    PI.setTransport(transport);
                    PI.setTotalCost(total_cost);
                    PI.setTotalProfit(netTotal - (total_cost) );
                    
                    
                    ses.save(PI);
                  
                    for (invoiceModel IM : invoice) {
                       
                        Stock stock = (Stock) ses.load(Stock.class, IM.getStockID());

                        
                        QuotationInvoiceItem PII = new QuotationInvoiceItem();
                        PII.setQtt(IM.getQty());
                        PII.setUnitPrice(IM.getPrice());
                        PII.setDescountRate(0.0);

                        BigDecimal b_qtt = new BigDecimal(IM.getQty_original());
                        BigDecimal b_cost = new BigDecimal(IM.getCost() );
                        BigDecimal b_tot1 = b_cost.multiply(b_qtt);
                        
                       
                       

                        PII.setDescount(IM.getTotal_descount());
                        PII.setTotal(IM.getTotal());
                        PII.setNetTotal(IM.getTotal()-IM.getTotal_descount());
                        PII.setStatus(1);
                        PII.setQuotationInvoice(PI);
                        PII.setItems(stock.getItems());
                        PII.setCost(b_tot1.doubleValue());
                        PII.setOriginalCostPerItem(b_cost.doubleValue());
                        PII.setNowType(IM.getType());
                        PII.setOriginalType(stock.getItems().getType().getName());
                        PII.setOriginalQtt(IM.getQty_original());
                        PII.setLocation(stock.getBranch().getName());
                        PII.setStock(stock);
                        PII.setProfit(IM.getTotal()-((IM.getCost() * IM.getQty_original())+IM.getTotal_descount()));
                        ses.save(PII);
                       

                    }
                    
                    tr.commit();
                    ses.close();
                    request.getSession().removeAttribute("invoiceS");
                    request.getSession().removeAttribute("i1");
                    out.print("1-" + PI.getIdquotationInvoice());
                } else {
                    out.print("0-0");
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
