<%-- 
    Document   : purchaseprint
    Created on : Oct 31, 2018, 6:53:37 PM
    Author     : Mayura Lakshan
--%>

<%@page import="resources.DoHoldItem"%>
<%@page import="resources.DoItem"%>
<%@page import="resources.HoldInvoiceItem"%>
<%@page import="resources.Deo"%>
<%@page import="resources.PoOrderItems"%>
<%@page import="resources.PurchaseInvoiceOrder"%>
<%@page import="resources.QuotationInvoiceItem"%>
<%@page import="resources.QuotationInvoice"%>
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
        <%            Session sesDetails = connection.getConnection.getSessionFactory().openSession();
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
            body,h1,h2,h3,h4,h5,h6,p,td,tr,div{
                color: black !important;
            }
        </style>
    </head>
    <body>
        

        <div class="container print">
            <%
                int n = 0;
                if (request.getParameter("n") != null && !request.getParameter("n").equals("")) {
                    n = Integer.parseInt(request.getParameter("n").toString());
                }
                if (request.getParameter("q") != null && !request.getParameter("q").equals("")) {

                    Session ses = connection.getConnection.getSessionFactory().openSession();
                    Deo p = (Deo) ses.load(Deo.class, Integer.parseInt(request.getParameter("q").toString()));
                    if (p != null) {

            %>
            <div class="row mt-5 mb-5">
                <div class="col-sm-2">
                    <img src="src/image/siv.jpeg" height="50" class="mb-1">
                </div>
                <div class="col-sm-6 mr-0">
                    <h4><%="සිවිලිම කිරිදිවෙල"%></h4>
                    <h6>Email: <%=Emial%></h6>
                    <h6>TP: <%=Contact%> Fax: <%=Fax%></h6>
                </div>
                <div class="col-sm-4">
                    Delivery Number : <%="#" + p.getIddo()%><br>
                    Lorry Number : ---------------------<br>

                </div>





            </div>

            <h2 style=" color: black !important;"># Delivery order</h2>
            <table class="table table-bordered table-sm" style=" color: black !important;">
                <tr>
                    <td>DATE</td>
                    <td>TIME</td>
                    <td>REMARK</td>
                </tr>
                <tr>
                    <td><%=p.getDate()%></td>
                    <td><%=p.getTime()%></td>
                    <td><%=p.getRemark()%></td>
                </tr>
            </table>
            <%      int i = 0;
                Set<DoItem> dii = p.getDoItems();
                for (DoItem h : dii) {
                    i++;

            %>
            <div class="row mt-2">
                <h1><%=i%>------------------------------------------------------------</h1>
                <div class="col-sm-12">


                    <table class="table">
                        <tr>
                            <td><p class="mb-0">Date :</p></td>
                            <td>&nbsp;<%= h.getSendDate()%></td>
                            <td><p class="mb-0">Transport RS:</p></td>
                            <td>&nbsp;<%= h.getTransport()%></td>
                        </tr>
                        <tr>
                            <td><p class="mb-0">Customer :</p></td>
                            <td>&nbsp;<%= h.getHoldInvoice().getAccount().getName()%></td>
                            <td><p class="mb-0">Invoiced Date :</p></td>
                            <td>&nbsp;<%= h.getHoldInvoice().getDate()%></td>
                        </tr>

                    </table>


                </div>
            </div>
            <div class="row mt-2">

                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th>QTY</th>



                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Set<DoHoldItem> dhi = h.getDoHoldItems();
                            for (DoHoldItem PII : dhi) {

                        %>
                        <tr>
                            <td><%=PII.getHoldInvoiceItem().getItems().getName()%></td>
                            <td><%=PII.getQty() + " " + PII.getHoldInvoiceItem().getNowType()%></td>


                        </tr>
                        <%
                            }

                        %>
                    </tbody>
                </table>

            </div>
            <h1>-------------------------------------------------------------</h1>       


            <%                        }
            %> 
            <div class="row">
                <div class="col-sm-8 mt-5">
                    <h5>ඉහත සදහන්  භාණ්ඩ නියමිත ගුණාත්වයෙන්  සහ ඇනවුම්  කල ප්‍රමාණයෙන්  ගෙන්  ලබා ගතිමි.</h5>
                </div>
                <div class="col-sm-12">
                    <div class="row mt-5">
                        <div class="col">
                            --------------------------<br>
                            <h6>Agent's Signature</h6>

                        </div>
                        <div class="col">
                            --------------------------<br>
                            <h6>Driver's Signature</h6>
                        </div>

                    </div>
                </div>
            </div>



            <p style="page-break-before: always ;padding-top: 35px;">
                <%
                    Set<DoItem> diii = p.getDoItems();
                    for (DoItem h : diii) {


                %>

            <div class="row mt-5 mb-5">
                <div class="col-sm-2">
                    <img src="src/image/siv.jpeg" height="50" class="mb-1">
                </div>
                <div class="col-sm-6 mr-0">
                    <h4><%="සිවිලිම කිරිදිවෙල"%></h4>
                    <h6>Email: <%=Emial%></h6>
                    <h6>TP: <%=Contact%> Fax: <%=Fax%></h6>
                </div>





            </div>
            <div class="row">
                <div class="col-sm-12">

                    <div class="col-sm-12">
                        <h4># CONFORM GOODS RECEIVED</h4>
                        <table class="table table-sm">
                            <tr>
                                <td><p class="mb-0">Date :</p></td>
                                <td>&nbsp;<%= h.getSendDate()%></td>
                                <td><p class="mb-0">Transport RS:</p></td>
                                <td>&nbsp;<%= h.getTransport()%></td>
                            </tr>
                            <tr>
                                <td><p class="mb-0">Customer :</p></td>
                                <td>&nbsp;<%= h.getHoldInvoice().getAccount().getName()%></td>
                                <td><p class="mb-0">Invoiced Date :</p></td>
                                <td>&nbsp;<%= h.getHoldInvoice().getDate()%></td>
                            </tr>

                        </table>

                    </div>
                </div>
            </div>
            <div class="row mt-2">

                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Item</th>
                            <th>QTY</th>



                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Set<DoHoldItem> dhi = h.getDoHoldItems();
                            for (DoHoldItem PII : dhi) {

                        %>
                        <tr>
                            <td><%=PII.getHoldInvoiceItem().getItems().getName()%></td>
                            <td><%=PII.getQty() + " " + PII.getHoldInvoiceItem().getNowType()%></td>


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
                            ---------------------------------<br>
                            (Customer Signature)
                        </strong>
                    </p>
                </div>


            </div>
                <% 
                 }
                %>    


            <p style="page-break-before: always">
                
                
                <%
                    Set<DoItem> di = p.getDoItems();
                    for (DoItem h : di) {
                        HoldInvoice pi = h.getHoldInvoice();
                        if (pi != null) {

                %>
            <div class="printInvoice" style=" background-image:url('src/image/cinvoice.gif') !important; background-repeat:no-repeat !important;background-size:cover !important;">
            <div class="row mt-5 mb-5">
                <div class="col-sm-2">
                    <img src="src/image/siv.jpeg" height="50" class="mb-1">
                </div>
                <div class="col-sm-6 mr-0">
                    <h4><%="සිවිලිම කිරිදිවෙල"%></h4>
                    <h6>Email: <%=Emial%></h6>
                    <h6>TP: <%=Contact%> Fax: <%=Fax%></h6>
                </div>





            </div> 
            <div class="row">
                <div class="col-sm-12">
                    <div class="col-sm-12">
                        <h4>INVOICE RECEPT</h4>
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
                                <td>&nbsp;<%= pi.getBranch().getName()%></td
                            </tr>

                        </table>

                    </div>
                </div>
            </div>
            <div class="row mt-2">

                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th>Item Id</th>
                            <th>Description</th>
                            <th>Qty</th>
                            <th>MRP</th>
                            <th>Discount Rate</th>
                            <th>Sub Total</th>

                            <!-- <th>Location</th-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Set<HoldInvoiceItem> pii = pi.getHoldInvoiceItems();
                            for (HoldInvoiceItem PII : pii) {

                        %>
                        <tr>
                            <td><%=PII.getItems().getItemId()%></td>
                            <td><%=PII.getItems().getName()%></td>
                            <td><%= PII.getQtt() + " "%> </td>
                            <td><%=PII.getUnitPrice() + "  "%></td>
                            <td><%=PII.getDescount() + "  "%></td>
                            <td ><%=PII.getNetTotal() + "  "%></td>
                          <!--   <td ><%=PII.getLocation()%> </td> -->
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
                            Total RS: <br>
                            <br>
                            Payable Balance RS: <br>
                            <br>
                            Transport RS:
                        </strong>
                    </p>
                </div>
                <div class="col-xs-2">
                    <strong>
                        <%=pi.getNetTotal()%> <br>
                        <%=(pi.getNetTotal() - pi.getTotal())%> <br>
                        <%=pi.getTotal()%><br>
                        -----------------------<br>
                        <%=pi.getPaible()%><br>
                        -----------------------<br>
                        <%=pi.getTransport()%><br>
                    </strong>
                </div>

            </div>
        </div>        

            
            <%
                    }
                }
            %>










            <%                    }

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
