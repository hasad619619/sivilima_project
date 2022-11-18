<%-- 
    Document   : purchaseprint
    Created on : Oct 31, 2018, 6:53:37 PM
    Author     : Mayura Lakshan
--%>

<%@page import="resources.HoldInvoiceItem"%>
<%@page import="resources.HoldInvoice"%>
<%@page import="resources.SaleInvoiceItem"%>
<%@page import="resources.SaleInvoice"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="resources.Settings"%>
<%@page import="java.util.Set"%>
<%@page import="resources.PurchusInvoiceItem"%>
<%@page import="resources.PurchusInvoice"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            if (request.getSession().getAttribute("administrator") == null) {
                response.sendRedirect("login.jsp");
            }


        %>
        <%
                            Session sesDetails=connection.getConnection.getSessionFactory().openSession();
                            Settings st=null;
                            String Name;
                            String Address;
                            String Image;
                            String Fax;
                            String Contact;
                            String Emial;
                            
                            Criteria crDetails=sesDetails.createCriteria(Settings.class);
                            List<Settings> set=crDetails.list();
                            
                            if(set.size()>0){
                                for(Settings ST:set){
                                    if(ST.getIdsettings()==1){
                                        st=ST;
                                        
                                    }
                                }
                            }
                            
                            if(st != null){
                                Name=st.getName();
                                Address=st.getAddress();
                                Image=st.getImage();
                                Fax=st.getFax();
                                Contact=st.getMobile();
                                Emial=st.getEmail(); 
                            }else{
                                Name="";
                                Address="";
                                Image="";
                                Fax="";
                                Contact="";
                                Emial=""; 
                            }
                            sesDetails.close();
                            %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="icon" href="src/image/favicon.ico">
        <title><%= Name %></title>

        <!-- Bootstrap core CSS -->
        <link href="src/boostrap/bootstrap-4.1.3/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
        <!-- Data Tables CDN -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
        <link href="src/css/style.css" rel="stylesheet">
        <style>
            .form-control{
                outline: none !important; 
                border: 1px solid #636e72;
                color: #2d3436;

            }
            .form-control:focus {
                outline: none !important;
                border:1px solid #2980b9;
                box-shadow: 0 0 10px #2980b9;
            }
            .form-control::placeholder { /* Most modern browsers support this now. */
               color:    #2d3436;
            }
        </style>
        <link href="src/datepicker/dist/datepicker.css" rel="stylesheet">
        
    </head>
    <body>
        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->
        
        <div class="container print">
            <%    
                int n=0;
                if (request.getParameter("n") != null && !request.getParameter("n").equals("") ) {
                n=Integer.parseInt(request.getParameter("n").toString()) ;
                }
                if (request.getParameter("pid") != null && !request.getParameter("pid").equals("")) {

                   Session ses = connection.getConnection.getSessionFactory().openSession();
                   HoldInvoice pi = (HoldInvoice) ses.load(HoldInvoice.class, Integer.parseInt(request.getParameter("pid").toString()));
                    if (pi != null) {

            %>
            <div class="row">
                <div class="col-sm-12">
                    <center><h2><%= Name %></h2></center>
                    <div class="col-sm-12">
                        <h2>HOLD INVOICE RECIPT</h2>
                        <table class="table table-sm">
                            <tr>
                                <td><p class="mb-0">Date :</p></td>
                                <td>&nbsp;<%= pi.getDate()%></td>
                                <td><p class="mb-0">Payment Type:</p></td>
                                <td>&nbsp;<%= pi.getPaymentType().getName()%></td>
                            </tr>
                            <tr>
                                <td><p class="mb-0">Customer :</p></td>
                                <td>&nbsp;<%= pi.getAccount().getName()%></td>
                                <td><p class="mb-0">User:</p></td>
                                <td>&nbsp;<%= pi.getUser().getName()%></td>
                            </tr>
                            <tr>
                                <td><p class="mb-0">Invoice ID:</p></td>
                                <td>&nbsp;<%= pi.getIdholdInvoice()%></td>
                                <td><p class="mb-0">Invoice Location:</p></td>
                                <td>&nbsp;<%= pi.getBranch().getName() %></td
                            </tr>
                            
                        </table>

                    </div>
                </div>
            </div>
            <div class="row mt-2">

                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th style="border: #2d3436 solid 1px; text-align: center;">BARCODE / IMEI</th>
                            <th style="border: #2d3436 solid 1px; text-align: center;">DESCRIPTION</th>
                            <th style="border: #2d3436 solid 1px; text-align: center;">QTY</th>
                            <th style="border: #2d3436 solid 1px; text-align: center;">RATE</th>
                            <th style="border: #2d3436 solid 1px; text-align: center;">DESCOUNT</th>
                            <th style="border: #2d3436 solid 1px; text-align: center;">SUB TOTAL</th>
                            
                            <!-- <th>Location</th-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Set<HoldInvoiceItem> pii = pi.getHoldInvoiceItems();
                            for (HoldInvoiceItem PII : pii) {

                        %>
                        <tr>
                            <td style="border: #2d3436 solid 1px; text-align: right;"><%=PII.getItems().getBarcodeId() %></td>
                            <td style="border: #2d3436 solid 1px; text-align: right;"><%=PII.getItems().getName()%></td>
                            <td style="border: #2d3436 solid 1px; text-align: right;"><%= PII.getQtt() + " "+PII.getItems().getType().getName().toUpperCase() %> </td>
                            <td style="border: #2d3436 solid 1px; text-align: right;"><%=PII.getUnitPrice() + "  "%></td>
                            <td style="border: #2d3436 solid 1px; text-align: right;"><%=PII.getDescount() + "  "%></td>
                            <td style="border: #2d3436 solid 1px; text-align: right;"><%=PII.getNetTotal() + "  "%></td>
                          <!--   <td ><%=PII.getLocation() %> </td> -->
                        </tr>
                        <%
                            }

                        %>
                    </tbody>
                </table>

            </div>

                    <div class="row mt-5" style="float: right;" >
                
                
                <div class="col-xs-2 col-xs-offset-8">
                    <p>
                        <strong>
                            Sub Total RS: <br>
                            Discount RS: <br>
                            Return Amount RS: <br>
                            <br>
                            Total RS: <br>
                            <br>
                            Transport RS:
                        </strong>
                    </p>
                </div>
                <div class="col-xs-2">
                    <strong>
                        <%=pi.getNetTotal()%> <br>
                        <%=(pi.getNetTotal() - pi.getTotal())%> <br>
                        <%=pi.getReturnAmount()%><br>
                        -----------------------<br>
                        <%=pi.getTotal()%><br>
                        -----------------------<br>
                        <%=pi.getTransport() %><br>
                    </strong>
                </div>

            </div>
            <%
                    }

                }
            %>
        </div>
        

        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="src/jquery/jquery-1.11.1.min.js" ></script>
        <script src="src/boostrap/bootstrap-4.1.3/js/bootstrap.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js" type="text/javascript"></script>
        <script src="src/datepicker/dist/datepicker.js" type="text/javascript"></script>
        <script src="src/js/printThis.js" type="text/javascript"></script>

    </body>
    <script>
        var i=<%=n %>;
        doPrint();
        function doPrint() {
            if(i === 1 || i=== '1'){
                
                
            }else{
                 window.print();
                
            }
           
            //document.location.href = "purchase.jsp";
           
        }



    </script>
</html>
