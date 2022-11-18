/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "Po1Servlet", urlPatterns = {"/Po1Servlet"})
public class Po1Servlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getSession().getAttribute("po1") == null) {
            if ( request.getParameter("date").equals("") || request.getParameter("user").equals("") || request.getParameter("sup").equals("") || request.getParameter("branch").equals("")) {

                out.print("0");

            } else {
                String[] AR = new String[5];
                AR[0] = "1";
                AR[1] = request.getParameter("date");
                AR[2] = request.getParameter("user");
                AR[3] = request.getParameter("sup");
                AR[4] = request.getParameter("branch");
                
                request.getSession().setAttribute("po1", AR);
                out.print("1");
            }
        } else {

            request.getSession().removeAttribute("po1");
            if ( request.getParameter("date").equals("") || request.getParameter("user").equals("") || request.getParameter("sup").equals("") || request.getParameter("branch").equals("")) {

                out.print("0");

            } else {
                String[] AR = new String[5];
                AR[0] = "1";
                AR[1] = request.getParameter("date");
                AR[2] = request.getParameter("user");
                AR[3] = request.getParameter("sup");
                AR[4] = request.getParameter("branch");
                request.getSession().setAttribute("po1", AR);
                out.print("1");
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
