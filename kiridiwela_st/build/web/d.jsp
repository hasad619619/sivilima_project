

<%@page import="java.io.IOException"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.List"%>
<%@page import="resources.Items"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.io.File"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>downloading....</h1>
        <%
            Session ses = connection.getConnection.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(Items.class);
            List<Items> it = cr.list();
            for (Items IT : it) {
        %>
        <h1><%=IT.getName() + "-" + IT.getImage()%></h1>
        <%

                try (BufferedInputStream inputStream = new BufferedInputStream(new URL("https://tinyjpg.com/images/social/website.jpg").openStream());
                        FileOutputStream fileOS = new FileOutputStream("E:/items/new.jpg")) {
                    byte data[] = new byte[1024];
                    int byteContent;
                    while ((byteContent = inputStream.read(data, 0, 1024)) != -1) {
                        fileOS.write(data, 0, byteContent);
                    }
                } catch (IOException e) {
                    // handles IO exceptions
                }

            }
        %>

        <h1>ok !</h1>


    </body>
</html>
