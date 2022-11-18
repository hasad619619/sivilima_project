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
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Account;
import resources.InvoiceRecipt;
import resources.OtherTrans;
import resources.PurchusInvoiceRecipt;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "changeChequeStatServlet", urlPatterns = {"/changeChequeStatServlet"})
public class changeChequeStatServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            User User = (User) request.getSession().getAttribute("administrator");
            if (User.getLevel() == 1) {

                if (request.getParameter("id").equals("") || request.getParameter("stat").equals("") || request.getParameter("acc").equals("") || request.getParameter("t").equals("")) {
                    out.print("0");
                } else {
                    Session ses = connection.getConnection.getSessionFactory().openSession();
                    Transaction tr = ses.beginTransaction();
                    int newStatus = Integer.parseInt(request.getParameter("stat"));
                    Account CustomerAccount = (Account) ses.load(Account.class, Integer.parseInt(request.getParameter("acc")));
                    InvoiceRecipt Recipt = (InvoiceRecipt) ses.load(InvoiceRecipt.class, Integer.parseInt(request.getParameter("id")));
                    double amount = Recipt.getAmount();
                    double customerCredit = CustomerAccount.getCreditBalance();

                    switch (newStatus) {
                        case 0:
                            if (Recipt.getCheStatus() == 2) {
                                Account A = Recipt.getAccountByBankAccount();
                                A.setCreditBalance(amount + Recipt.getAccountByBankAccount().getCreditBalance());
                                ses.update(A);
                                OtherTrans PIR3 = new OtherTrans();
                                PIR3.setAmount(amount);
                                PIR3.setCheNumber(Recipt.getCheNumber());
                                PIR3.setCheRegDate(new helper().getDate());
                                PIR3.setCheDate(Recipt.getCheDate());
                                PIR3.setCheAmount(amount);
                                PIR3.setStatus(1);
                                PIR3.setCheStatus(0);
                                PIR3.setDate(new helper().getDate());
                                PIR3.setPaymentType(Recipt.getPaymentType());
                                PIR3.setBranch(User.getBranch());
                                PIR3.setUser(User);
                                PIR3.setRemarks("CHEQUE RETURN (SALES)");
                                PIR3.setChequeBranch(Recipt.getChequeBranch());
                                PIR3.setAccountBySupplier(A);
                                PIR3.setAccountByBank(Recipt.getAccountByBankAccount());
                                PIR3.setCredit(1);
                                PIR3.setDebit(0);
                                ses.save(PIR3);
                            }

                            OtherTrans PIR3 = new OtherTrans();
                            PIR3.setAmount(amount);
                            PIR3.setCheNumber(Recipt.getCheNumber());
                            PIR3.setCheRegDate(new helper().getDate());
                            PIR3.setCheDate(Recipt.getCheDate());
                            PIR3.setCheAmount(amount);
                            PIR3.setStatus(1);
                            PIR3.setCheStatus(0);
                            PIR3.setDate(new helper().getDate());
                            PIR3.setPaymentType(Recipt.getPaymentType());
                            PIR3.setBranch(User.getBranch());
                            PIR3.setUser(User);
                            PIR3.setRemarks("CHEQUE RETURN (SALES)");
                            PIR3.setChequeBranch(Recipt.getChequeBranch());
                            PIR3.setAccountBySupplier(CustomerAccount);
                            PIR3.setAccountByBank(Recipt.getAccountByBankAccount());
                            PIR3.setCredit(0);
                            PIR3.setDebit(1);
                            ses.save(PIR3);

                            CustomerAccount.setCreditBalance(amount + customerCredit);
                            Recipt.setCheStatus(0);
                            ses.update(CustomerAccount);
                            ses.update(Recipt);

                            tr.commit();
                            ses.close();
                            out.print("1");

                            break;
                        case 2:
                            Account Bank = (Account) ses.load(Account.class, Integer.parseInt(request.getParameter("t")));
                            Bank.setBalance(amount + Bank.getBalance());

                            OtherTrans PIR2 = new OtherTrans();
                            PIR2.setAmount(amount);
                            PIR2.setCheNumber(Recipt.getCheNumber());
                            PIR2.setCheRegDate(new helper().getDate());
                            PIR2.setCheDate(Recipt.getCheDate());
                            PIR2.setCheAmount(amount);
                            PIR2.setStatus(1);
                            PIR2.setCheStatus(0);
                            PIR2.setDate(new helper().getDate());
                            PIR2.setPaymentType(Recipt.getPaymentType());
                            PIR2.setBranch(User.getBranch());
                            PIR2.setUser(User);
                            PIR2.setRemarks("CHEQUE DIPOSITED");
                            PIR2.setChequeBranch(Recipt.getChequeBranch());
                            PIR2.setAccountBySupplier(Bank);
                            PIR2.setAccountByBank(Bank);
                            PIR2.setCredit(0);
                            PIR2.setDebit(1);
                            ses.save(PIR2);

                            Recipt.setCheStatus(2);
                            Recipt.setAccountByBankAccount(Bank);
                            ses.update(Bank);
                            ses.update(Recipt);
                            tr.commit();
                            ses.close();
                            out.print("1");

                            break;
                        case 3:

                            Account ChoosedAccount = (Account) ses.load(Account.class, Integer.parseInt(request.getParameter("t")));
                            Account Bank1 = Recipt.getAccountByBankAccount();
                            PurchusInvoiceRecipt PIR = new PurchusInvoiceRecipt();
                            PIR.setAmount(amount);
                            PIR.setCheNumber(Recipt.getCheNumber());
                            PIR.setCheRegDate(Recipt.getDate());
                            PIR.setCheDate(Recipt.getCheDate());
                            PIR.setCheAmount(amount);
                            PIR.setStatus(1);
                            PIR.setCheStatus(1);
                            PIR.setDate(new helper().getDate());
                            PIR.setPaymentType(Recipt.getPaymentType());
                            PIR.setBranch(User.getBranch());
                            PIR.setUser(User);
                            PIR.setRemarks("THIRD PARTY PAYMENT");
                            PIR.setChequeBranch(Recipt.getChequeBranch());
                            PIR.setAccountBySupplier(ChoosedAccount);
                            PIR.setAccountByBank(Bank1);

                            double apita_denna = ChoosedAccount.getCreditBalance();
                            double api_denna = ChoosedAccount.getDebitBalance();

                            double api_dena_payment_eka = amount;

                            if (apita_denna == 0.0) {
                                if (api_denna <= api_dena_payment_eka) {
                                    ChoosedAccount.setDebitBalance(0.0);
                                    ChoosedAccount.setCreditBalance(api_dena_payment_eka - api_denna);
                                } else {
                                    ChoosedAccount.setDebitBalance(api_denna - api_dena_payment_eka);
                                }

                            } else if (api_dena_payment_eka >= api_denna) {
                                double ithuru = api_dena_payment_eka - api_denna;
                                ChoosedAccount.setDebitBalance(0.0);
                                ChoosedAccount.setCreditBalance(apita_denna + (ithuru));
                            } else {
                                ChoosedAccount.setDebitBalance(api_denna - api_dena_payment_eka);
                            }

                            Recipt.setCheStatus(3);
                            ses.update(Recipt);
                            ses.update(ChoosedAccount);
                            ses.save(PIR);
                            tr.commit();
                            ses.close();
                            out.print("1");

                            break;
                        case 94:
                            CustomerAccount.setCreditBalance(amount + customerCredit);
                            Recipt.setCheStatus(0);
                            Recipt.setStatus(0);
                            ses.update(CustomerAccount);
                            ses.update(Recipt);
                            tr.commit();
                            ses.close();
                            out.print("1");
                            break;

                        default:
                            break;
                    }

                }
            } else {
                out.print("3");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
