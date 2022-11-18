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
import resources.Branch;
import resources.Items;
import resources.StockTransfer;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "requestStocksServlet", urlPatterns = {"/requestStocksServlet"})
public class requestStocksServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try{
            User admin  = (User) request.getSession().getAttribute("administrator");
            if(admin != null && request.getParameter("it") != null  && !request.getParameter("it").equals("") && !request.getParameter("it").equals("0")
                    && request.getParameter("br") != null  && !request.getParameter("br").equals("") && !request.getParameter("br").equals("0")
                    && request.getParameter("am") != null  && !request.getParameter("am").equals("") && !request.getParameter("am").equals("0")
                    ){
                
                int BRANCH_ID = Integer.parseInt(request.getParameter("br"));
                int ITEM_ID = Integer.parseInt(request.getParameter("it"));
                double AMOUNT = Double.parseDouble(request.getParameter("am"));
                
                Session ses=connection.getConnection.getSessionFactory().openSession();
                Transaction tr=ses.beginTransaction();
                Branch branch_request = (Branch) ses.load(Branch.class, BRANCH_ID);
                Items item_request = (Items) ses.load(Items.class, ITEM_ID);
                if(AMOUNT > 0){
                    //status 0=request reject 1=pending 2 = accept  3 - cancell from requester
                    StockTransfer st=new StockTransfer();
                    helper help=new helper();
                    st.setDate(help.getDate());
                    st.setTime(help.getTime());
                    st.setItems(item_request);
                    st.setRequestQty(AMOUNT);
                    st.setBranchByFromBranch(admin.getBranch());
                    st.setBranchByToBranch(branch_request);
                    st.setUserByRequestUser(admin);
                    st.setStatus(1);
                    ses.save(st);
                    out.print("1");
                }else{
                   out.print("3"); 
                }
                tr.commit();
                ses.close();
            
            }else{
                out.print("0");
            }
        }catch(Exception e){out.print("0");}
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    

}
