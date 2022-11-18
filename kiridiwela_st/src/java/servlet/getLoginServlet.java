/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.userHolder;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import resources.User;

@WebServlet(name = "getLoginServlet", urlPatterns = {"/getLoginServlet"})
public class getLoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("email").equals("") || request.getParameter("password").equals("")) {

            out.print(0);

        } else {
            
            Session ses = connection.getConnection.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(User.class);
            cr.add(Restrictions.eq("username", request.getParameter("email")));
            cr.add(Restrictions.eq("password", request.getParameter("password")));
            cr.add(Restrictions.eq("status", 1));
            List<User> AD = cr.list();
            if (AD.size() == 1) {
                HttpSession session = request.getSession(true);
                for(User A:AD) {
                    userHolder USER =  new userHolder();
                    USER.setName(A.getName());
                    USER.setBranch(A.getBranch().getName());
                    USER.setAccount(A.getAc());
                    USER.setCreate(A.getCr());
                    USER.setAdministrator(A.getAd());
                    USER.setInvoicing(A.getInv());
                    USER.setStocks(A.getSt());
                    USER.setAccounting(A.getAcc());
                    USER.setCheque(A.getCh());
                    USER.setOther(A.getOt());
                    USER.setReports(A.getRe());
                    USER.setId(A.getIduser());
                    session.setAttribute("administrator", A);
                    session.setAttribute("userHolder", USER);
                }

                out.print("1");

            } else {
                out.print("2");

            }
            ses.close();
        }
        
        
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
