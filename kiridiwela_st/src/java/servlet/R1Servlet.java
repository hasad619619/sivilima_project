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
@WebServlet(name = "R1Servlet", urlPatterns = {"/R1Servlet"})
public class R1Servlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getSession().getAttribute("r1") == null) {
            if (request.getParameter("sup").equals("") || request.getParameter("branch").equals("")) {

                out.print("0");

            } else {
                String[] AR = new String[2];
                AR[0] = request.getParameter("sup");
                AR[1] = request.getParameter("branch");
                
                request.getSession().setAttribute("r1", AR);
                out.print("1");
            }
        } else {

            request.getSession().removeAttribute("r1");
            if (request.getParameter("sup").equals("") || request.getParameter("branch").equals("")) {

                out.print("0");

            } else {
                String[] AR = new String[2];
                AR[0] = request.getParameter("sup");
                AR[1] = request.getParameter("branch");
                request.getSession().setAttribute("r1", AR);
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
