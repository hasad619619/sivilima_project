/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.hibernate.Transaction;
import resources.Branch;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveLogoServlet", urlPatterns = {"/saveLogoServlet"})
public class saveLogoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int Branch_ID = 0;
        int TYPE = 0;
        try {

            String contextpath = request.getServletContext().getRealPath("");
            String folderpath = contextpath + "/logoimage";
            File folder = new File(folderpath);

            if (!folder.exists()) {
                folder.mkdir();
            }

            boolean isMultipart = ServletFileUpload.isMultipartContent(request);
            if (!isMultipart) {

            } else {

                //to do this multipart request
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List list = upload.parseRequest(request);
                Iterator itList = list.iterator();

                while (itList.hasNext()) {

                    FileItem item = (FileItem) itList.next();
                    if (item.isFormField()) {
                        switch (item.getFieldName()) {
                            case "branch":
                                Branch_ID = Integer.parseInt(item.getString());
                                break;
                            case "type":
                                TYPE = Integer.parseInt(item.getString());
                                break;
                        }
                    } else {

                        Session ses = connection.getConnection.getSessionFactory().openSession();
                        Transaction tr = ses.beginTransaction();
                        String itemname = item.getName();
                        if (!itemname.equals("")) {

                            if (!itemname.equals("")) {
                                File uploadedFile = new File(folderpath + "/" + itemname);
                                item.write(uploadedFile);
                                Branch ad = (Branch) ses.load(Branch.class, Branch_ID);
                                switch (TYPE) {
                                    case 1:
                                        ad.setQuotation(itemname);
                                        break;
                                    case 2:
                                        ad.setPo(itemname);
                                        break;
                                    case 3:
                                        ad.setInvoice(itemname);
                                        break;
                                    case 4:
                                        ad.setHoldinvoice(itemname);
                                        break;
                                    case 5:
                                        ad.setReceiveCash(itemname);
                                        break;
                                    case 6:
                                        ad.setReleaseCash(itemname);
                                        break;
                                    case 7:
                                        ad.setDoHeader(itemname);
                                        break;
                                    case 8:
                                        ad.setGoodrnHeader(itemname);
                                        break;
                                    case 9:
                                        ad.setInvoiceHeader(itemname);
                                        break;
                                    case 10:
                                        ad.setFooter(itemname);
                                        break;
                                    case 11:
                                        ad.setCreditInvoice(itemname);
                                        break;
                                    case 12:
                                        ad.setReceiveChe(itemname);
                                        break;
                                    case 13:
                                        ad.setReceiveBank(itemname);
                                        break;
                                    case 14:
                                        ad.setReleaseChe(itemname);
                                        break;
                                    case 15:
                                        ad.setReleaseBank(itemname);
                                        break;
                                    case 16:
                                        ad.setExpensesHeader(itemname);
                                        break;
                                }

                                ses.update(ad);

                            }

                        }

                        tr.commit();
                        ses.close();
                        response.sendRedirect("branchlogosetup.jsp?i=1&q=" + Branch_ID);

                    }
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("branchlogosetup.jsp?i=0&q=" + Branch_ID);

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
