/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.helper;
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
import resources.Account;
import resources.ChequeBook;
import resources.OtherTrans;
import resources.PaymentType;
import resources.PurchusInvoiceRecipt;
import resources.TextList;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "savePurchaseReciptChequeServlet", urlPatterns = {"/savePurchaseReciptChequeServlet"})
public class savePurchaseReciptChequeServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("payment").equals("")
                    || request.getParameter("account").equals("")
                    || request.getParameter("number").equals("")
                    || request.getParameter("date").equals("")
                    || request.getParameter("branch").equals("")
                    || request.getParameter("bank").equals("")) {

                out.print("0-0");

            } else {
                String Remarks="ISSUE PAYMENT";
                if(request.getParameter("re") != null && ! request.getParameter("re").equals("")){
                    Remarks=request.getParameter("re");
                
                }
                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                String Date = new helper().getDate();
                String Time = new helper().getTime();
                int Customer = Integer.parseInt(request.getParameter("account"));
                double payment = Double.parseDouble(request.getParameter("payment"));

                Account CustAccount = (Account) ses.load(Account.class, Customer);
                User User = (User) request.getSession().getAttribute("administrator");
                PaymentType pay_type = (PaymentType) ses.load(PaymentType.class, 3);

                double apita_denna = CustAccount.getCreditBalance();
                double api_denna = CustAccount.getDebitBalance();
                double balance = CustAccount.getBalance();

                double api_dena_payment_eka = payment;

                if (apita_denna == 0.0) {
                    if (api_denna <= api_dena_payment_eka) {
                        CustAccount.setDebitBalance(0.0);
                        CustAccount.setCreditBalance(api_dena_payment_eka - api_denna);
                    } else {
                        CustAccount.setDebitBalance(api_denna - api_dena_payment_eka);
                    }

                } else {

                    
                    
                    if(api_dena_payment_eka >= api_denna){
                        double ithuru = api_dena_payment_eka-api_denna ;
                        CustAccount.setDebitBalance(0.0);
                        CustAccount.setCreditBalance(apita_denna + (ithuru));    
                    }else{
                        CustAccount.setDebitBalance(api_denna - api_dena_payment_eka);
                    }

                    

                    

                }

                PurchusInvoiceRecipt PIR = new PurchusInvoiceRecipt();
                PIR.setAmount(payment);
                PIR.setCheNumber(request.getParameter("number"));
                PIR.setCheRegDate(Date);
                PIR.setCheDate(request.getParameter("date"));
                PIR.setCheAmount(payment);
                PIR.setStatus(1);
                PIR.setCheStatus(1);
                PIR.setDate(Date);
                PIR.setTime(Time);
                PIR.setPaymentType(pay_type);
                PIR.setBranch(User.getBranch());
                PIR.setUser(User);
                PIR.setRemarks(Remarks);
                PIR.setChequeBranch(request.getParameter("branch"));
                PIR.setAccountBySupplier(CustAccount);
                Account BankAcc = (Account) ses.load(Account.class, Integer.parseInt(request.getParameter("bank")));
                PIR.setAccountByBank(BankAcc);
                
                    Criteria crcl=ses.createCriteria(ChequeBook.class);
                    List<ChequeBook> cb=crcl.list();
                    if(cb.size() > 0){
                        for(ChequeBook CB:cb){
                            if(CB.getChequeNumber().equals(request.getParameter("number")) && CB.getStatus() == 1 ){
                                CB.setStatus(2);
                                ses.update(CB);
                            
                            }
                        }
                    }
                    
                    
                OtherTrans PIR3 = new OtherTrans();
                PIR3.setAmount(payment);
                PIR3.setCheNumber(request.getParameter("number"));
                PIR3.setCheRegDate(Date);
                PIR3.setCheDate(request.getParameter("date"));
                PIR3.setCheAmount(payment);
                PIR3.setStatus(1);
                PIR3.setCheStatus(1);
                PIR3.setDate(Date);
                PIR3.setPaymentType(pay_type);
                PIR3.setBranch(User.getBranch());
                PIR3.setUser(User);
                PIR3.setRemarks(Remarks);
                PIR3.setChequeBranch(request.getParameter("branch"));
                PIR3.setAccountBySupplier(BankAcc);
                PIR3.setAccountByBank(BankAcc);
                PIR3.setCredit(1);
                PIR3.setDebit(0);
                
                ses.save(PIR3);
                
                
                ses.update(CustAccount);
                ses.save(PIR);
                
                //save text list
                TextList tl=new TextList();
                tl.setTest(request.getParameter("branch"));
                Criteria cr3 = ses.createCriteria(TextList.class);
                cr3.add(Restrictions.eq("test", request.getParameter("branch")));
                List<TextList> tl1=cr3.list();
                if(tl1.size() <= 0){
                    ses.save(tl);
                }
                
                //save text list

                tr.commit();
                ses.close();
                out.print("1-" + PIR.getIdinvoiceRecipt());

            }

        } catch (Exception E) {
            E.printStackTrace();
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    

}
