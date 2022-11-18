<%@page import="java.text.DecimalFormat"%>
<%@page import="dataclass.helper"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="resources.OtherTrans"%>
<%@page import="resources.PurchusInvoice"%>
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
            DecimalFormat df = new DecimalFormat("##########0.00");
        %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="icon" href="https://getbootstrap.com/favicon.ico">
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

            helper help = new helper();
            String Date = help.getDate();

            if (request.getParameter("d") != null && !request.getParameter("d").equals("") && !request.getParameter("d").equals("0")) {
                Date = request.getParameter("d");
            }
            double cheque_in = 0;
            double cheque_out = 0;

        %>


        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">Virtual Bank Balance (CHEQUE)</li>

                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="virtualchequebalance.jsp" >
                            <div class="row">

                                <div class="col-md-8">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:210px;" id="inputGroup-sizing-default">END DATE (CHEQUE DATE)</span>
                                        </div>
                                        <input type="date" class="form-control" name="d" id="d" value="<%=Date%>">
                                    </div>

                                </div>
                                <div class="col-md-2">

                                    <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                        <button type="submit" class="btn btn-success" id="save">FIND</button>

                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>


            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-bordered table-active table-sm" id="tbl1">
                            <thead>
                                <tr>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">CHEQUE DATE</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">ADD DATE</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">CHEQUE NUMBER</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">IN</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">OUT</td>

                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    Criteria cr_in = ses.createCriteria(InvoiceRecipt.class);
                                    cr_in.add(Restrictions.between("cheDate", "1900-01-01", Date));
                                    List<InvoiceRecipt> in_list = cr_in.list();
                                    for (InvoiceRecipt in : in_list) {
                                        if (in.getPaymentType().getIdpaymentType() == 3 && in.getCheStatus() == 1 || in.getCheStatus() == 2) {
                                            cheque_in = cheque_in + in.getCheAmount();
                                %>
                                <tr>
                                    <td><%=in.getCheDate()%></td>
                                    <td><%=in.getCheRegDate()%></td>
                                    <td><%=in.getCheNumber()%></td>
                                    <td><%=df.format(in.getCheAmount())%></td>
                                    <td></td>
                                </tr>

                                <%
                                        }
                                    }

                                    Criteria cr_ou = ses.createCriteria(PurchusInvoiceRecipt.class);
                                    cr_ou.add(Restrictions.between("cheDate", "1900-01-01", Date));
                                    List<PurchusInvoiceRecipt> ou_list = cr_ou.list();
                                    for (PurchusInvoiceRecipt in : ou_list) {
                                        if (in.getPaymentType().getIdpaymentType() == 3 && in.getCheStatus() == 1 || in.getCheStatus() == 2 || in.getCheStatus() == 3) {
                                            cheque_out = cheque_out + in.getCheAmount();
                                %>
                                <tr>
                                    <td><%=in.getCheDate()%></td>
                                    <td><%=in.getCheRegDate()%></td>
                                    <td><%=in.getCheNumber()%></td>
                                    <td></td>
                                    <td><%=df.format(in.getCheAmount())%></td>
                                </tr>

                                <%
                                        }
                                    }
                                %>
                                <tr style="background-color: #1e272e !important; color: white !important; ">
                                    <td></td>
                                    <td></td>
                                    <td>TOTAL</td>
                                    <td><%=df.format(cheque_in)%></td>
                                    <td><%=df.format(cheque_out)%></td>
                                </tr>
                                <tr style="background-color: #ff3f34 !important; color: white !important; ">
                                    <td></td>
                                    <td></td>
                                    <td>BALANCE</td>
                                    <td></td>
                                    <td><%=df.format(cheque_in - cheque_out)%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>




        </main>



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

        <script type="text/javascript">
            $(window).load(function(){
                $('.loader').fadeOut();
            });
            $(document).ready(function () {
                var table = $('#tbl1').DataTable();
            });






        </script>


    </body>
</html>