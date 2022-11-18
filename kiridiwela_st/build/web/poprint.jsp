<%-- 
    Document   : purchaseprint
    Created on : Oct 31, 2018, 6:53:37 PM
    Author     : Mayura Lakshan
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.PoOrderItems"%>
<%@page import="resources.PurchaseInvoiceOrder"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="resources.Settings"%>
<%@page import="java.util.Set"%>
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
            DecimalFormat df = new DecimalFormat("##########0.00"); 
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
    <%
                int n = 0;
                if (request.getParameter("n") != null && !request.getParameter("n").equals("")) {
                    n = Integer.parseInt(request.getParameter("n").toString());
                }
                if (request.getParameter("pid") != null && !request.getParameter("pid").equals("")) {

                    Session ses = connection.getConnection.getSessionFactory().openSession();
                    PurchaseInvoiceOrder p = (PurchaseInvoiceOrder) ses.load(PurchaseInvoiceOrder.class, Integer.parseInt(request.getParameter("pid").toString()));
                    double tot=0.0;
                    if (p != null) {

            %>
    <body>
        <img src="logoimage/<%=p.getBranch().getPo() %>" style="width: 100% !important;" />
        <div class="container">
            <div class="row p-5" >
                <div class="col-sm-12">
                   <table class="table table-sm table-bordered">
                            <tr>
                                <td><p class="mb-0">DATE :</p></td>
                                <td>&nbsp;<%= p.getDate()%></td>
                                <td><p class="mb-0">TYPE :</p></td>
                                <td>&nbsp;<%= "PURCHASE ORDER"%></td>
                            </tr>
                            <tr>
                                <td><p class="mb-0">SUPPLIER :</p></td>
                                <td>&nbsp;<%= p.getAccount().getName().toUpperCase() %></td>
                                <td><p class="mb-0">USER :</p></td>
                                <td>&nbsp;<%= p.getUser().getName().toUpperCase() %></td>
                            </tr>
                            <tr>
                                <td><p class="mb-0">PO ID:</p></td>
                                <td>&nbsp;<%= p.getIdpurchaseInvoiceOrder()%></td>
                                <td><p class="mb-0">BRANCH :</p></td>
                                <td>&nbsp;<%= p.getBranch().getName().toUpperCase() %></td>
                            </tr>

                        </table>

                    
                </div>
                <div class="col-md-12">
                    <table class="table table-sm table-bordered">
                        <tr>
                            <td style="background-color:#2c3e50 !important; color: white !important; ">#</td>
                            <td style="background-color:#2c3e50 !important; color: white !important; ">ITEM</td>
                            <td style="background-color:#2c3e50 !important; color: white !important; ">ORDERED QTY</td>
                            <td style="background-color:#2c3e50 !important; color: white !important; ">ESTIMATED COST</td>
                            <td style="background-color:#2c3e50 !important; color: white !important; ">TOTAL</td>
                        </tr>
                        <%
                            Set<PoOrderItems> poo=p.getPoOrderItemses();
                            int i = 0;
                            for(PoOrderItems po:poo){
                                tot=tot+po.getTotal();
                                i++;
                            %>
                            <tr>
                            <td><%=i %></td>
                            <td><%=po.getItems().getName().toUpperCase() %></td>
                            <td><%=po.getQty()+" "+po.getItems().getType().getName().toUpperCase().toUpperCase() %></td>
                            <td><%=df.format(po.getCost() ) %></td>
                            <td><%=df.format(po.getTotal()) %></td>
                            </tr>
                            
                            <% } %>
                            


                    </table>
                </div>
                            <div class="col-md-8">
                                
                            </div>
                            <div class="col-md-4">
                                ---------------------------------------
                                <h6>ESTIMATED NET TOTAL : RS. <%=df.format(tot) %>  </h6>
                                ---------------------------------------
                            </div>
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        ------------------------
                                            Author
                                    </div>
                                    <div class="col-md-3">
                                         ------------------------
                                            Coordinator
                                    </div>
                                    <div class="col-md-6">
                                        
                                    </div>
                                </div>
            </div>




            
        </div>
        <img src="logoimage/<%=p.getBranch().getFooter() %>" style="width: 100% !important;position:fixed !important;bottom: 0px !important;" />
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
