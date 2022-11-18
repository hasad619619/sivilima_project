/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.mail.ByteArrayDataSource;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "sendEmailServlet", urlPatterns = {"/sendEmailServlet"})
public class sendEmailServlet extends HttpServlet {

    public static final String HOST_NAME = "smtp.gmail.com";
    public static final int PORT = 465;
    public static final String TEXT_PLAIN = "text/plain";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            if (request.getParameter("mes").equals("") || request.getParameter("to").equals("") || request.getParameter("from").equals("") || request.getParameter("sub").equals("")) {

                out.print("0");

            } else {

                String Message = request.getParameter("mes");
                String Too = request.getParameter("to");
                String From = request.getParameter("from");
                String subject = request.getParameter("sub");

                try {

                    final String userName = "hackyou567898@gmail.com";
                    final String password = "%%Gw5869";
                    final String recipientEmailAddress = Too;

                    HtmlEmail email = new HtmlEmail();
                    email.setHostName(HOST_NAME);
                    email.setSmtpPort(PORT);
                    email.setSSLOnConnect(true);

                    email.setAuthentication(userName, password);

                    email.setSubject("Some subject");
                    email.setFrom(userName, "Firstname Lastname", String.valueOf(StandardCharsets.UTF_8));
                    email.addTo(recipientEmailAddress);
                    email.setHtmlMsg("<h3>Message body</h3>");

                    //ByteArrayDataSource dataSource = new ByteArrayDataSource(new FileInputStream(attachmentLocation), TEXT_PLAIN);
                    // email.attach(dataSource, "attachment", "attachment");
                    email.send();

                    out.print("1");
                } catch (Exception mex) {
                    mex.printStackTrace();
                    out.print("2");
                }

            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
