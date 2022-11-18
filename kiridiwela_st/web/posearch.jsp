<%@page import="dataclass.userHolder"%>
<%@page import="dataclass.helper"%>
<%@page import="resources.PurchaseInvoiceOrder"%>
<%@page import="resources.SaleInvoiceItem"%>
<%@page import="resources.Items"%>
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
            userHolder USER = null;
    if (request.getSession().getAttribute("administrator") == null) {
        response.sendRedirect("login.jsp");
    } else {
        USER = (userHolder) request.getSession().getAttribute("userHolder");
    }
    
    if(USER != null){
        try{
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
    </head>

    <body>

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->
        <%
            Session ses = connection.getConnection.getSessionFactory().openSession();
            helper help = new helper();
            String Date = help.getDate();
            String Date2 = help.getDate();

            String BranchN = "ALL";
            String AccountN = "ALL";

            int branch = 0;
            int account = 0;

            double total_sales = 0.0;
            double total_cost = 0.0;
            double total_income = 0.0;

            double total_cash_sales = 0.0;
            double total_credit_sales = 0.0;
            double total_cheque_sales = 0.0;
            if (request.getParameter("a") != null && !request.getParameter("a").equals("")) {
                account = Integer.parseInt(request.getParameter("a"));
                if (!request.getParameter("a").equals("0")) {
                    Account A = (Account) ses.load(Account.class, account);
                    AccountN = A.getName();
                }
            }
            if (request.getParameter("b") != null && !request.getParameter("b").equals("")) {
                branch = Integer.parseInt(request.getParameter("b"));
                if (!request.getParameter("b").equals("0")) {
                    Branch B = (Branch) ses.load(Branch.class, branch);
                    BranchN = B.getName();
                }
            }
            if (request.getParameter("q") != null && !request.getParameter("q").equals("")
                    && request.getParameter("q2") != null && !request.getParameter("q2").equals("")) {
                Date = request.getParameter("q");
                Date2 = request.getParameter("q2");

            }

        %>


        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                            <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Purchase Order List</li>
                        </ol>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="posearch.jsp" >
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
                                <div class="col-md-8">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">SUPPLIER</span>
                                        </div>
                                        <select class="form-control" name="a" id="a"  >
                                            <option value="0">ALL</option>
                                            <%                                                Criteria cra = ses.createCriteria(Account.class);
                                                cra.add(Restrictions.eq("status", 1));
                                                cra.add(Restrictions.eq("customer", 1));
                                                List<Account> bra = cra.list();
                                                for (Account BR : bra) {

                                            %>
                                            <option value="<%= BR.getIdaccount()%>"><%= BR.getName()%></option>
                                            <%
                                                }

                                            %>

                                        </select>
                                    </div>


                                </div>
                                <div class="col-md-4">

                                    <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                        <button type="submit" class="btn btn-success" id="save"><span class="fa fa-save mr-2"></span>FIND</button>

                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <%                if (true) {
            %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-6">
                                <table class="table table-bordered table-sm">

                                    <tr>
                                        <td>Start Date :</td>
                                        <td id="D"><%=Date%></td>
                                    </tr>
                                    <tr>
                                        <td>End Date :</td>
                                        <td id="E"><%=Date2%></td>
                                    </tr>
                                    <tr>
                                        <td>Customer Name :</td>
                                        <td id="F"><%=AccountN%></td>
                                    </tr>
                                    <tr>
                                        <td>Branch :</td>
                                        <td id="G"><%=BranchN%></td>
                                    </tr>


                                </table>





                            </div>
                            <div class="col-md-6 text-justify">
                                <h6>Select rows with 'Mouse Click' and click print selected button for print selected purchase order in one report.</h6>
                                <button id="bbn" class="btn btn-sm btn-info" >PRINT SELECTED</button>


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
                                <tr style="background-color: #10ac84 !important; color: white !important; ">
                                    <td>PO NUMBER</td>
                                    <td>SUPPLIER</td>
                                    <td>REMARKS</td>
                                    <td>STATUS</td>
                                    <td>BRANCH</td>
                                    <td>DATE</td>
                                    <td></td>


                                </tr>
                            </thead>
                            <tbody id="tbl1_b">
                                <%
                                    if (true) {
                                        Criteria cr = ses.createCriteria(PurchaseInvoiceOrder.class);
                                        if (Date != "ALL" && Date2 != "ALL") {
                                            cr.add(Restrictions.between("date", Date, Date2));
                                        }
                                        if (account > 0) {
                                            cr.createAlias("account", "A");
                                            cr.add(Restrictions.eq("A.idaccount", account));

                                        }
                                        if (branch > 0) {
                                            cr.createAlias("branch", "C");
                                            cr.add(Restrictions.eq("C.idbranch", branch));

                                        }
                                        cr.add(Restrictions.eq("status", 1));
                                        List<PurchaseInvoiceOrder> IR = cr.list();

                                        for (PurchaseInvoiceOrder r : IR) {


                                %>
                                <tr>
                                    <td><%=r.getIdpurchaseInvoiceOrder()%></td>
                                    <td><%= r.getAccount().getName()%></td>
                                    <td><%= r.getRemarks()%></td>
                                    <td><%= r.getStatus()%></td>
                                    <td><%= r.getBranch().getName()%></td>
                                    <td><%= r.getDate()%></td>

                                    <td>
                                        <% if(USER.getInvoicing().contains("G")){ %>
                                        <button class="btn btn-warning btn-sm delete_dev" value="<%=r.getIdpurchaseInvoiceOrder() %>" >DELETE</button>
                                        <% } %>
                                        <a type="submit" target="_blank" class="btn btn-success btn-sm" href="poprint.jsp?pid=<%=r.getIdpurchaseInvoiceOrder()%>" >PRINT</a>
                                    </td>

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
            $('#b').val(<%=branch%>);
            $('#a').val(<%=account%>);
            var sDate = $('#D').html();
            var eDate = $('#E').html();
            var eBranch = $('#G').html();
            var eAccount = $('#F').html();

            $(document).ready(function () {
                $('#tbl1').DataTable();
            });
            $(".delete_dev").click(function () {


                var idd = $(this).closest('tr').find('.delete_dev').val();
                swal({
                    title: "Are you sure?",
                    text: "do you want to delete this purchase order ? ",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then((willDelete) => {
                    if (willDelete) {

                        $.ajax({
                            url: 'deletePOServlet',
                            data: {
                                id: idd
                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                                if (data === "1") {

                                    swal({
                                        title: "Good job!",
                                        text: "you Deleted Purchase Order !",
                                        icon: "success",
                                        button: "OK"
                                    }).then((value) => {

                                        location.reload();
                                    });


                                } else if (data === "0") {
                                    swal({
                                        title: "Empty Field Data !",
                                        text: "Can't let any field id empty.",
                                        icon: "error",
                                        button: "OK"
                                    });

                                } else if (data === "3") {
                                    swal({
                                        title: "Access denied !",
                                        text: "You can't do this action without permision.",
                                        icon: "error",
                                        button: "OK"
                                    });

                                }
                            },
                            error: function () {
                                swal({
                                    title: "Something Went Wrong !",
                                    text: "something wrong  please retry.",
                                    icon: "error",
                                    button: "OK"
                                });
                            }
                        }
                        );

                    } else {
                        swal({
                            title: "Cancelled !",
                            text: "you cancelled " + name + " process.",
                            icon: "error",
                            button: "OK"
                        });
                    }
                });

            });

            $(document).ready(function () {
                var table = $('#tbl1').DataTable();

                $('#tbl1 tbody').on('click', 'tr', function () {
                    $(this).toggleClass('selected');
                });

                $('#bbn').click(function () {
                    var dataArr = [];
                    var rows = $('.selected');
                    var rowData = table.rows(rows).data();
                    $.each($(rowData), function (key, value) {
                        dataArr.push(value.toString().split(",")[0]); //"name" being the value of your first column.
                    });

                    var dataString = 'p=' + dataArr;


                    $.ajax({
                        url: 'printSelectedPoServlet',
                        dataType: "json",
                        data: dataString,
                        cache: false,
                        success: function (player) {

                            //location.replace("print_po_selected.jsp");
                            location.reload();
                            popupWindow = window.open('print_po_selected.jsp', 'popUpWindow', 'height=' + screen.availHeight + ',width=' + screen.availWidth + ',left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes');



                        }
                    });

                });
            });



        </script>


    </body>
    <%  }catch(Exception e){
            
        }} %>
</html>