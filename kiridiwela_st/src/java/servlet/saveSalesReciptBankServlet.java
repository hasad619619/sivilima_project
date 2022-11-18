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
import resources.InvoiceRecipt;
import resources.PaymentType;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveSalesReciptBankServlet", urlPatterns = {"/saveSalesReciptBankServlet"})
public class saveSalesReciptBankServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("b").equals("") || request.getParameter("payment").equals("") || request.getParameter("account").equals("") || request.getParameter("payment").equals("0") || request.getParameter("account").equals("0")) {

                out.print("0-0");

            } else {
                String Remarks="RECIEVE PAYMENT";
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
                PaymentType pay_type = (PaymentType) ses.load(PaymentType.class, 4);
                Account bank = (Account) ses.load(Account.class, Integer.parseInt(request.getParameter("b")));

                double apita_denna = CustAccount.getCreditBalance();
                double api_denna = CustAccount.getDebitBalance();
                double balance = CustAccount.getBalance();
                
                double apita_dandena_payment_eka=payment;
                if(apita_denna >= apita_dandena_payment_eka){
                    CustAccount.setCreditBalance(apita_denna-apita_dandena_payment_eka);
                    
                }else{
                    double ithuru=apita_dandena_payment_eka-apita_denna;
                    CustAccount.setCreditBalance(0.0);
                    CustAccount.setBalance(balance+ithuru);
                }

                
                

                InvoiceRecipt PIR = new InvoiceRecipt();
                PIR.setAmount(payment);
                PIR.setCheNumber("");
                PIR.setCheRegDate("");
                PIR.setCheDate("");
                PIR.setCheAmount(0.0);
                PIR.setStatus(1);
                PIR.setCheStatus(0);
                PIR.setDate(Date);
                PIR.setTime(Time);
                PIR.setRemarks(Remarks);
                PIR.setPaymentType(pay_type);
                PIR.setBranch(User.getBranch());
                PIR.setUser(User);
                PIR.setChequeBranch("");
                PIR.setAccountByCustomer(CustAccount);
                PIR.setAccountByBankAccount(bank);
                
                ses.update(CustAccount);
                ses.save(PIR);
                
                tr.commit();
                ses.close();
                out.print("1-" + PIR.getIdinvoiceRecipt());

            }
        } catch (HibernateException | NumberFormatException E) {
            E.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
