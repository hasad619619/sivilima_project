<%-- 
    Document   : purchaseprint
    Created on : Oct 31, 2018, 6:53:37 PM
    Author     : Mayura Lakshan
--%>

<%@page import="resources.PurchusInvoiceRecipt"%>
<%@page import="resources.PurchaseInvoiceOrder"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.InvoiceRecipt"%>
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
        </style>
    </head>
    <body>
        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->


        <%
            String NAME = "";
            DecimalFormat df = new DecimalFormat("##########0.00");
            if (request.getParameter("pid") != null && !request.getParameter("pid").equals("")) {

                Session ses = connection.getConnection.getSessionFactory().openSession();
                PurchusInvoiceRecipt pi = (PurchusInvoiceRecipt) ses.load(PurchusInvoiceRecipt.class, Integer.parseInt(request.getParameter("pid").toString()));
                if (pi != null) {
                    if (pi.getAccountByBank() != null) {
                        NAME = pi.getAccountByBank().getName();
                    }

        %>
        <% if (pi.getPaymentType().getIdpaymentType() == 2) {%>
        <img src="logoimage/<%=pi.getBranch().getReleaseCash() %>" style="width: 100% !important;" />  
        <% } else if (pi.getPaymentType().getIdpaymentType() == 3) {%> 
        <img src="logoimage/<%=pi.getBranch().getReleaseChe() %>" style="width: 100% !important;" />  
        <% } else if (pi.getPaymentType().getIdpaymentType() == 4) {%> 
        <img src="logoimage/<%=pi.getBranch().getReleaseBank() %>" style="width: 100% !important;" />

        <% }%>   
        <div class="container print p-5">
            <div class="row">
                <div class="col-sm-12">
                    <div class="col-sm-6">
                        <table>
                            <tr>
                                <td><p class="mb-0">Date :</p></td>
                                <td>&nbsp;<%= pi.getDate()%></td>
                            </tr>
                            <tr>
                                <td><p class="mb-0">Customer :</p></td>
                                <td>&nbsp;<%= pi.getAccountBySupplier().getName()%></td>
                            </tr>
                            <tr>
                                <td><p class="mb-0">Receipt ID:</p></td>
                                <td>&nbsp;<%= pi.getIdinvoiceRecipt()%></td>
                            </tr>
                            <tr>
                                <td><p class="mb-0">Payment Type:</p></td>
                                <td>&nbsp;<%= pi.getPaymentType().getName()%></td>
                            </tr>
                            <tr>
                                <td><p class="mb-0">User:</p></td>
                                <td>&nbsp;<%= pi.getUser().getName()%></td>
                            </tr>
                        </table>

                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <%
                    if (pi.getPaymentType().getIdpaymentType() == 2) {
                %>
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th style="border: #2d3436 solid 1px !important;">PAYMENT TYPE</th>
                            <th style="border: #2d3436 solid 1px !important;">AMOUNT</th>
                            <th style="border: #2d3436 solid 1px !important;">DATE | TIME</th>

                        </tr>
                    </thead>
                    <tbody>

                        <tr>
                            <td style="border: #2d3436 solid 1px !important;"><%= pi.getPaymentType().getName() + "     " + NAME%></td>
                            <td style="border: #2d3436 solid 1px !important;"><%= df.format(pi.getAmount())%> </td>
                            <td style="border: #2d3436 solid 1px !important;"><%=pi.getDate() + "  " + pi.getTime()%></td>

                        </tr>

                    </tbody>
                </table>
                <%
                    }
                %>
                

                <%
                    if (pi.getPaymentType().getIdpaymentType() == 3) {
                %>
                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th style="border: #2d3436 solid 1px !important;">TYPE</th>
                            <th style="border: #2d3436 solid 1px !important;">AMOUNT</th>
                            <th style="border: #2d3436 solid 1px !important;">DATE | TIME</th>
                            <th style="border: #2d3436 solid 1px !important;">CHEQUE DATE</th>
                            <th style="border: #2d3436 solid 1px !important;">CHEQUE NUMBER</th>
                            <th style="border: #2d3436 solid 1px !important;">CHEQUE BRANCH</th>
                            <th style="border: #2d3436 solid 1px !important;">CHEQUE BANK</th>


                        </tr>
                    </thead>
                    <tbody>

                        <tr>
                            <td style="border: #2d3436 solid 1px !important;"><%= pi.getPaymentType().getName()%></td>
                            <td style="border: #2d3436 solid 1px !important;"><%=df.format(pi.getAmount())%> </td>
                            <td style="border: #2d3436 solid 1px !important;"><%=pi.getDate()%></td>
                            <td style="border: #2d3436 solid 1px !important;"><%=pi.getCheDate()%></td>
                            <td style="border: #2d3436 solid 1px !important;"><%=pi.getCheNumber()%></td>
                            <td style="border: #2d3436 solid 1px !important;"><%=pi.getChequeBranch()%></td>
                            <td style="border: #2d3436 solid 1px !important;"><%=pi.getAccountByBank().getName() %></td>

                        </tr>

                    </tbody>
                </table>
                <%
                    }
                %>
            </div>

            <div class="row">
                <div class="col-xs-2 col-xs-offset-8">
                    <p>
                        <strong>
                            <br>
                            Total Payment RS: <br>
                            <br>

                        </strong>
                    </p>
                </div>
                <div class="col-xs-2">
                    <strong>
                        --------------------- <br>
                        <%= pi.getAmount()%> <br>
                        --------------------- <br>

                    </strong>
                </div>

            </div>
            <div class="row mt-5">
                <div class="col-sm-3 mr-0">
                    <h6>--------------------------<br>Authorized By</h6>
                </div>
                <div class="col-sm-3">
                    <h6>--------------------------<br>Recieve By</h6>
                </div>
                <div class="col-sm-6">

                </div>
            </div>

        </div>
        <img src="logoimage/<%=pi.getBranch().getFooter()%>" style="width: 100% !important;position:fixed !important;bottom: 0px !important;" />

        <%
                }

            }
        %>
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
        doPrint();
        function doPrint() {
            window.print();
            //document.location.href = "purchase.jsp";

        }



    </script>
</html>
