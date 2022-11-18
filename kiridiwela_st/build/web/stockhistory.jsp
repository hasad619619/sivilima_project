<%@page import="resources.SalesReturnItems"%>
<%@page import="resources.PurchusInvoiceItem"%>
<%@page import="resources.HoldInvoiceItem"%>
<%@page import="resources.SaleInvoiceItem"%>
<%@page import="resources.Branch"%>
<%@page import="resources.Items"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dataclass.helper"%>
<%@page import="resources.QuotationInvoice"%>
<%@page import="resources.SaleInvoice"%>
<%@page import="resources.PurchusInvoiceRecipt"%>
<%@page import="resources.InvoiceRecipt"%>
<%@page import="java.util.Set"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Settings"%>
<%@page import="java.util.List"%>
<%@page import="resources.Account"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%
            if (request.getSession().getAttribute("administrator") == null) {
                response.sendRedirect("login.jsp");
            }


        %>
        <%            DecimalFormat df = new DecimalFormat("##########0.00");
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
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css">
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
        <style>
            @import url(https://fonts.googleapis.com/css?family=Droid+Sans);
            .loader {
                position: fixed;
                left: 0px;
                top: 0px;
                width: 100%;
                height: 100%;
                z-index: 9999;
                background: url('src/image/load.gif') 50% 50% no-repeat rgb(255,255,255);
            }
        </style>
    </head>

    <body>
        <div class="loader"></div>
        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->
        <%
            Session ses = connection.getConnection.getSessionFactory().openSession();
            String Date = "";
            String Date2 = "";

            int branch_id = 0;
            String branch_name = "ALL";
            int item_id = 0;

            Items ITEM = null;
            Branch BRANCH = null;

            if (request.getParameter("a") != null && !request.getParameter("a").equals("") || request.getParameter("b") != null && !request.getParameter("b").equals("")) {
                branch_id = Integer.parseInt(request.getParameter("b"));
                item_id = Integer.parseInt(request.getParameter("a"));
                ITEM = (Items) ses.load(Items.class, item_id);

                if (branch_id > 0) {
                    BRANCH = (Branch) ses.load(Branch.class, branch_id);
                    branch_name = BRANCH.getName();
                }
            } else {
                response.sendRedirect("stock.jsp");
            }

            if (request.getParameter("q") != null && !request.getParameter("q").equals("") || request.getParameter("q2") != null && !request.getParameter("q2").equals("")) {
                Date = request.getParameter("q");
                Date2 = request.getParameter("q2");

            } else {

                helper h = new helper();
                Date = h.getDate();
                Date2 = h.getDate();
            }
            if (ITEM != null) {
        %>


        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-arrow-left"></span>&nbsp;<a href="index.jsp">Back</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">Stock History</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="quotationlist.jsp" >
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">ST: DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q" id="q" value="<%=Date%>">
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">END DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q2" id="q2" value="<%=Date2%>">
                                    </div>


                                </div>
                                <div class="col-md-4">

                                    <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                        <button type="submit" class="btn btn-success" id="save">FIND</button>
                                        <a  class="btn btn-info ml-1" href="quotationlist.jsp?all=ok" >GET ALL</a>

                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <%
                if (Date != "" && Date2 != "") {
            %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-12">
                                <table class="table table-bordered table-sm">
                                    <tr >
                                        <td style="background-color:#6ab04c !important; color: white !important; "><strong>ITEM NAME</strong></td>
                                        <td style="background-color:#34495e !important; color: white !important; "><strong><%=ITEM.getName().toUpperCase()%></strong></td>
                                        <td style="background-color:#6ab04c !important; color: white !important; "><strong>CURRENT STOCK</strong></td>
                                        <td style="background-color:#34495e !important; color: white !important; "><strong>5 PEACE</strong></td>
                                        <td style="background-color:#6ab04c !important; color: white !important; "><strong>SELECTED BRANCH</strong></td>
                                        <td style="background-color:#34495e !important; color: white !important; "><strong><%=branch_name.toUpperCase()%></strong></td>
                                    </tr>





                                </table>





                            </div>
                            <div class="col-md-6">



                            </div>
                        </div>


                    </div>
                </div>
            </div>


            <%
                }
            %>
            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-light" id="tbl1">
                            <thead>
                                <tr>
                                    <td style="background-color: #4b6584 !important; color: white !important; ">#</td>
                                    <td style="background-color: #4b6584 !important; color: white !important; ">DATE | TIME</td>
                                    <td style="background-color: #4b6584 !important; color: white !important; ">DETAILS</td>
                                    <td style="background-color: #4b6584 !important; color: white !important; ">QTY</td>



                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (Date != null && Date2 != null) {
                                        
                                        Set<SaleInvoiceItem> SI = ITEM.getSaleInvoiceItems();
                                        for (SaleInvoiceItem DE : SI) {

                                %>
                                <tr style="background-color: #20bf6b !important; color: white !important; ">
                                    <td><%=DE.getSaleInvoice().getIdsaleInvoice() %></td>
                                    <td><%=DE.getSaleInvoice().getDate()+" "+DE.getSaleInvoice().getTime()%></td>
                                    <td><%="SALES"%></td>
                                    <td><%=DE.getQtt() %></td>
                                    
                                </tr>
                                <%
                                        }
                                    Set<HoldInvoiceItem> HI = ITEM.getHoldInvoiceItems();
                                        for (HoldInvoiceItem DE : HI) {

                                %>
                                <tr style="background-color: #f7b731 !important; color: white !important; ">
                                    <td><%=DE.getHoldInvoice().getIdholdInvoice()%></td>
                                    <td><%=DE.getHoldInvoice().getDate()+" "+DE.getHoldInvoice().getTime()%></td>
                                    <td><%="HOLD INVOICE"%></td>
                                    <td><%="HOLD - "+DE.getQtt()+" DELIVERED - "+DE.getQtySended() %></td>
                                    
                                </tr>
                                <%
                                        }
                                    Set<PurchusInvoiceItem> PI = ITEM.getPurchusInvoiceItems();
                                        for (PurchusInvoiceItem DE : PI) {

                                %>
                                <tr style="background-color: #fa8231 !important; color: white !important; ">
                                    <td><%=DE.getPurchusInvoice().getIdpurchusInvoice()%></td>
                                    <td><%=DE.getPurchusInvoice().getDate()+" "+DE.getPurchusInvoice().getTime()%></td>
                                    <td><%="PURCHASE"%></td>
                                    <td><%=DE.getQtt() %></td>
                                    
                                </tr>
                                <%
                                        }
                                    Set<SalesReturnItems> SR = ITEM.getSalesReturnItemses();
                                        for (SalesReturnItems DE : SR) {

                                %>
                                <tr style="background-color: #fc5c65 !important; color: white !important; ">
                                    <td><%=DE.getSalesReturn().getIdsalesReturn()%></td>
                                    <td><%=DE.getSalesReturn().getDate()+" "+DE.getSalesReturn().getTime()%></td>
                                    <td><%="SALES RETURN"%></td>
                                    <td><%=DE.getQty() %></td>
                                    
                                </tr>
                                <%
                                        }
                                    }

                                %>


                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </main>
        <% }%>


        <!-- include header-->
        <jsp:include page="includes/footer.jsp" />
        <!-- include header-->





        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="src/jquery/jquery-1.11.1.min.js" ></script>
        <script src="src/boostrap/bootstrap-4.1.3/js/bootstrap.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.colVis.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
            $(window).load(function () {
                $('.loader').fadeOut();
            });
        </script>
        <script type="text/javascript">


            $(document).ready(function () {
                $('#tbl1').DataTable();
            });




        </script>


    </body>
</html>