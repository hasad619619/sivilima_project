<%@page import="resources.CustomerBranch"%>
<%@page import="java.util.Set"%>
<%@page import="dataclass.userHolder"%>
<%@page import="resources.SaleInvoice"%>
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
            userHolder USER = null;
            if (request.getSession().getAttribute("administrator") == null) {
                response.sendRedirect("login.jsp");
            }else{
                USER =(userHolder) request.getSession().getAttribute("userHolder");
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
        <%if(USER != null){ %>
        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->


        <div class="loader"></div>
        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Create Account</li>
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-plus"></span>&nbsp;<a href="sales.jsp">Go to Invoice</a></li>
                    </ol>
                </nav>
            </div>
            <%if(USER.getAccount().contains("A") ){ %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Type</span>
                                    </div>
                                    <select class="form-control" name="type" id="type">
                                        <option value="1">CUSTOMER</option>
                                        <option value="2">SUPPLIER</option>
                                        <option value="5">BANK</option>
                                    </select>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">NAME</span>
                                    </div>
                                    <input type="text" class="form-control" name="name" id="name">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">EMAIL</span>
                                    </div>
                                    <input type="email" class="form-control" name="email" id="email">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">ADDRESS</span>
                                    </div>
                                    <input type="text" class="form-control" name="address" id="address">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">CONTACT</span>
                                    </div>
                                    <input type="number" class="form-control" name="contact" id="contact">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">REMARK</span>
                                    </div>
                                    <input type="text" class="form-control" name="remarks" id="remarks">
                                </div>
                                <div class="input-group mb-3 d-none" >
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">CREDIT LIMIT</span>
                                    </div>
                                    <input type="number" class="form-control" name="credit" id="credit">
                                </div>
                                <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                    <button type="button" class="btn  btn-sm" style="background-color:  #10ac84 ; color: white;" id="save"><span class="fa fa-save mr-2"></span>SAVE</button>
                                    <button type="button" class="btn  btn-sm" style="background-color:  #ee5253 ; color: white;" id="clear"><span class="fa fa-trash mr-2"></span>CLEAR</button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <%}  %>
            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-active table-sm" id="tbl1">
                            <thead>
                                <tr style="background-color: #10ac84 !important; color: white !important; ">
                                    <td>ACCOUNT ID</td>
                                    <td>NAME</td>
                                    <td>STATUS</td>
                                    <td>BRANCH</td>
                                    <td>OPTIONS</td>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(Account.class);
                                    cr.add(Restrictions.eq("status", 1));
                                    List<Account> ac = cr.list();

                                    for (Account AC : ac) {
                                        String BRANCH = ""; 
                                        Set<CustomerBranch> cb= AC.getCustomerBranches();
                                        for(CustomerBranch c:cb){
                                            BRANCH = BRANCH + c.getBranch().getName()+"\n";
                                        }
                                %>
                                <tr>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><%=AC.getIdaccount()%></td>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><%= AC.getName().toUpperCase() %></td>
                                    <%
                                        if (AC.getStatus() == 1) {
                                    %>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><span class="badge bg-info">active</span></td>
                                    <%
                                    } else {
                                    %>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><span class="badge bg-danger">deleted</span></td>

                                    <% }%>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><%=BRANCH.toUpperCase() %></td>
                                    <td style="border-bottom: #2d3436 solid 1px !important;">
                                        <input name="accid" id="accid" type="hidden" value="<%=AC.getIdaccount()%>">
                                        <input name="stat" type="hidden" value="<%=AC.getStatus()%>">

                                        <input name="h_name" type="hidden" value="<%= AC.getName().toUpperCase() %>">
                                        <input name="h_contact" type="hidden" value="<%= AC.getContact()%>">
                                        <input name="h_address" type="hidden" value="<%= AC.getAddress()%>">
                                        <input name="h_email" type="hidden" value="<%= AC.getEmail()%>">
                                        <input name="h_remarks" type="hidden" value="<%= AC.getRemarks()%>">
                                        <input name="h_credit" type="hidden" value="<%= AC.getCreditLimit()%>">
                                        <input name="h_cu" type="hidden" value="<%= AC.getCustomer()%>">
                                        <input name="h_su" type="hidden" value="<%= AC.getSupplier()%>">
                                        <input name="h_ex" type="hidden" value="<%= AC.getExpences()%>">
                                        <input name="h_em" type="hidden" value="<%= AC.getEmployee()%>">
                                        <input name="h_ba" type="hidden" value="<%= AC.getBank()%>">

                                        <div class="btn-group" role="group" aria-label="Basic example">
                                            <%if(USER.getAccount().contains("B") ){ %>
                                            <button type="button" class="btn btn-sm btn-success update">UPDATE</button>
                                            <% } %>
                                            <%if(USER.getAccount().contains("C") ){ %>
                                            <button type="button" class="btn btn-sm btn-warning delete">DELETE</button>
                                            <% } %>
                                            <%if(USER.getAccount().contains("D") ){ %>
                                            <button type="button" class="btn btn-sm btn-info view">VIEW</button>
                                            <% } %>
                                        </div>

                                    </td>

                                </tr>
                                <%
                                    }
                                    ses.close();
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


        <!-- Modal update -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Update account details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group mb-3">

                                    <label class="checkbox-inline">
                                        <input type="checkbox" id="up_cu" value=""><span id="txt_up_cu">Customer</span> 
                                    </label>&nbsp;&nbsp;
                                    <label class="checkbox-inline">
                                        <input type="checkbox" id="up_su" value=""><span id="txt_up_su">Supplier</span>
                                    </label>&nbsp;&nbsp;
                                    <label class="checkbox-inline">
                                        <input type="checkbox" id="up_ex" value=""><span id="txt_up_ex">Expenses</span>
                                    </label>&nbsp;&nbsp;
                                    <label class="checkbox-inline">
                                        <input type="checkbox" id="up_em" value=""><span id="txt_up_em">Employee</span>
                                    </label>&nbsp;&nbsp;
                                    <label class="checkbox-inline" >
                                        <input type="checkbox" id="up_ba" value=""><span id="txt_up_ba">Bank</span>
                                    </label>&nbsp;&nbsp;

                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Name</span>
                                    </div>
                                    <input type="text" class="form-control" name="u_name" id="u_name">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Email</span>
                                    </div>
                                    <input type="text" class="form-control" name="u_email" id="u_email">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Address</span>
                                    </div>
                                    <input type="text" class="form-control" name="u_address" id="u_address">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Contact</span>
                                    </div>
                                    <input type="number" class="form-control" name="u_contact" id="u_contact">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Remarks</span>
                                    </div>
                                    <input type="text" class="form-control" name="u_remarks" id="u_remarks">
                                </div>
                                <div class="input-group mb-3 d-none">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Credit Limit</span>
                                    </div>
                                    <input type="number" class="form-control" name="u_credit" id="u_credit">
                                </div>
                                <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                    <button type="button" class="btn btn-success" id="u_save"><span class="fa fa-save mr-2"></span>UPDATE DETAILS</button>
                                </div>
                                <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                    <a type="button"  class="btn btn-info " id="u_cat"><span class="fa fa-user mr-2"></span>UPDATE CATEGORY</a>
                                </div>
                                <input type="hidden" name="u_id" id="u_id">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal view-->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Account details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row " id="acc_details" >

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>



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

            $('select[name="type"]').change(function () {
                $('#name').focus();
            });
            $('#name').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    $('#email').focus();
                }
            });
            $('#email').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    $('#address').focus();
                }
            });
            $('#address').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    $('#contact').focus();
                }
            });
            $('#contact').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    $('#remarks').focus();
                }
            });
            $('#remarks').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    $('#credit').focus();
                }
            });
            $('#credit').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    save();
                }
            });




            $("#save").click(function () {
                save();
            });
            $(".update").click(function () {

                var id = $(this).closest('tr').find('input[name="accid"]').val();

                var name = $(this).closest('tr').find('input[name="h_name"]').val();
                var address = $(this).closest('tr').find('input[name="h_address"]').val();
                var contact = $(this).closest('tr').find('input[name="h_contact"]').val();
                var remarks = $(this).closest('tr').find('input[name="h_remarks"]').val();
                var email = $(this).closest('tr').find('input[name="h_email"]').val();
                var credit = $(this).closest('tr').find('input[name="h_credit"]').val();

                var h_cu = $(this).closest('tr').find('input[name="h_cu"]').val();
                var h_su = $(this).closest('tr').find('input[name="h_su"]').val();
                var h_ex = $(this).closest('tr').find('input[name="h_ex"]').val();
                var h_em = $(this).closest('tr').find('input[name="h_em"]').val();
                var h_ba = $(this).closest('tr').find('input[name="h_ba"]').val();
                if (h_cu === "1") {
                    $("#up_cu").prop('checked', true);
                    $("#up_cu").show();
                    $("#txt_up_cu").show();
                    $("#up_su").show();
                    $("#txt_up_su").show();
                    
                    $("#up_ex").hide();
                    $("#txt_up_ex").hide();
                    $("#up_em").hide();
                    $("#txt_up_em").hide();
                    $("#up_ba").hide();
                    $("#txt_up_ba").hide();
                    
                    

                } else {
                    $("#up_cu").prop('checked', false);

                }
                if (h_su === "1") {
                    $("#up_su").prop('checked', true);
                    $("#up_cu").show();
                    $("#txt_up_cu").show();
                    $("#up_su").show();
                    $("#txt_up_su").show();
                    
                    $("#up_ex").hide();
                    $("#txt_up_ex").hide();
                    $("#up_em").hide();
                    $("#txt_up_em").hide();
                    $("#up_ba").hide();
                    $("#txt_up_ba").hide();
                    

                } else {
                    $("#up_su").prop('checked', false);

                }
                if (h_ex === "1") {
                    $("#up_ex").prop('checked', true);
                    $("#up_ex").show();
                    $("#txt_up_ex").show();
                    
                    
                    $("#up_su").hide();
                    $("#txt_up_su").hide();
                    $("#up_cu").hide();
                    $("#txt_up_cu").hide();
                    $("#up_em").hide();
                    $("#txt_up_em").hide();
                    $("#up_ba").hide();
                    $("#txt_up_ba").hide();
                    

                } else {
                    $("#up_ex").prop('checked', false);

                }
                if (h_em === "1") {
                    $("#up_em").prop('checked', true);
                    $("#up_em").show();
                    $("#txt_up_em").show();
                    
                    $("#up_su").hide();
                    $("#txt_up_su").hide();
                    $("#up_cu").hide();
                    $("#txt_up_cu").hide();
                    $("#up_ex").hide();
                    $("#txt_up_ex").hide();
                    $("#up_ba").hide();
                    $("#txt_up_ba").hide();

                } else {
                    $("#up_em").prop('checked', false);

                }
                if (h_ba === "1") {
                    $("#up_ba").prop('checked', true);
                    $("#up_ba").show();
                    $("#txt_up_ba").show();
                    
                    $("#up_su").hide();
                    $("#txt_up_su").hide();
                    $("#up_cu").hide();
                    $("#txt_up_cu").hide();
                    $("#up_em").hide();
                    $("#txt_up_em").hide();
                    $("#up_ex").hide();
                    $("#txt_up_ex").hide();

                } else {
                    $("#up_ba").prop('checked', false);

                }


                document.getElementById("u_name").value = "" + name;
                document.getElementById("u_address").value = "" + address;
                document.getElementById("u_contact").value = "" + contact;
                document.getElementById("u_remarks").value = "" + remarks;
                document.getElementById("u_email").value = "" + email;
                document.getElementById("u_credit").value = "" + credit;
                document.getElementById("u_id").value = "" + id;
                $("#u_cat").hide();
                if (h_cu == 1) {
                    $("#u_cat").show();
                }
                $('#myModal').modal('show');


            });

            $("#clear").click(function () {

                $('input[name="contact"]').val("");
                $('input[name="email"]').val("");
                $('input[name="address"]').val("");
                $('input[name="remarks"]').val("");
                $('input[name="credit"]').val("");
                $('input[name="name"]').val("");
                $('input[name="name"]').focus();

            });


            $("#u_save").click(function () {
                update();
            });
            $("#u_cat").click(function () {
                var ID = $('input[name="u_id"]').val();
                location.replace("customercategory.jsp?c=" + ID);
            });

            $(".view").click(function () {
                var i = $(this).closest('tr').find('input[name="accid"]').val();
                $.ajax({
                    url: 'viewAccountServlet',
                    data: {
                        id: i
                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        document.getElementById("acc_details").innerHTML = "" + data;

                    },
                    error: function () {
                        swal({
                            title: "Something went wrong !",
                            text: "something wrong in saving data please retry.",
                            icon: "error",
                            button: "OK"
                        });
                    }
                });

                $('#myModal2').modal('show');
            });

            $(".delete").click(function () {

                var idd = $(this).closest('tr').find('#accid').val();
                var stat = $(this).closest('tr').find('input[name="stat"]').val();
                var name = "";

                if (stat == "1") {

                    name = "delete";
                } else {

                    name = "restore";
                }

                swal({
                    title: "Are you sure?",
                    text: "do you want to " + name + " account ? ",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then((willDelete) => {


                    if (willDelete) {

                        $.ajax({
                            url: 'deleteAccountServlet',
                            data: {
                                id: idd
                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {

                                if (data === "1") {

                                    swal({
                                        title: "Good job!",
                                        text: "you " + name + " account from list !",
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
                                } else if (data === "4") {
                                    location.replace("login.jsp");
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
                            text: "you cancelled " + name + " process.",
                            icon: "error",
                            button: "OK"
                        });
                    }
                });
            });

            function update() {
                var cu = '0';
                var su = '0';
                var ex = '0';
                var em = '0';
                var ba = '0';
                if ($('#up_cu').prop("checked") == true) {
                    cu = '1'

                }
                if ($('#up_su').prop("checked") == true) {
                    su = '1'

                }
                if ($('#up_ex').prop("checked") == true) {
                    ex = '1'

                }
                if ($('#up_em').prop("checked") == true) {
                    em = '1'

                }
                if ($('#up_ba').prop("checked") == true) {
                    ba = '1'

                }



                $.ajax({
                    url: 'updateAccountServlet',
                    data: {
                        name: $('input[name="u_name"]').val(),
                        id: $('input[name="u_id"]').val(),
                        contact: $('input[name="u_contact"]').val(),
                        email: $('input[name="u_email"]').val(),
                        address: $('input[name="u_address"]').val(),
                        remarks: $('input[name="u_remarks"]').val(),
                        credit: $('input[name="u_credit"]').val(),
                        cu: cu,
                        su: su,
                        ex: ex,
                        em: em,
                        ba: ba


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {

                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you update account !",
                                icon: "success",
                                button: "OK"
                            }).then((value) => {

                                location.reload();
                            });
                        } else if (data === "0") {
                            swal({
                                title: "Empty name or type",
                                text: "Can't let any field empty.",
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
                        } else if (data === "4") {
                            location.replace("login.jsp");
                        }
                    },
                    error: function () {
                        swal({
                            title: "Something went wrong !",
                            text: "something wrong in saving data please retry.",
                            icon: "error",
                            button: "OK"
                        });
                    }
                });

            }

            function save() {
                $.ajax({
                    url: 'saveAccountServlet',
                    data: {
                        name: $('input[name="name"]').val(),
                        contact: $('input[name="contact"]').val(),
                        email: $('input[name="email"]').val(),
                        address: $('input[name="address"]').val(),
                        remarks: $('input[name="remarks"]').val(),
                        credit: $('input[name="credit"]').val(),
                        type: $('#type').find(":selected").val()


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {

                        var id = data.split("~")[1];
                        data = data.split("~")[0];
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you create new account !",
                                icon: "success",
                                button: "OK"
                            }).then((value) => {
                                if ($('#type').find(":selected").val() === 1) {
                                    location.replace('customercategory.jsp?c=' + id);
                                } else {
                                    location.reload();
                                }

                            });
                        } else if (data === "0") {
                            swal({
                                title: "Empty name or type",
                                text: "Can't let any field empty.",
                                icon: "error",
                                button: "OK"
                            });
                        }
                    },
                    error: function () {
                        swal({
                            title: "Something went wrong !",
                            text: "something wrong in saving data please retry.",
                            icon: "error",
                            button: "OK"
                        });
                    }
                });
            }


        </script>

        <%} else{ response.sendRedirect("login.jsp"); } %>    
    </body>
</html>