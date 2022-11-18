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
import java.util.Set;
import javafx.scene.control.Accordion;
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
import resources.Branch;
import resources.CustomerBranch;
import resources.EmployeeAccount;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "emp", urlPatterns = {"/emp"})
public class emp extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Session s = connection.getConnection.getSessionFactory().openSession();
            Transaction tr=s.beginTransaction();
            Criteria cr = s.createCriteria(Account.class);
            cr.add(Restrictions.eq("status", 1));
            List<Account> la = cr.list();
            helper help = new helper();
            User user = (User) s.load(User.class, 1);
            for (Account a : la) {
                if (a.getEmployee() == 1) {
                    EmployeeAccount ec = new EmployeeAccount();
                    ec.setName(a.getName());
                    ec.setAddedDate(help.getDate());
                    ec.setAddedTime(help.getTime());
                    ec.setStatus(1);
                    Branch BRANCH = null;
                    Set<CustomerBranch> cb = a.getCustomerBranches();
                    for (CustomerBranch c : cb) {
                        BRANCH = c.getBranch(); 
                    }
                    if(BRANCH == null){
                        BRANCH = (Branch) s.load(Branch.class, 2);
                    }
                    ec.setUser(user);
                    ec.setBranch(BRANCH);
                    s.save(ec);
                }
            }
            tr.commit();
            s.close();
            out.print("1");
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
