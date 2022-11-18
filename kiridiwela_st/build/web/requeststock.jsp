<%@page import="resources.Branch"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Items"%>
<%@page import="resources.Settings"%>
<%@page import="resources.User"%>
<%@page import="java.util.List"%>
<%@page import="resources.Account"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%
            User admin = null;
            int branch_id= 0;
            if (request.getSession().getAttribute("administrator") == null) {
                response.sendRedirect("login.jsp");
            }else{
               admin  = (User) request.getSession().getAttribute("administrator");
               branch_id = admin.getBranch().getIdbranch();
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
            Session Hses = connection.getConnection.getSessionFactory().openSession();
        %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="icon" href="src/image/favicon.ico">
        <title><%=Name%></title>

        <!-- Bootstrap core CSS -->
        <link href="src/boostrap/bootstrap-4.1.3/css/bootstrap.min.css" rel="stylesheet">



        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
        <!-- Data Tables CDN -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
        <link href="src/css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/css/select2.min.css" rel="stylesheet" />  


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
            .select2-selection__rendered {
                line-height: 35px !important;
                border-radius: 0px !important;
            }

            .select2-selection {
                height: 35px !important;
                border-radius: 0px !important;
            }
        </style>
    </head>

    <body>

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->



        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-arrow-left"></span>&nbsp;<a href="stocktransfer.jsp">Back</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Request Stocks</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-sm-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <div class="row">

                            <div class="col-sm-6">
                                <div class="mr-2">
                                    <div class="input-group ">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:135px;height: 35px;" id="inputGroup-sizing-default">REQUESTED ITEM</span>
                                        </div>
                                        <select class="form-control sp2" style="height: 35px;" id="item" name="item">
                                            <option value="0">PLEASE SELECT ITEM</option>
                                            <%
                                                Criteria cust = Hses.createCriteria(Items.class);
                                                cust.add(Restrictions.eq("status", 1));
                                                List<Items> itemList = cust.list();
                                                for (Items CL : itemList) {
                                            %>
                                            <option value="<%=CL.getItemId()%>"><%=CL.getName()%></option>

                                            <%
                                                }
                                            %>

                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="mr-2">
                                    <div class="input-group ">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:80px;height: 35px;" id="inputGroup-sizing-default">BRANCH</span>
                                        </div>
                                        <select class="form-control" style="width:200px ;height: 35px;" id="branch" name="branch">
                                            <option value="0">SELECT BRANCH</option>
                                            <%
                                                Criteria branch = Hses.createCriteria(Branch.class);
                                                branch.add(Restrictions.eq("status", 1));
                                                List<Branch> brList = branch.list();
                                                for (Branch CL : brList) {
                                                    if(branch_id > 0  && branch_id != CL.getIdbranch()){
                                            %>
                                            <option value="<%=CL.getIdbranch()%>"><%=CL.getName()%></option>

                                            <%
                                                }
                                                }
                                            %>

                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <div class="mr-2">
                                    <div class="input-group ">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:50px;height: 35px;" id="inputGroup-sizing-default">QTY</span>
                                        </div>
                                        <input type="number" class="form-control" style="height: 35px;" id="amount" name="amount">

                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <div class="mt-2">
                                    <button class="btn btn-info" id="rq">REQUEST</button>
                                </div>
                            </div>

                        </div>

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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>
        <script>
            $(document).ready(function () {
                $('.sp2').select2();

                $('#item').change(function (e) {
                    $('#branch').focus();
                });
                $('#branch').change(function (e) {
                    $('#amount').focus();
                });
                $('#rq').click(function (e) {
                    
                    swal({
                        title: "Are you sure?",
                        text: "do you want to request stocks from other branch.",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    }).then((willDelete) => {
                        if (willDelete) {

                            $.ajax({
                                url: 'requestStocksServlet',
                                data: {
                                    br:$('#branch').find(":selected").val(),
                                    it: $('#item').find(":selected").val(),
                                    am: $('#amount').val()


                                },
                                type: 'post',
                                cache: false,
                                success: function (data) {
                                    if (data === "1") {

                                        swal({
                                            title: "Good job!",
                                            text: "your request is send to selected branch.",
                                            icon: "success",
                                            button: "OK"
                                        }).then((value) => {

                                            location.reload();
                                        });


                                    } else if (data === "0") {
                                        swal({
                                            title: "Empty Data !",
                                            text: "Please enter correct data and re try.",
                                            icon: "error",
                                            button: "OK"
                                        });

                                    } else if (data === "3") {
                                        swal({
                                            title: "Wrong Amount !",
                                            text: "Please Enter valid item amount.",
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
                            });

                        } else {
                            swal({
                                title: "Cancelled !",
                                text: "you cancelled  process.",
                                icon: "error",
                                button: "OK"
                            });
                        }
                    })
                });
            });
        </script>



    </body>
</html>