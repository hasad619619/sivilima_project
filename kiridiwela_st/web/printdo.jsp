<%-- 
    Document   : purchaseprint
    Created on : Oct 31, 2018, 6:53:37 PM
    Author     : Mayura Lakshan
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.Branch"%>
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
            body,h1,h2,h3,h4,h5,h6,p,td,tr,div{
                color: black !important;
            }
        </style>
    </head>
    <%          DecimalFormat  df = new DecimalFormat("##########0.00");
                int n = 0;
                if (request.getParameter("n") != null && !request.getParameter("n").equals("")) {
                    n = Integer.parseInt(request.getParameter("n").toString());
                }
                if (request.getParameter("q") != null && !request.getParameter("q").equals("")) {

                    Session ses = connection.getConnection.getSessionFactory().openSession();
                    Deo p = (Deo) ses.load(Deo.class, Integer.parseInt(request.getParameter("q").toString()));
                    if (p != null) {
                    Branch br=null;
                    Set<DoItem> dh= p.getDoItems();
                    for(DoItem d:dh){
                       br = d.getHoldInvoice().getBranch();
                    }
                    if(br != null){

            %>
    <body>
        <!-- main do document -->
        <img src="logoimage/<%=br.getDoHeader()%>" style="width: 100% !important;" />
        <div class="container p-5">    
            

            <div class="row ">



                <div class="col-sm-4">
                    <h6>Email: <%=Emial%></h6>
                    <h6>TP: <%=Contact%> Fax: <%=Fax%></h6>
                </div>
                <div class="col-sm-4">
                    <h6>Delivery Number : <%="#" + p.getIddo()%></h6>
                    <h6>Lorry Number : ---------------------</h6>

                </div>
                <div class="col-sm-4">
                    <h6><%= p.getDate() + "   " + p.getTime()%></h6>
                    <h6><%= p.getRemark()%></h6>

                </div>



            </div>
            <table class="table table-bordered">


                <%
                    int i = 0;
                    Set<DoItem> dii = p.getDoItems();
                    for (DoItem h : dii) {
                        i++;

                %>






                <tr>
                    <td  style="border: #2d3436 solid 1px !important;">
                        <h3><%="#"+i %></h3>
                        <p class="mb-0">Date :&nbsp;<%= h.getSendDate()%></p>
                        <p class="mb-0">Transport RS:&nbsp;<%=df.format(h.getTransport()) %></p>
                        <p class="mb-0">Customer :&nbsp;<%= h.getHoldInvoice().getAccount().getName()%></p>
                        <p class="mb-0">Invoiced Date :&nbsp;<%= h.getHoldInvoice().getDate()%></p>
                        <p class="mb-0">Contact Number :&nbsp;<%= h.getHoldInvoice().getAccount().getContact() %></p>
                        <p class="mb-0">Address :&nbsp;<%= h.getHoldInvoice().getAccount().getAddress()%></p>
                    </td>
                    <td  style="border: #2d3436 solid 1px !important;">
                        <table class="table table-sm table-bordered">
                            <thead>
                                <tr>
                                    <th  style="border: #2d3436 solid 1px !important;">Item name</th>
                                    <th  style="border: #2d3436 solid 1px !important;">Quantity</th>



                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Set<DoHoldItem> dhi = h.getDoHoldItems();
                                    for (DoHoldItem PII : dhi) {

                                %>
                                <tr>
                                    <td  style="border: #2d3436 solid 1px !important;"><%=PII.getHoldInvoiceItem().getItems().getName()%></td>
                                    <td  style="border: #2d3436 solid 1px !important;"><%=PII.getQty() + " " + PII.getHoldInvoiceItem().getNowType()%></td>


                                </tr>
                                <%
                                    }

                                %>
                            </tbody>
                        </table> 

                    </td>

                </tr>


                <%}%>
            </table>        
            <div class="row">
                <div class="col-sm-12 mt-5">
                    <h5>ඉහත සදහන්  භාණ්ඩ නියමිත ගුණාත්වයෙන්  සහ ඇනවුම්  කල ප්‍රමාණයෙන්  ගෙන්  ලබා ගතිමි.</h5>
                </div>
                <div class="col-sm-12">
                    <div class="row mt-5">
                        <div class="col">
                            --------------------------<br>
                            <h6>Driver's Signature</h6>

                        </div>
                        <div class="col">
                            --------------------------<br>
                            <h6>Officer's Signature</h6>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- main do document -->
        <!-- goods received -->
        <p style="page-break-before: always;">
            <%
                Set<DoItem> diii = p.getDoItems();
                for (DoItem h : diii) {


            %>
        <img src="logoimage/<%=br.getGoodrnHeader() %>" style="width: 100% !important;" />  
        <div class="container p-5">
            <div class="row ">



                <div class="col-sm-4">
                    <h6>Email: <%=Emial%></h6>
                    <h6>TP: <%=Contact%> Fax: <%=Fax%></h6>
                </div>
                <div class="col-sm-4">
                    <h6>Customer Name: <%=h.getHoldInvoice().getAccount().getName() %></h6>
                    <h6>Invoice Date: <%=h.getHoldInvoice().getDate() %></h6>
                
                </div>
                <div class="col-sm-4">
                    <h6>Delivery Number : <%="#" + p.getIddo()%></h6>
                    <h6>Lorry Number : ---------------------</h6>

                </div>
                

            </div>
        
        <div class="row mt-2">

            <table class="table table-sm table-bordered">
                <thead>
                    <tr>
                        <th  style="border: #2d3436 solid 1px !important;">Item name</th>
                        <th  style="border: #2d3436 solid 1px !important;">Quantity</th>

                    </tr>
                </thead>
                <tbody>
                    <%
                        Set<DoHoldItem> dhi = h.getDoHoldItems();
                        for (DoHoldItem PII : dhi) {

                    %>
                    <tr>
                        <td  style="border: #2d3436 solid 1px !important;"><%=PII.getHoldInvoiceItem().getItems().getName()%></td>
                        <td  style="border: #2d3436 solid 1px !important;"><%=PII.getQty() + " " + PII.getHoldInvoiceItem().getNowType()%></td>


                    </tr>
                    <%
                        }

                    %>
                </tbody>
            </table>

        </div>

        <div class="row ">
                <div class="col-sm-12 mt-5">
                    <h5>ඉහත සදහන්  භාණ්ඩ නියමිත ගුණාත්වයෙන්  සහ ඇනවුම්  කල ප්‍රමාණයෙන්  ගෙන්  ලබා ගතිමි.</h5>
                </div>
                <div class="col-sm-12">
                    <div class="row mt-5">
                        <div class="col">
                            --------------------------<br>
                            <h6>Date</h6>

                        </div>
                        <div class="col">
                            --------------------------<br>
                            <h6>Customer's Signature</h6>
                        </div>

                    </div>
                </div>
            </div>
         </div>
        <p style="page-break-before: always">
        <%                    }
        %>    
       
        <!-- goods received -->
       
        <!-- print invoice -->

            <%
                Set<DoItem> di = p.getDoItems();
                for (DoItem h : di) {
                    HoldInvoice pi = h.getHoldInvoice();
                    if (pi != null) {

            %>
            <img src="logoimage/<%=br.getInvoiceHeader() %>" style="width: 100% !important;" />  
            <div class="container p-5"> 
            <div class="row" >

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
                            <td style="border: #2d3436 solid 1px !important;"><h6 class="mb-0"><%= pi.getIdholdInvoice()%></h6></td>
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
            <div class="row mt-2">

                <table class="table table-sm table-bordered">
                    <thead>
                        <tr>
                            <th style="border: #2d3436 solid 1px !important;">ITEM ID</th>
                            <th style="border: #2d3436 solid 1px !important;">DESCRIPTION</th>
                            <th style="border: #2d3436 solid 1px !important;">QTY</th>
                            <th style="border: #2d3436 solid 1px !important;">MRP</th>
                            <th style="border: #2d3436 solid 1px !important;">DISCOUNT RATE</th>
                            <th style="border: #2d3436 solid 1px !important;">SUB TOTAL</th>

                            <!-- <th>Location</th-->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            
                            Set<HoldInvoiceItem> pii = pi.getHoldInvoiceItems();
                            for (HoldInvoiceItem PII : pii) {
                              
                        %>
                        <tr>
                            <td style="border: #2d3436 solid 1px !important;"><%=PII.getItems().getItemId()%></td>
                            <td style="border: #2d3436 solid 1px !important;"><%=PII.getItems().getName()%></td>
                            <td style="border: #2d3436 solid 1px !important;"><%= PII.getQtt() + " "%> </td>
                            <td style="border: #2d3436 solid 1px !important;"><%=df.format(PII.getUnitPrice()) + "  "%></td>
                            <td style="border: #2d3436 solid 1px !important;"><%=df.format(PII.getDescount()) + "  "%></td>
                            <td style="border: #2d3436 solid 1px !important;"><%=df.format(PII.getNetTotal()) + "  "%></td>
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
                        <%=df.format(pi.getNetTotal()) %> <br>
                        <%=(df.format(pi.getNetTotal() - pi.getTotal() ))%> <br>
                        <%=df.format(pi.getTotal()) %><br>
                        -----------------------<br>
                        <%=df.format(pi.getPaible()) %><br>
                        -----------------------<br>
                        <%=df.format(pi.getTransport()) %><br>
                    </strong>
                </div>

            </div>
        </div>        
       
        <img src="logoimage/<%=br.getFooter() %>" style="width: 100% !important;position:fixed !important;bottom: 0px !important;" />
        <p style="page-break-before: always;">
        
        <%
                }
            }
        %>
        <!-- print invoice -->
        
        




        <% } } } %>



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
