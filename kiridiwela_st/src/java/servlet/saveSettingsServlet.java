/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Settings;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveSettingsServlet", urlPatterns = {"/saveSettingsServlet"})
public class saveSettingsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (request.getParameter("name") != null && !request.getParameter("name").equals("")
                && request.getParameter("contact") != null && !request.getParameter("contact").equals("")
                && request.getParameter("email") != null && !request.getParameter("email").equals("")
                && request.getParameter("address") != null && !request.getParameter("address").equals("")
                && request.getParameter("fax") != null && !request.getParameter("fax").equals("")
                && request.getParameter("image") != null && !request.getParameter("image").equals("")) {

            String Name = request.getParameter("name");
            String Email = request.getParameter("email");
            String Address = request.getParameter("address");
            String Fax = request.getParameter("fax");
            String Contact = request.getParameter("contact");
            String Image = request.getParameter("image");

            Session ses = connection.getConnection.getSessionFactory().openSession();
            Transaction tr=ses.beginTransaction();
            Settings st = null;

            Criteria cr = ses.createCriteria(Settings.class);
            List<Settings> set = cr.list();

            if (set.size() > 0) {
                for (Settings ST : set) {
                    if (ST.getIdsettings() == 1) {
                        st = ST;

                    }
                }
            }

            if (st != null) {
                st.setIdsettings(1);
                st.setName(Name);
                st.setAddress(Address);
                st.setMobile(Contact);
                st.setEmail(Email);
                st.setImage(Image);
                st.setFax(Fax);
                ses.update(st);
                out.print("1");
            } else {
                st = new Settings();
                st.setIdsettings(1);
                st.setName(Name);
                st.setAddress(Address);
                st.setMobile(Contact);
                st.setEmail(Email);
                st.setFax(Fax);
                st.setImage(Image);
                ses.save(st);
                out.print("1");
            }
            tr.commit();
            ses.close();

        } else {
            out.print("0");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
