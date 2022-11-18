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
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Account;
import resources.PaymentType;
import resources.PurchusInvoiceRecipt;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "savePurchasesReciptCashServlet", urlPatterns = {"/savePurchasesReciptCashServlet"})
public class savePurchasesReciptCashServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("payment").equals("") || request.getParameter("account").equals("") || request.getParameter("payment").equals("0") || request.getParameter("account").equals("0")) {

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
                PaymentType pay_type = (PaymentType) ses.load(PaymentType.class, 2);

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
                PIR.setCheNumber("");
                PIR.setCheRegDate("");
                PIR.setCheDate("");
                PIR.setCheAmount(0.0);
                PIR.setStatus(1);
                PIR.setTime(Time);
                PIR.setCheStatus(0);
                PIR.setDate(Date);
                PIR.setPaymentType(pay_type);
                PIR.setBranch(User.getBranch());
                PIR.setUser(User);
                PIR.setRemarks(Remarks);
                PIR.setChequeBranch("");
                PIR.setAccountBySupplier(CustAccount);
                

                ses.update(CustAccount);
                ses.save(PIR);

                tr.commit();
                ses.close();
                out.print("1-" + PIR.getIdinvoiceRecipt());

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
