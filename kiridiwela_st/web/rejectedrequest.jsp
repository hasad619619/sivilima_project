 <%@page import="dataclass.helper"%>
<%@page import="resources.User"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.StockTransfer"%>
<%@page import="resources.Settings"%>
<%@page import="resources.Branch"%>
<%@page import="resources.Category"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<<%@page import="org.hibernate.Session"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%
            User admin = null;
            int branch_id = 0;
            if (request.getSession().getAttribute("administrator") == null) {
                response.sendRedirect("login.jsp");
            } else {
                admin = (User) request.getSession().getAttribute("administrator");
                branch_id = admin.getBranch().getIdbranch();
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
            String ST = "";
            String EN = "";
            helper help = new helper();
            ST = help.getDate();
            EN = help.getDate();
            int stat = 0;

            if (request.getParameter("st") != null && !request.getParameter("st").equals("") && request.getParameter("en") != null && !request.getParameter("en").equals("")) {
                ST = request.getParameter("st");
                EN = request.getParameter("en");
            }

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

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->
        <div class="loader"></div>


        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-arrow-left"></span>&nbsp;<a href="stocktransfer.jsp">Back</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Rejected requests</li>
                    </ol>
                </nav>
            </div>

            <!-- Main content -->
            <div class="row mt-2">
                <div class="card col-sm-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <form action="rejectedrequest.jsp" method="get">    
                            <div class="row">
                                <div class="col-sm-5">
                                    <label for="st">Start Date :</label>
                                    <input type="date" name="st" id="st" class="form-control" value="<%=ST%>">

                                </div>
                                <div class="col-sm-4">
                                    <label for="st">End Date :</label>
                                    <input type="date" name="en" id="en" class="form-control" value="<%=EN%>">

                                </div>
                                
                                <div class="col-sm-3" style="padding-top: 30px;">
                                    <button  id="find" type="submit" class=" btn btn-primary m-t-20">FIND</button>
                                    <button  type="button" id="all" class=" btn btn-warning m-t-20">GET ALL</button>
                                </div>
                                
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" >

                    <div class="card-body">
                        <table id="table1" class="table">

                            <thead>
                                <tr style="background-color: #10ac84 !important; color: white !important; ">
                                    <th id="dev_id" class="dev_id" >Request ID</th>
                                    <th>Reject Date</th>
                                    <th>Reject User</th>
                                    <th>Item</th>
                                    <th>Amount</th>
                                    <th>Reject Branch</th>



                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(StockTransfer.class);
                                    cr.add(Restrictions.eq("status", 0));
                                    if (request.getParameter("a") == null || !request.getParameter("a").equals("1") && ST != null && !ST.equals("") && EN != null && !EN.equals("")) {
                                        cr.add(Restrictions.between("date", ST, EN));

                                    }
                                    List<StockTransfer> de = cr.list();

                                    if (de.size() > 0) {
                                        for (StockTransfer DE : de) {
                                            if (branch_id == DE.getBranchByFromBranch().getIdbranch()) {


                                %>
                                <tr>
                                    <td><%=DE.getIdstockTransfer()%></td>
                                    <td><%=DE.getSendDate() + " " + DE.getSendTime()%></td>
                                    <td><%=DE.getUserByAcceptedUser().getName() %></td>
                                    <td><%=DE.getItems().getName()%></td>
                                    <td><%=df.format(DE.getRequestQty())%></td>
                                    <td><%=DE.getBranchByToBranch().getName()%></td>

                                </tr>

                                <%
                                            }
                                        }

                                    }
                                    ses.close();


                                %>
                            </tbody>
                        </table>

                    </div>


                </div>

            </div><!-- /.container-fluid -->      
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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
            $(window).load(function () {
                $('.loader').fadeOut();
            });
        </script>

        <script type="text/javascript">
            $('#all').click(function (e) {
                location.replace('rejectedrequest.jsp?a=1');
            });
            $(document).ready(function () {
                $('#table1').dataTable({bFilter: false, bInfo: false, lengthChange: false});
            });

            $(".delete_dev").click(function () {


                var idd = $(this).closest('tr').find('.delete_dev').val();

                swal({
                    title: "Are you sure?",
                    text: "do you want cancell this request.",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then((willDelete) => {
                    if (willDelete) {

                        $.ajax({
                            url: 'cancellStockTransferServlet',
                            data: {
                                id: idd


                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                                if (data === "1") {

                                    swal({
                                        title: "Good job!",
                                        text: "you just cancell request.",
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
                                        title: "The Request Accepted !",
                                        text: "Your request accepted from other branch.",
                                        icon: "error",
                                        button: "OK"
                                    });

                                }
                            },
                            error: function () {
                                swal({
                                    title: "Something Went Wrong !",
                                    text: "something wrong in " + name + " data please retry.",
                                    icon: "error",
                                    button: "OK"
                                });
                            }
                        });

                    } else {
                        swal({
                            title: "Cancelled !",
                            text: "you cancelled the process.",
                            icon: "error",
                            button: "OK"
                        });
                    }
                });

            });



        </script>

    </body>
</html>