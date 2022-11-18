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
import resources.InvoiceRecipt;
import resources.PaymentType;
import resources.TextList;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveSalesReciptChequeServlet", urlPatterns = {"/saveSalesReciptChequeServlet"})
public class saveSalesReciptChequeServlet extends HttpServlet {

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
                PaymentType pay_type = (PaymentType) ses.load(PaymentType.class, 3);

                double apita_denna = CustAccount.getCreditBalance();
                double api_denna = CustAccount.getDebitBalance();
                double balance = CustAccount.getBalance();

                double apita_dandena_payment_eka = payment;

                if(apita_denna >= apita_dandena_payment_eka){
                    CustAccount.setCreditBalance(apita_denna-apita_dandena_payment_eka);
                    
                }else{
                    double ithuru=apita_dandena_payment_eka-apita_denna;
                    CustAccount.setCreditBalance(0.0);
                    CustAccount.setBalance(balance+ithuru);
                }

                InvoiceRecipt PIR = new InvoiceRecipt();
                PIR.setAmount(payment);
                PIR.setCheNumber(request.getParameter("number"));
                PIR.setCheRegDate(Date);
                PIR.setCheDate(request.getParameter("date"));
                PIR.setCheAmount(payment);
                PIR.setStatus(1);
                PIR.setCheStatus(1);
                PIR.setDate(Date);
                PIR.setTime(Time);
                PIR.setRemarks("INVOICE");
                PIR.setPaymentType(pay_type);
                PIR.setBranch(User.getBranch());
                PIR.setUser(User);
                PIR.setChequeBranch(request.getParameter("branch"));
                PIR.setAccountByCustomer(CustAccount);
                PIR.setBank(request.getParameter("bank"));

                ses.update(CustAccount);
                ses.save(PIR);
                
                //save text list
                TextList tl=new TextList();
                TextList t2=new TextList();
                tl.setTest(request.getParameter("t1"));
                t2.setTest(request.getParameter("t2"));
                Criteria cr3 = ses.createCriteria(TextList.class);
                cr3.add(Restrictions.eq("test", request.getParameter("t1")));
                List<TextList> tl1=cr3.list();
                if(tl1.size() <= 0){
                    ses.save(tl);
                }
                Criteria cr4 = ses.createCriteria(TextList.class);
                cr4.add(Restrictions.eq("test", request.getParameter("t1")));
                List<TextList> tl2=cr4.list();
                if(tl2.size() <= 0){
                    ses.save(t2);
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
