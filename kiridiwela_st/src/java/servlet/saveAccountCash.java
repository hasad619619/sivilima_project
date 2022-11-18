/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.helper;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Account;
import resources.InvoiceRecipt;
import resources.OtherTrans;
import resources.PaymentType;
import resources.PurchusInvoiceRecipt;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveAccountCash", urlPatterns = {"/saveAccountCash"})
public class saveAccountCash extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if(request.getParameter("amount") == null ||  request.getParameter("amount").equals("0")
              || request.getParameter("account") == null ||   request.getParameter("account").equals("0")
                    || request.getParameter("type") == null ||   request.getParameter("type").equals("0")
                    || request.getParameter("re") == null ||   request.getParameter("re").equals("")
                    || request.getSession().getAttribute("administrator") == null
                    ){
                
                out.print("0");
            }else{
                int ACC_ID=Integer.parseInt( request.getParameter("account"));
                int TYPE=Integer.parseInt( request.getParameter("type"));
                String REM=request.getParameter("re");
                double AMOUNT=Double.parseDouble( request.getParameter("amount"));
                Session ses=connection.getConnection.getSessionFactory().openSession();
                
                String Date=new helper().getDate();
                PaymentType pay_type = (PaymentType) ses.load(PaymentType.class, 2);
                
                
                Transaction tr=ses.beginTransaction();
                Account ACC=(Account) ses.load(Account.class, ACC_ID);
                HttpSession mainses = request.getSession(true);
                User admin = (User) mainses.getAttribute("administrator");
              
                
                double balance=ACC.getBalance();
                double credit=ACC.getCreditBalance();
                double debit=ACC.getDebitBalance();
                
                if(TYPE==1){
                    OtherTrans PIR=new OtherTrans();
                    PIR.setAmount(AMOUNT);
                    PIR.setCheNumber("");
                    PIR.setDebit(0);
                    PIR.setCredit(1);
                    PIR.setCheRegDate("");
                    PIR.setCheDate("");
                    PIR.setCheAmount(0.0);
                    PIR.setStatus(1);
                    PIR.setCheStatus(0);
                    PIR.setDate(Date);
                    PIR.setRemarks(REM);
                    PIR.setPaymentType(pay_type);
                    PIR.setBranch(admin.getBranch());
                    PIR.setUser(admin);
                    PIR.setChequeBranch("");
                    PIR.setAccountBySupplier(ACC);
                    ses.save(PIR);
                    ACC.setCreditBalance(credit+AMOUNT);
                            
                }
                if(TYPE==2){
                    OtherTrans PIR=new OtherTrans();
                    PIR.setAmount(AMOUNT);
                    PIR.setCheNumber("");
                    PIR.setCheRegDate("");
                    PIR.setCheDate("");
                    PIR.setDebit(1);
                    PIR.setCredit(0);
                    PIR.setCheAmount(0.0);
                    PIR.setStatus(1);
                    PIR.setCheStatus(0);
                    PIR.setDate(Date);
                    PIR.setPaymentType(pay_type);
                    PIR.setBranch(admin.getBranch());
                    PIR.setUser(admin);
                    PIR.setRemarks(REM);
                    PIR.setChequeBranch("");
                    PIR.setAccountBySupplier(ACC);
                    ses.save(PIR);
                    ACC.setDebitBalance(debit+AMOUNT);
                }
                if(TYPE==3){
                    
                    OtherTrans PIR=new OtherTrans();
                    PIR.setAmount(AMOUNT);
                    PIR.setCheNumber("");
                    PIR.setCheRegDate("");
                    PIR.setCheDate("");
                    PIR.setCheAmount(0.0);
                    PIR.setDebit(0);
                    PIR.setCredit(1);
                    PIR.setStatus(1);
                    PIR.setCheStatus(0);
                    PIR.setDate(Date);
                    PIR.setRemarks(REM);
                    PIR.setPaymentType(pay_type);
                    PIR.setBranch(admin.getBranch());
                    PIR.setUser(admin);
                    PIR.setChequeBranch("");
                    PIR.setAccountBySupplier(ACC);
                    ses.save(PIR);
                    ACC.setBalance(balance+AMOUNT);
                }
                ses.update(ACC);
                tr.commit();
                ses.close();
                out.print("1");
            }
            
            
        }catch(Exception e){
            e.printStackTrace();
        }
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    

}
