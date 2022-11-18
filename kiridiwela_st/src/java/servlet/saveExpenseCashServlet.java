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
import resources.ExpencessAccount;
import resources.PayExpencess;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveExpenseCashServlet", urlPatterns = {"/saveExpenseCashServlet"})
public class saveExpenseCashServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            if (request.getParameter("payment").equals("") || request.getParameter("account").equals("") || request.getParameter("payment").equals("0") || request.getParameter("account").equals("0")) {

                out.print("0-0");

            } else {
                String Remarks="ISSUE EXPENSES";
                if(request.getParameter("re") != null && ! request.getParameter("re").equals("")){
                    Remarks=request.getParameter("re");
                
                }
                Session ses = connection.getConnection.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                helper help=new helper();

                String Date = new helper().getDate();
                String Time = new helper().getTime();
                int Acc = Integer.parseInt(request.getParameter("account"));
                double payment = Double.parseDouble(request.getParameter("payment"));

                ExpencessAccount ExAccount = (ExpencessAccount) ses.load(ExpencessAccount.class, Acc);
                User User = (User) request.getSession().getAttribute("administrator");
                
                PayExpencess PIR = new PayExpencess();
                PIR.setAmount(payment);
                PIR.setStatus(1);
                PIR.setAddedDate(help.getDate());
                PIR.setAddedTime(help.getTime());
                PIR.setExpencessAccount(ExAccount);
                PIR.setRemark(Remarks);
                PIR.setUser(User);
                ses.save(PIR);

                tr.commit();
                ses.close();
                out.print("1-" + PIR.getIdpayExpencess());

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
