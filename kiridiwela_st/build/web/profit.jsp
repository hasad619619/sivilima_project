<%@page import="resources.PayExpencess"%>
<%@page import="resources.PayEmployee"%>
<%@page import="resources.HoldInvoiceItem"%>
<%@page import="resources.SalesReturnItems"%>
<%@page import="resources.SaleInvoiceItem"%>
<%@page import="resources.PurchusInvoice"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.HoldInvoice"%>
<%@page import="resources.HoldRecipt"%>
<%@page import="resources.OtherTrans"%>
<%@page import="dataclass.helper"%>
<%@page import="resources.Branch"%>
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
            DecimalFormat df = new DecimalFormat("##########0.00");
            Session ses = connection.getConnection.getSessionFactory().openSession();
            helper help = new helper();
            String Date = help.getDate();
            String Date2 = help.getDate();
            String BranchN = "ALL";

            int branch = 0;

            if (request.getParameter("q") != null && !request.getParameter("q").equals("")
                    && request.getParameter("q2") != null && !request.getParameter("q2").equals("")
                    && request.getParameter("b") != null && !request.getParameter("b").equals("")) {
                Date = request.getParameter("q");
                Date2 = request.getParameter("q2");
                branch = Integer.parseInt(request.getParameter("b"));

                if (!request.getParameter("b").equals("0")) {
                    Branch B = (Branch) ses.load(Branch.class, branch);
                    BranchN = B.getName();
                }

            }

            Session s = connection.getConnection.getSessionFactory().openSession();
            double total_sales_profit = 0.0;
            double total_expence = 0.0;
            double total_employee_payment = 0.0;

            Criteria cin = s.createCriteria(SaleInvoice.class);
            cin.add(Restrictions.between("date", Date, Date2));
            if (branch > 0) {
                cin.createAlias("branch", "A");
                cin.add(Restrictions.eq("A.idbranch", branch));
            }
            List<SaleInvoice> l_cin = cin.list();
            for (SaleInvoice L : l_cin) {

                double net_profit = L.getTotalProfit();
                double prof = 0;

                Set<SaleInvoiceItem> sii = L.getSaleInvoiceItems();
                for (SaleInvoiceItem i : sii) {

                    double desc_rate = i.getDescountRate();
                    double return_qty = 0;

                    Set<SalesReturnItems> sri = i.getSalesReturnItemses();
                    for (SalesReturnItems l : sri) {
                        return_qty = return_qty + l.getQty();

                    }
                    prof = prof + (return_qty * desc_rate);
                }

                if (net_profit >= prof) {
                    total_sales_profit = total_sales_profit + (net_profit - prof);
                }

            }

            Criteria chr = s.createCriteria(HoldInvoice.class);
            chr.add(Restrictions.eq("status", 1));
            chr.add(Restrictions.between("date", Date, Date2));
            if (branch > 0) {
                chr.createAlias("branch", "A");
                chr.add(Restrictions.eq("A.idbranch", branch));
            }
            List<HoldInvoice> l_chr = chr.list();
            for (HoldInvoice L : l_chr) {
                double net_profit = L.getTotalProfit();
                double prof = 0;

                Set<HoldInvoiceItem> sii = L.getHoldInvoiceItems();
                for (HoldInvoiceItem i : sii) {

                    double desc_rate = i.getDescountRate();
                    double return_qty = 0;

                    prof = prof + ((i.getQtt() - i.getQtySended()) * (i.getProfit() / i.getQtt()));
                }

                if (net_profit >= prof) {
                    total_sales_profit = total_sales_profit + (net_profit - prof);
                }
            }

            Criteria che = s.createCriteria(PayEmployee.class);
            che.add(Restrictions.eq("status", 1));
            che.add(Restrictions.between("addedDate", Date, Date2));
            List<PayEmployee> l_che = che.list();

            if (branch > 0) {
                for (PayEmployee p : l_che) {
                    if (p.getEmployeeAccount().getIdemployeeAccount() == branch) {
                        total_employee_payment = total_employee_payment + p.getAmount();
                    }
                }
            } else {
                for (PayEmployee p : l_che) {
                    total_employee_payment = total_employee_payment + p.getAmount();
                }

            }

            Criteria chp = s.createCriteria(PayExpencess.class);
            chp.add(Restrictions.eq("status", 1));
            chp.add(Restrictions.between("addedDate", Date, Date2));
            List<PayExpencess> l_chp = chp.list();

            if (branch > 0) {
                for (PayExpencess p : l_chp) {
                    if (p.getExpencessAccount().getIdexpencessAccount() == branch) {
                        total_expence = total_expence + p.getAmount();
                    }
                }
            } else {
                for (PayExpencess p : l_chp) {
                    total_expence = total_expence + p.getAmount();
                }

            }


        %>


        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-gift"></span>&nbsp;&nbsp;&nbsp;PROFIT BALANCE</li>

                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="profit.jsp" >
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:80px;" id="inputGroup-sizing-default">ST DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q" id="q" value="<%=Date%>">
                                    </div>


                                </div>
                                <div class="col-md-3">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:80px;" id="inputGroup-sizing-default">EN DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q2" id="q2" value="<%=Date2%>">
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">BRANCH</span>
                                        </div>
                                        <select class="form-control" name="b" id="b"  >
                                            <option value="0">ALL</option>
                                            <%

                                                Criteria crb = ses.createCriteria(Branch.class);
                                                crb.add(Restrictions.eq("status", 1));
                                                List<Branch> br = crb.list();
                                                for (Branch BR : br) {

                                            %>
                                            <option value="<%= BR.getIdbranch()%>"><%= BR.getName()%></option>
                                            <%
                                                }

                                            %>

                                        </select>
                                    </div>


                                </div>

                                <div class="col-md-2">

                                    <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                        <button type="submit" class="btn btn-success" id="save"><span class="fa fa-search mr-2"></span>FIND</button>

                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <%                if (Date != "" && Date2 != "") {
            %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-12">
                                <table class="table table-bordered table-sm">
                                    <tr>
                                        <td style="background-color: #4b6584 !important; color: white !important; ">DETAILS</td>
                                        <td style="background-color: #4b6584 !important; color: white !important; ">AMOUNT</td>
                                        <td style="background-color: #4b6584 !important; color: white !important; "></td>

                                    </tr>

                                    <tr>
                                        <td>TOTAL SALES PROFIT</td>
                                        <td><%=df.format(total_sales_profit)%></td>
                                        <td></td>

                                    </tr> 
                                    <tr>
                                        <td>TOTAL EXPENSES</td>
                                        <td><%=df.format(total_expence)%></td>
                                        <td></td>

                                    </tr>    
                                    <tr>
                                        <td>TOTAL EMPLOYEE PAYMENT</td>
                                        <td><%=df.format(total_employee_payment)%></td>
                                        <td></td>

                                    </tr> 

                                    <tr >
                                        <td style="background-color: #27ae60 !important; color: white !important; ">BALANCE</td>
                                        <td style="background-color: #27ae60 !important; color: white !important; "><%=""%></td>
                                        <td style="background-color: #27ae60 !important; color: white !important; "><%=df.format(total_sales_profit - (total_expence + total_employee_payment))%></td>

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

            $(window).load(function () {
                $('.loader').fadeOut();
            });

            $('#b').val(<%=branch%>);

            var sDate = $('#SD').html();
            var eDate = $('#ED').html();
            var eBranch = $('#EB').html();
            var eAccount = $('#EA').html();
            var tIn = $('#A').html();
            var tOut = $('#B').html();
            var tBal = $('#C').html();




            $(document).ready(function () {
                $('#tbl1').DataTable({
                    dom: 'Blfrtip',
                    buttons: [
                        {
                            extend: 'copyHtml5',
                            exportOptions: {
                                columns: [0, 1, 2]
                            }
                        },
                        {
                            extend: 'excelHtml5',
                            exportOptions: {
                                columns: [0, 1, 2]
                            }
                        },
                        {
                            extend: 'pdfHtml5',
                            exportOptions: {
                                columns: [0, 1, 2]
                            }
                        },
                        {
                            extend: 'print',
                            exportOptions: {
                                columns: [0, 1, 2]
                            },
                            customize: function (win) {
                                $(win.document.body).append('<h5>-------------------------------------------</h5>'); //after the table
                                $(win.document.body).append('<h5>Start Date:' + sDate + '</h5>'); //after the table
                                $(win.document.body).append('<h5>End Date:' + eDate + '</h5>'); //after the table
                                $(win.document.body).append('<h5>Branch:' + eBranch + '</h5>'); //after the table
                                $(win.document.body).append('<h5>Account:' + eAccount + '</h5>'); //after the table
                                $(win.document.body).append('<h5>Cash In:' + tIn + '</h5>'); //after the table
                                $(win.document.body).append('<h5>Cash Out:' + tOut + '</h5>'); //after the table
                                $(win.document.body).append('<h5>Balance:' + tBal + '</h5>'); //after the table
                                $(win.document.body).append('<h5>-------------------------------------------</h5>'); //after the table

                            }
                        },
                        'colvis'




                    ]

                });
            });




        </script>


    </body>
</html>