<%@page import="java.text.DecimalFormat"%>
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
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css">
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
              line-height: 37px !important;
              border-radius: 0px !important;
            }

            .select2-selection {
              height: 37px !important;
              border-radius: 0px !important;
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
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">Account Cash / Credit</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Account</span>
                                    </div>
                                    <select class="form-control sp" style="width:418px !important;" id="account" name="account">
                                        <option value="0">PLEASE SELECT CUSTOMER</option>
                                        <%
                                            Session Hses = connection.getConnection.getSessionFactory().openSession();
                                            Criteria cust = Hses.createCriteria(Account.class);
                                            cust.add(Restrictions.eq("status", 1));
                                            List<Account> customerList = cust.list();
                                            for (Account CL : customerList) {
                                        %>
                                        <option value="<%=CL.getIdaccount()%>"><%=CL.getName()%></option>

                                        <%
                                            }
                                        %>

                                    </select>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Remarks</span>
                                    </div>
                                    <input type="text" class="form-control"  name="remark" id="remark">
                                </div>
                                

                            </div>
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Amount</span>
                                    </div>
                                    <input type="number" class="form-control" name="amount" id="amount">
                                </div>
                                <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                    <button type="button" class="btn btn-sm btn-success" id="credit"><span class="fa fa-save mr-2"></span>ADD AS RECEIVABLE</button>
                                    <button type="button" class="btn btn-sm btn-dark" id="debit"><span class="fa fa-save mr-2"></span>ADD AS PAYABLE</button>
                                    <button type="button" class="btn btn-sm btn-primary" id="balance"><span class="fa fa-save mr-2"></span>ADD AS BALANCE</button>
                                </div>


                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-light table-sm" id="tbl1">
                            <thead>
                                <tr>
                                    <td style="background-color:#10ac84 !important; color: white !important; ">Account ID</td>
                                    <td style="background-color:#10ac84 !important; color: white !important; ">Name</td>
                                    <td style="background-color:#10ac84 !important; color: white !important; ">Status</td>
                                    <td style="background-color:#10ac84 !important; color: white !important; ">Receivable Amount</td>
                                    <td style="background-color:#10ac84 !important; color: white !important; ">Payable Amount</td>
                                    <td style="background-color:#10ac84 !important; color: white !important; ">Balance Amount</td>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(Account.class);
                                    List<Account> ac = cr.list();

                                    for (Account AC : ac) {
                                %>
                                <tr>
                                    <td><%=AC.getIdaccount()%></td>
                                    <td><%= AC.getName()%></td>
                                    <%
                                        if (AC.getStatus() == 1) {
                                    %>
                                    <td><span class="badge bg-info">active</span></td>
                                    <%
                                    } else {
                                    %>
                                    <td><span class="badge bg-danger">deleted</span></td>

                                    <% }%>
                                    <td><%="RS: " + df.format(AC.getCreditBalance()) %></td>
                                    <td><%="RS: " + df.format(AC.getDebitBalance()) %></td>
                                    <td><%="RS: " + df.format(AC.getBalance()) %></td>

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
                        <h5 class="modal-title" id="exampleModalLongTitle">update ledger account</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">

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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>

        <script type="text/javascript">
            $(window).load(function(){
                $('.loader').fadeOut();
            });
            $(document).ready(function() {
                $('.sp').select2();
            });
            $('#tbl1').DataTable();
 
            
             $('#account').focus();
             

                
            $('select[name="account"]').change(function (){
                $('#amount').focus();
            });
            $('#amount').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                     $('#remark').focus();
                }
            });
            
            
            
            $("#credit").click(function () {
                    save(1);
            });
            $("#debit").click(function () {
                    save(2);
            });
            $("#balance").click(function () {
                    save(3);
            });
            
            
            
            
           
            function save(type){
                
                var func="";
                
                if(type == 1){
                    func="Receivable";
                    
                }else if(type == 2){
                    func="Payable";
                    
                }else if(type == 3){
                    func="balance";
                    
                }
                                            swal({
                                                title: "Do Payment ?",
                                                text: "do you want add as "+func+" to account.",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                if(willDelete){
                                                      saveAfter(type);
                                                }else{
                                                        
                                                        swal("function cancelled !");
                                                }
                                            });                                
            }
            
            function saveAfter(type){
                var amount=$('input[name="amount"]').val();
                var remark=$('input[name="remark"]').val();
                var account=$('#account').find(":selected").val();
                if(account == ''){
                    account=0;
                    
                }
                if(amount == ''){
                    amount=0;
                    
                }
                if(remark == ''){
                    remark='N/A';
                    
                }
                
                if(amount == 0 || account == 0 || type == 0 || remark == ''){
                    
                    swal("please fill all fields !").then((value) => {

                                    location.reload();
                            
                            });
                    
                }else{
                    
                    $.ajax({
                    url: 'saveAccountCash',
                    data: {
                            amount: amount,
                            type: type,
                            account:account,
                            re:remark
                          },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {

                            swal({
                            title: "Good job!",
                                    text: "you saved amount to account !",
                                    icon: "success",
                                    button: "OK"
                            }).then((value) => {

                                    location.reload();
                            
                            });
                    }else if (data === "0") {
                            swal({
                            title: "Empty account or type",
                                    text: "Can't let any field empty.",
                                    icon: "error",
                                    button: "OK"
                            }).then((value) => {

                                    location.reload();
                            
                            });
                    }
                    },
                    error: function () {
                        swal({
                        title: "Something went wrong !",
                                text: "something wrong in saving data please retry.",
                                icon: "error",
                                button: "OK"
                        }).then((value) => {

                                    location.reload();
                            
                            });
                    }
                });
                }
                
            }


        </script>


    </body>
</html>