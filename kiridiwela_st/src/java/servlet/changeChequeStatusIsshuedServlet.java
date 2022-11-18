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
import resources.OtherTrans;
import resources.PurchusInvoiceRecipt;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "changeChequeStatusIsshuedServlet", urlPatterns = {"/changeChequeStatusIsshuedServlet"})
public class changeChequeStatusIsshuedServlet extends HttpServlet {

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
                    Account SupplierAccount = (Account) ses.load(Account.class, Integer.parseInt(request.getParameter("acc")));
                    PurchusInvoiceRecipt Recipt = (PurchusInvoiceRecipt) ses.load(PurchusInvoiceRecipt.class, Integer.parseInt(request.getParameter("id")));
                    double amount = Recipt.getAmount();
                    double customerCredit = SupplierAccount.getDebitBalance();

                    switch (newStatus) {
                        case 0:

                            if (Recipt.getCheStatus() == 3) {

                                Account A = Recipt.getAccountByBank();
                                A.setCreditBalance(amount);
                                ses.update(A);
                                
                                OtherTrans PIR = new OtherTrans();
                                PIR.setAmount(amount);
                                PIR.setCheNumber(Recipt.getCheNumber());
                                PIR.setCheRegDate(new helper().getDate());
                                PIR.setCheDate(Recipt.getCheDate());
                                PIR.setCheAmount(amount);
                                PIR.setStatus(1);
                                PIR.setCheStatus(0);
                                PIR.setDate(new helper().getDate());
                                PIR.setPaymentType(Recipt.getPaymentType());
                                PIR.setBranch(User.getBranch());
                                PIR.setUser(User);
                                PIR.setRemarks("CHEQUE RETURN (PURCHASE)");
                                PIR.setChequeBranch(Recipt.getChequeBranch());
                                PIR.setAccountBySupplier(A);
                                PIR.setAccountByBank(Recipt.getAccountByBank());
                                PIR.setCredit(0);
                                PIR.setDebit(1);
                                ses.save(PIR);

                            }

                            SupplierAccount.setDebitBalance(amount + customerCredit);
                            Recipt.setCheStatus(0);

                            OtherTrans PIR = new OtherTrans();
                            PIR.setAmount(amount);
                            PIR.setCheNumber(Recipt.getCheNumber());
                            PIR.setCheRegDate(new helper().getDate());
                            PIR.setCheDate(Recipt.getCheDate());
                            PIR.setCheAmount(amount);
                            PIR.setStatus(1);
                            PIR.setCheStatus(0);
                            PIR.setDate(new helper().getDate());
                            PIR.setPaymentType(Recipt.getPaymentType());
                            PIR.setBranch(User.getBranch());
                            PIR.setUser(User);
                            PIR.setRemarks("CHEQUE RETURN (PURCHASE)");
                            PIR.setChequeBranch(Recipt.getChequeBranch());
                            PIR.setAccountBySupplier(SupplierAccount);
                            PIR.setAccountByBank(Recipt.getAccountByBank());
                            PIR.setCredit(1);
                            PIR.setDebit(0);
                            ses.save(PIR);

                            ses.update(SupplierAccount);
                            ses.update(Recipt);
                            tr.commit();
                            ses.close();
                            out.print("1");

                            break;
                        case 2:

                            Recipt.setCheStatus(2);
                            ses.update(Recipt);
                            tr.commit();
                            ses.close();
                            out.print("1");

                            break;
                        case 3:
                            Account Bank = Recipt.getAccountByBank();
                            Bank.setDebitBalance(amount + Bank.getDebitBalance());

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
                            PIR2.setRemarks("CHEQUE PAYMENT RELEASED");
                            PIR2.setChequeBranch(Recipt.getChequeBranch());
                            PIR2.setAccountBySupplier(Recipt.getAccountByBank());
                            PIR2.setAccountByBank(Recipt.getAccountByBank());
                            PIR2.setCredit(1);
                            PIR2.setDebit(0);
                            ses.save(PIR2);

                            Recipt.setCheStatus(3);
                            ses.update(Bank);
                            ses.update(Recipt);
                            tr.commit();
                            ses.close();
                            out.print("1");

                            break;
                        case 94:
                            SupplierAccount.setDebitBalance(amount + customerCredit);
                            Recipt.setCheStatus(0);
                            Recipt.setStatus(0);
                            ses.update(SupplierAccount);
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
