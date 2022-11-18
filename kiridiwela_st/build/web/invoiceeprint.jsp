<%-- 
    Document   : purchaseprint
    Created on : Oct 31, 2018, 6:53:37 PM
    Author     : Mayura Lakshan
--%>

<%@page import="resources.InvoiceRecipt"%>
<%@page import="java.text.DecimalFormat"%>
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
            Session sesDetails = connection.getConnection.getSessionFactory().openSession();
            Settings st = null;
            String Name;
            String Address;
            String Image;
            String Fax;
            String Contact;
            String Emial;

            Criteria crDetails = sesDetails.createCriteria(Settings.class);
            List<Settings> set = crDetails.list();

            if (set.size() > 0) {
                for (Settings ST : set) {
                    if (ST.getIdsettings() == 1) {
                        st = ST;

                    }
                }
            }

            if (st != null) {
                Name = st.getName();
                Address = st.getAddress();
                Image = st.getImage();
                Fax = st.getFax();
                Contact = st.getMobile();
                Emial = st.getEmail();
            } else {
                Name = "";
                Address = "";
                Image = "";
                Fax = "";
                Contact = "";
                Emial = "";
            }
            sesDetails.close();
        %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="icon" href="src/image/favicon.ico">
        <title><%= Name%></title>

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
        <style>
            h4,h5,h3,td,th,h6,h3,h1,h2,strong{
                color: #2c3e50;
            }
            
            @page {
                size: A4;
                margin: 0;
            }
            @media print {
                html, body {
                    width: 210mm;
                    height: 297mm;
                }
                /* ... the rest of the rules ... */
            }




        </style>
    </head>
    <%
        int n = 0;
        DecimalFormat df = new DecimalFormat("##########0.00");
        if (request.getParameter("n") != null && !request.getParameter("n").equals("")) {
            n = Integer.parseInt(request.getParameter("n").toString());
        }
        
        if (request.getParameter("pid") != null && !request.getParameter("pid").equals("")) {

            Session ses = connection.getConnection.getSessionFactory().openSession();
            SaleInvoice pi = (SaleInvoice) ses.load(SaleInvoice.class, Integer.parseInt(request.getParameter("pid").toString()));
            if (pi != null) {

    %>
    <% if (pi.getPaymentType().getIdpaymentType() == 1 && n != 1) { %>
    <body style=" background-image:url('logoimage/<%=pi.getBranch().getInvoice() %>'); background-repeat:no-repeat;background-size:cover;width: auto;height: auto;"> 
        <% } else if(n != 1) {%> 
    <body style=" background-image:url('logoimage/<%=pi.getBranch().getCreditInvoice()%>'); background-repeat:no-repeat;background-size:cover;width: auto;height: auto;"> 
        <% }else{%> 
    <body> 
        
        <% }%> 
        <div class="container print">
            
            <div class="row" style="margin-top: 150px;">

            </div>
            <div class="row ml-5">
                <div class="col-sm-3">
                    <table class="table table-sm">
                        <tr>
                            <td style="border: #2d3436 solid 1px !important;"><h6 class="mb-0">Date :</h6></td>
                            <td style="border: #2d3436 solid 1px !important;"><h6 class="mb-0"><%= pi.getDate()%></h6></td>
                        </tr>
                        <tr>
                            <td style="border: #2d3436 solid 1px !important;"><h6 class="mb-0">Invoice ID :</h6></td>
                            <td style="border: #2d3436 solid 1px !important;"><h6 class="mb-0"><%= pi.getIdsaleInvoice()%></h6></td>
                        </tr>
                    </table>

                </div>
                <div class="col-sm-6">

                </div>
                <div class="col-sm-3">

                </div>
            </div>

            <div class="row ml-5">

                <div class="col-sm-12">


                    <table class="table-sm">
                        <tr>
                            <td><h6 class="mb-0">Customer Name :</h6></td>
                            <td>&nbsp;<%=  pi.getAccount().getName()%></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><h6 class="mb-0">User :</h6></td>
                            <td>&nbsp;<%=  pi.getUser().getName()%></td>

                        </tr>
                        <tr>
                            <td><h6 class="mb-0">Contact Number :</h6></td>
                            <td>&nbsp;<%= pi.getAccount().getContact()%></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><h6 class="mb-0">Invoice Location :</h6></td>
                            <td>&nbsp;<%=  pi.getBranch().getName()%></td>
                        </tr>
                        <tr>
                            <td><h6 class="mb-0">Payment Type :</h6></td>
                            <td>&nbsp;<%= pi.getPaymentType().getName()%></td>
                        </tr>


                    </table>


                </div>
            </div>
            <div class="row mt-2 ml-1 mr-1">

                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th style="border: #2d3436 solid 1px !important; text-align: center;">BARCODE / IMEI</th>
                            <th style="border: #2d3436 solid 1px !important; text-align: center;">DESCRIPTION</th>
                            <th style="border: #2d3436 solid 1px !important; text-align: center;">QTY</th>
                            <th style="border: #2d3436 solid 1px !important; text-align: center;">MRP</th>
                            <th style="border: #2d3436 solid 1px !important; text-align: center;">DISC RATE</th>
                            <th style="border: #2d3436 solid 1px !important; text-align: center;">TOTAL</th>
                            <th style="border: #2d3436 solid 1px !important; text-align: center;">DISC.</th>
                            <th style="border: #2d3436 solid 1px !important; text-align: center;">SUB TOTAL</th>

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Set<SaleInvoiceItem> pii = pi.getSaleInvoiceItems();
                            for (SaleInvoiceItem PII : pii) {

                        %>
                        <tr>
                            <td style="border: #2d3436 solid 1px !important; text-align: right;"><%=PII.getItems().getBarcodeId() %></td>
                            <td style="border: #2d3436 solid 1px !important; text-align: right;"><%=PII.getItems().getName()%></td>
                            <td style="border: #2d3436 solid 1px !important; text-align: right;"><%= PII.getQtt() + " " +PII.getItems().getType().getName().toUpperCase() %> </td>
                            <td style="border: #2d3436 solid 1px !important; text-align: right;"><%=PII.getUnitPrice() + "  "%></td>
                            <td style="border: #2d3436 solid 1px !important; text-align: right;"><%=PII.getDescountRate() + "  "%></td>
                            <td style="border: #2d3436 solid 1px !important; text-align: right;"><%=PII.getTotal() + "  "%></td>
                            <td style="border: #2d3436 solid 1px !important; text-align: right;"><%=PII.getDescount() + "  "%></td>
                            <td style="border: #2d3436 solid 1px !important; text-align: right;"><%=PII.getNetTotal() + "  "%></td>

                        </tr>
                        <%
                            }

                        %>
                    </tbody>
                </table>

            </div>
            <div class="row">
                <div class="col-sm-7">

                </div>
                <div class="col-sm-2">
                    <div class="col-xs-2 col-xs-offset-8">
                        <p>
                            <strong>
                                Sub Total RS: <br>
                                Discount RS: <br>
                                Return Amount RS: <br>
                                <br>
                                Total RS: <br>
                                <br>
                                Paid RS:
                                <br>
                                <br>
                                Invoice Balance RS:
                                <br>
                                <br>
                                Transport RS:
                            </strong>
                        </p>
                    </div>

                </div>
                <div class="col-sm-3">
                    <div class="col-xs-2">
                        <strong>
                            <%=df.format(pi.getNetTotal())%> <br>
                            <%=df.format((pi.getNetTotal() - pi.getTotal()))%> <br>
                            <%= df.format(pi.getReturnAmount())%><br>
                            -----------------------<br>
                            <%= df.format(pi.getTotal())%><br>
                            -----------------------<br>
                            <%= df.format(pi.getPaid())%><br>
                            -----------------------<br>
                            <%= df.format((pi.getTotal() - pi.getPaid()))%><br>
                            -----------------------<br>
                            <%=df.format(pi.getTransport())%><br>
                        </strong>
                    </div>
                </div>
            </div>

            <div class="row mt-1">
                <div class="col-sm-4">
                    
                </div>
                <div class="col-sm-8  mr-1">
                    <% if(pi.getPaymentType().getIdpaymentType() == 3){ %>
                    <p>Cheque Details</p>
                    <table>
                        <thead>
                            <tr>
                                <th style="border: #2d3436 solid 1px;padding: 3px;">Bank</th>
                        <th style="border: #2d3436 solid 1px;padding: 3px;">Cheque Number</th>
                        <th style="border: #2d3436 solid 1px;padding: 3px;">Amount</th>
                        <th style="border: #2d3436 solid 1px;padding: 3px;">Check Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                Set<InvoiceRecipt> ir = pi.getInvoiceRecipts();
                                for(InvoiceRecipt p : ir){
                                    if(p.getPaymentType().getIdpaymentType() == 3){
                            %>
                            <tr>
                        <td style="border: #2d3436 solid 1px;"><%=p.getBank()+" - "+p.getChequeBranch() %></td>
                        <td style="border: #2d3436 solid 1px;"><%=p.getCheNumber() %></td>
                        <td style="border: #2d3436 solid 1px;">RS. <%=df.format(p.getAmount()) %> Only</td>
                        <td style="border: #2d3436 solid 1px;"><%=p.getCheDate() %></td>
                            </tr>
                        </tbody>
                    </table>
                     <% }}}%>
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
        var i =<%=n%>;
        doPrint();
        function doPrint() {
            if (i === 1 || i === '1') {


            } else {
                window.print();

            }

            //document.location.href = "purchase.jsp";

        }



    </script>
</html>
