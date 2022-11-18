/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dataclass.helper;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import resources.Account;
import resources.Brand;
import resources.Category;
import resources.ItemSub;
import resources.ItemThird;
import resources.Items;
import resources.SubCategory;
import resources.ThirdCategory;
import resources.Type;
import resources.User;

/**
 *
 * @author Mayura Lakshan
 */
@WebServlet(name = "saveItemServlet", urlPatterns = {"/saveItemServlet"})

public class saveItemServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {

            if (request.getSession().getAttribute("administrator") != null) {
                HttpSession mainses = request.getSession(true);
                User admin = (User) mainses.getAttribute("administrator");

                if (admin.getLevel() == 1) {

                    String IMG = "N/A";
                    String name = "";
                    String barcode = "";
                    String type = "";
                    String brand = "";
                    String category = "";
                    String supp = "";
                    String sub_category = "";
                    String other_category = "";
                    double H = 0.0;
                    double W = 0.0;

                    String contextpath = request.getServletContext().getRealPath("");
                    String folderpath = contextpath + "/itemimage";
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
                                    case "name":
                                        name = item.getString();
                                        break;
                                    case "bi":
                                        barcode = item.getString();

                                        break;
                                    case "ty":
                                        type = item.getString();
                                        break;
                                    case "br":
                                        brand = item.getString();
                                        break;
                                    case "ct":
                                        category = item.getString();
                                        break;
                                    case "sp":
                                        supp = item.getString();
                                        break;
                                    case "sct":
                                        sub_category = item.getString();
                                        break;
                                    case "oct":
                                        other_category = item.getString();
                                        break;
                                    case "w":
                                        W = Double.parseDouble(item.getString());
                                        break;
                                    case "h":
                                        H = Double.parseDouble(item.getString());
                                        break;
                                    default:
                                        break;
                                }
                            } else //to do this is a file
                            //todo file upoad
                            {
                                if (false) {
                                    response.sendRedirect("inventory.jsp?q=0");
                                } else {

                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(Items.class);
                                    cr.add(Restrictions.eq("barcodeId", barcode));
                                    List<Items> L = cr.list();
                                    if (L.size() > 0) {
                                        response.sendRedirect("inventory.jsp?q=4");
                                    } else {

                                        Transaction tr = ses.beginTransaction();
                                        helper h = new helper();
                                        Type t = (Type) ses.load(Type.class, Integer.parseInt(type));
                                        Brand b = (Brand) ses.load(Brand.class, Integer.parseInt(brand));
                                        Category c = (Category) ses.load(Category.class, Integer.parseInt(category));
                                        Account s = (Account) ses.load(Account.class, Integer.parseInt(supp));
                                        Items ad = new Items();
                                        ad.setName(name);
                                        ad.setBarcodeId(barcode);
                                        ad.setDate(h.getDate());
                                        ad.setType(t);
                                        ad.setStatus(1);
                                        ad.setAccount(s);
                                        ad.setCategory(c);
                                        ad.setBrand(b);
                                        ad.setImage(IMG);
                                        ad.setHe(H);
                                        ad.setWi(W);
                                        ses.save(ad);
                                        String itemname = item.getName();
                                        if (!sub_category.equals("")) {
                                            String[] sub_list = sub_category.split(",");
                                            for (String sub : sub_list) {
                                                int SUB_ID = Integer.parseInt(sub);
                                                if (SUB_ID > 0) {
                                                    SubCategory sc = (SubCategory) ses.load(SubCategory.class, SUB_ID);
                                                    ItemSub IS = new ItemSub();
                                                    IS.setItems(ad);
                                                    IS.setSubCategory(sc);
                                                    ses.save(IS);
                                                }
                                            }

                                        }

                                        if (!other_category.equals("")) {
                                            String[] other_list = other_category.split(",");
                                            for (String other : other_list) {
                                                int OTHER_ID = Integer.parseInt(other);
                                                if (OTHER_ID > 0) {
                                                    ThirdCategory sc = (ThirdCategory) ses.load(ThirdCategory.class, OTHER_ID);
                                                    ItemThird IS = new ItemThird();
                                                    IS.setItems(ad);
                                                    IS.setThirdCategory(sc);
                                                    ses.save(IS);
                                                }
                                            }

                                        }

                                        String EXT = FilenameUtils.getExtension(itemname);
                                        IMG = ad.getItemId() + "." + EXT;

                                        itemname = IMG;

                                        if (!itemname.equals("") && !itemname.equals("N/A")) {
                                            File uploadedFile = new File(folderpath + "/" + itemname);

                                            item.write(uploadedFile);

                                        }
                                        
                                        Items IT = (Items) ses.load(Items.class, ad.getItemId());
                                        IT.setImage(IMG);
                                        ses.update(IT);
                                        tr.commit();
                                        ses.close();
                                        response.sendRedirect("inventory.jsp?q=1&i="+IT.getItemId());

                                    }

                                }
                            }
                        }

                    }

                } else {

                    response.sendRedirect("inventory.jsp?q=3");

                }

            } else {

                response.sendRedirect("inventory.jsp?q=3");

            }

        } catch (Exception e) {

            e.printStackTrace();

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
