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
import org.hibernate.Session;
import resources.Items;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "getItemServlet", urlPatterns = {"/getItemServlet"})
public class getItemServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        if (request.getParameter("id").equals("")) {
            out.print("<p>NO DATA RECIVED !</p>");

        } else {
            String id = request.getParameter("id");
            Session ses = connection.getConnection.getSessionFactory().openSession();
            Items ad = (Items) ses.load(Items.class, Integer.parseInt(id));
            out.print("<table class=\"table\">");

            out.print("<tr>");
            out.print("<td><span class=\"badge bg-info\">Item ID:</span></td><td><strong>" + ad.getItemId() + "</strong><td>");
            out.print("</tr>");

            out.print("<tr>");
            out.print("<td><span class=\"badge bg-info\">Item Name:</span></td><td><strong>" + ad.getName() + "</strong><td>");
            out.print("</tr>");

            out.print("<tr>");
            out.print("<td><span class=\"badge bg-info\">Barcode ID:</span></td><td><strong>" + ad.getBarcodeId() + "</strong><td>");
            out.print("</tr>");

            out.print("<tr>");
            out.print("<td><span class=\"badge bg-info\">Insert Date:</span></td><td><strong>" + ad.getDate() + "</strong><td>");
            out.print("</tr>");

            out.print("<tr>");
            out.print("<td><span class=\"badge bg-info\">Brand:</span></td><td><strong>" + ad.getBrand().getName() + "</strong><td>");
            out.print("</tr>");

            out.print("<tr>");
            out.print("<td><span class=\"badge bg-info\">Category:</span></td><td><strong>" + ad.getCategory().getName() + "</strong><td>");
            out.print("</tr>");
            out.print("<tr>");
            out.print("<td><span class=\"badge bg-info\">Height(Inch):</span></td><td><strong>" + ad.getHe() + "</strong><td>");
            out.print("</tr>");
            out.print("<tr>");
            out.print("<td><span class=\"badge bg-info\">Width(Inch):</span></td><td><strong>" + ad.getWi() + "</strong><td>");
            out.print("</tr>");

//            out.print("<tr>");
//            out.print("<td><span class=\"badge bg-info\">Sub Category:</span></td><td><strong>" + ad.getSubCategory().getName() + "</strong><td>");
//            out.print("</tr>");
//            out.print("<tr>");
//            out.print("<td><span class=\"badge bg-info\">Other Category:</span></td><td><strong>" + ad.getThirdCategory().getName() + "</strong><td>");
//            out.print("</tr>");
            out.print("<tr>");
            out.print("<td><span class=\"badge bg-info\">Supplier:</span></td><td><strong>" + ad.getAccount().getName() + "</strong><td>");
            out.print("</tr>");

            if (ad.getImage().split("\\.").length == 2) {
                out.print("<tr>");
                out.print("<td><span class=\"badge bg-info\">Image:</span></td><td> <img src=" + "itemimage/" + ad.getImage() + " id=\"profile-img-tag\" width=\"200px\" /></td>");
                out.print("</tr>");

            } else {
                out.print("<tr>");
                out.print("<td><span class=\"badge bg-info\">Image:</span></td><td> <img src=\"src/image/no_image.jpg\" id=\"profile-img-tag\" width=\"200px\" /></td>");
                out.print("</tr>");

            }

            out.print("</table>");

            ses.close();

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
