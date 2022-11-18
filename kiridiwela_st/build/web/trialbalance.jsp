<%@page import="resources.CustomerBranch"%>
<%@page import="java.util.Set"%>
<%@page import="dataclass.userHolder"%>
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
            double total_credit = 0.0;
            double total_debit = 0.0;
            double total_balance = 0.0;
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
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">Trial Balance</li>
                   
                    </ol>
                </nav>
            </div>
            <%if(USER.getAccounting().contains("M") ){ %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Account</span>
                                    </div>
                                    <select class="form-control sp" style="width:400px ;" id="account" name="account">
                                        <option value="0">ALL ACCOUNTS</option>
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
                                        
                                

                            </div>
                            <div class="col-md-6">
                                
                                <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                    <button type="button" class="btn btn-primary" id="balance">BALANCE ACCOUNT</button>
                                </div>


                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <% } %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                           <div class="row">
                                
                                <div class="col-md-12">
                                    <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                        <a style="background-color: #575fcf !important; color: white !important; " class="btn "  href="trialbalance.jsp?q=1">ALL</a>
                                        <a style="background-color: #0be881 !important; color: white !important; "  class="btn" href="trialbalance.jsp?q=2">CUSTOMER</a>
                                        <a style="background-color: #ef5777 !important; color: white !important; " class="btn " href="trialbalance.jsp?q=3">SUPPLIER</a>
                                        <a style="background-color: #ffa801 !important; color: white !important; " class="btn " href="trialbalance.jsp?q=4">EXPENSES</a>
                                        <a style="background-color: #00d8d6 !important; color: white !important; " class="btn " href="trialbalance.jsp?q=5">EMPLOYEE</a>
                                        <a style="background-color: #10ac84 !important; color: white !important; " class="btn " href="trialbalance.jsp?q=6" >BANK</a>
                                        


                                    </div>


                                </div>
                                
                            </div>
                       

                    </div>
                </div>
            </div>
           
            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-light" id="tbl1">
                            <thead>
                                <tr>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">Account ID</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">Name</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">Branch</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">Receivable Amount</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">Payable Amount</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">Balance</td>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(Account.class);
                                    cr.add(Restrictions.eq("status", 1)); 
                                    if (request.getParameter("q") != null && !request.getParameter("q").equals("")) {
                                        String Q=request.getParameter("q");
                                        if(Q.equals("1")){
                                        
                                        }
                                        else if(Q.equals("2")){
                                            cr.add(Restrictions.eq("customer", 1));
                                        }
                                        else if(Q.equals("3")){
                                            cr.add(Restrictions.eq("supplier", 1));
                                        }
                                        else if(Q.equals("4")){
                                            cr.add(Restrictions.eq("expences", 1));
                                        }
                                        else if(Q.equals("5")){
                                            cr.add(Restrictions.eq("employee", 1));
                                        }
                                        else if(Q.equals("6")){
                                            cr.add(Restrictions.eq("bank", 1));
                                        }
                                       

                                    }
                                    List<Account> ac = cr.list();

                                    for (Account AC : ac) {
                                        
                                        String BRANCH = ""; 
                                        Set<CustomerBranch> cb= AC.getCustomerBranches();
                                        for(CustomerBranch c:cb){
                                            BRANCH = BRANCH + c.getBranch().getName()+"\n";
                                        }
                                        total_credit=total_credit+AC.getCreditBalance();
                                        total_debit=total_debit+AC.getDebitBalance();
                                        total_balance=total_balance+AC.getBalance();
                                %>
                                <tr>
                                    <td><%=AC.getIdaccount()%></td>
                                    <td><%= AC.getName()%></td>
                                    <td><%=BRANCH %></td>
                                    <td><%="RS: " + df.format(AC.getCreditBalance()) %></td>
                                    <td><%="RS: " + df.format(AC.getDebitBalance()) %></td>
                                    <td><%="RS: " + df.format(AC.getBalance()) %></td>

                                </tr>
                                <%
                                    }
                                    ses.close();
                                %>
                                <tr>
                                    <td style="background-color: #1e272e !important; color: white !important; ">TOTAL</td>
                                    <td style="background-color: #1e272e !important; color: white !important; "></td>
                                    <td style="background-color: #1e272e !important; color: white !important; "></td>
                                    <td style="background-color: #1e272e !important; color: white !important; "><%=df.format(total_credit) %></td>
                                    <td style="background-color: #1e272e !important; color: white !important; "><%=df.format(total_debit) %></td>
                                    <td style="background-color: #1e272e !important; color: white !important; "><%=df.format(total_balance) %></td>
                                </tr>
                                <tr>
                                    <td style="background-color: #ff3f34 !important; color: white !important; ">NET TOTAL</td>
                                    <td style="background-color: #ff3f34 !important; color: white !important; "></td>
                                    <td style="background-color: #ff3f34 !important; color: white !important; "></td>
                                    <td style="background-color: #ff3f34 !important; color: white !important; "></td>
                                    <td style="background-color: #ff3f34 !important; color: white !important; "></td>
                                    <td style="background-color: #ff3f34 !important; color: white !important; "><%=df.format(total_credit - (total_balance+total_debit)) %></td>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>

        <script type="text/javascript">
            $(window).load(function(){
                $('.loader').fadeOut();
            });
            $('#tbl1').DataTable( {
              "order": [[ 0, "desc" ]]
            });

            $(document).ready(function() {
                $('.sp').select2();
            });
            
            $('#tbl1').DataTable();
            $('#account').focus();
            $("#balance").click(function () {
                    save();
            });
            
            
            
            
           
            function save(){
               $('#pleaseWaitDialog').modal();
                var account=$('#account').find(":selected").val();     
                $.ajax({
                    url: 'balanceAccountsServlet',
                    data: {
                            
                            q:account
                            
                          },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {
                            $('#pleaseWaitDialog').modal('hide');
                            swal({
                            title: "Good job!",
                                    text: "your account details now balanced !",
                                    icon: "success",
                                    button: "OK"
                            }).then((value) => {

                                    location.reload();
                            
                            });
                    }else if (data === "0") {
                            $('#pleaseWaitDialog').modal('hide');
                            swal({
                            title: "Empty account !",
                                    text: "Can't let any field empty.",
                                    icon: "error",
                                    button: "OK"
                            }).then((value) => {

                                    location.reload();
                            
                            });
                    }
                    },
                    error: function () {
                        $('#pleaseWaitDialog').modal('hide');
                        swal({
                        title: "Something went wrong !",
                                text: "something wrong in Getting data please retry.",
                                icon: "error",
                                button: "OK"
                        }).then((value) => {

                                    location.reload();
                            
                            });
                    }
                });
            }
            
        </script>

    <%} else{ response.sendRedirect("login.jsp"); } %>        
    </body>
</html>