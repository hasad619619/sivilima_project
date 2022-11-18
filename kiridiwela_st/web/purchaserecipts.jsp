<%@page import="resources.ChequeBook"%>
<%@page import="resources.TextList"%>
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
            .select2-selection__rendered {
              line-height: 35px !important;
              border-radius: 0px !important;
            }

            .select2-selection {
              height: 37px !important;
              width: 418px !important;
              border-radius: 0px !important;
            }
        </style>
        <link href="src/css/bootstrap-datepicker.min.css" rel="stylesheet">
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
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Release Payment</li>
                    
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
                                    <select class="form-control sp" style="width:400px ;" id="account" name="account">
                                        <option value="0">PLEASE SELECT ACCOUNT</option>
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
                                    <input type="text" class="form-control"  style="width:400px ;" name="remark" id="remark">
                                    
                                </div>
                                

                            </div>
                            <div class="col-md-6">
                                <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                    <button type="button" class="btn btn-success" id="pay_cash_l"><span class="fa fa-save mr-2"></span>PAY BY CASH</button>
                                    <button type="button" class="btn btn-info" id="pay_cheque_l"><span class="fa fa-save mr-2"></span>PAY BY CHEQUE</button>
                                    
                                </div>


                            </div>
                        </div>

                    </div>
                </div>
            </div>


        </main>

        <!-- Modal view-->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle" >do cash payment</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row " >
                            <div class="col-sm-12 mt-1">
                                <div class="input-group-append">
                                    <div class="mr-2">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">AMOUNT RS:</span>
                                            </div>
                                            <input type="number" class="form-control" style="width:320px;" name="pay_amount" id="pay_amount" onload="">
                                        </div>
                                    </div>


                                </div>


                            </div>
                            <div class="col-sm-12 mt-2">
                                <button class="btn btn-info" id="pay_cash">PAY</button>
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
        <div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle" >do cheque payment</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row " >
                            <div class="col-sm-12 mt-1">
                                <form action="" method="post">
                                    <div class="card-body">
                                        <div class="input-group-append mt-1">
                                            <div class="mr-2">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" style="width:150px;" id="inputGroup-sizing-default">Amount RS:</span>
                                                    </div>
                                                    <input type="number" class="form-control" style="width:320px;" name="cheque_amount" id="cheque_amount" onload="">
                                                </div>
                                            </div>


                                        </div>
                                        <div class="input-group-append mt-1">
                                            <div class="mr-2">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" style="width:150px;" id="inputGroup-sizing-default">Cheque Number</span>
                                                    </div>
                                                    <input type="text" list="text_list_c" class="form-control" style="width:320px;" name="cheque_number" id="cheque_number" onload="">
                                                </div>
                                            </div>


                                        </div>
                                        <datalist id="text_list_c">
                                            <%
                                                Session st_tx1=connection.getConnection.getSessionFactory().openSession();
                                                Criteria cr1=st_tx1.createCriteria(ChequeBook.class);
                                                List<ChequeBook> TL1=cr1.list();
                                                for(ChequeBook tl : TL1){
                                                    if( tl.getStatus() == 1){
                                                %>
                                            <option value="<%= tl.getChequeNumber()%>" >
                                            
                                                <% } } st_tx1.close(); %>
                                        </datalist>
                                        <div class="input-group-append mt-1">
                                            <div class="mr-2">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" style="width:150px;" id="inputGroup-sizing-default">Cheque Date:</span>
                                                    </div>
                                                    <input type="date"  class="form-control" style="width:320px;" name="cheque_date" id="cheque_date" onload="">
                                                </div>
                                                
                                            </div>


                                        </div>
                                        
                                        <div class="input-group-append mt-1">
                                            <div class="mr-2">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" style="width:150px;" id="inputGroup-sizing-default">Bank Branch:</span>
                                                    </div>
                                                    <input type="text" list="text_list" class="form-control" style="width:320px;" name="cheque_branch" id="cheque_branch" onload="">
                                                </div>
                                            </div>


                                        </div>
                                        <datalist id="text_list">
                                            <%
                                                Session st_tx=connection.getConnection.getSessionFactory().openSession();
                                                Criteria cr=st_tx.createCriteria(TextList.class);
                                                List<TextList> TL=cr.list();
                                                for(TextList tl : TL){
                                                %>
                                            <option value="<%= tl.getTest() %>" >
                                            
                                                <% } st_tx.close(); %>
                                        </datalist>
                                        <div class="input-group-append mt-1">
                                            <div class="mr-2">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" style="width:150px;" id="inputGroup-sizing-default">Bank:</span>
                                                    </div>
                                                    <%
                                                        Session se = connection.getConnection.getSessionFactory().openSession();
                                                        Criteria cr6 = se.createCriteria(Account.class);
                                                        cr6.add(Restrictions.eq("status", 1));
                                                        cr6.add(Restrictions.eq("bank", 1));
                                                        List<Account> sup1 = cr6.list();
                                                    %>
                                                    <select class="form-control" id="bank" style="width:320px;">
                                                        <option value="0">PLEASE SELECT</option>
                                                        <%
                                                            if (sup1.size() > 0) {
                                                                for (Account P : sup1) {
                                                        %>

                                                        <option value="<%=P.getIdaccount()%>"><%=P.getName()%></option>
                                                        <%

                                                            }

                                                        } else {
                                                        %>
                                                        <option selected>NO BANK FOUND</option>
                                                        <% } %>
                                                    </select>

                                                    <%
                                                        se.close();
                                                    %>
                                                </div>
                                            </div>


                                        </div>




                                    </div>





                                </form>

                            </div>
                            <div class="col-sm-12 mt-2">
                                <button class="btn btn-info" id="pay_cheque">PAY</button>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>



        <!-- include header-->
        <jsp:include page="includes/footer.jsp" />
        <!-- include header-->







        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="src/jquery/jquery-1.11.1.min.js" ></script>
        <script src="src/boostrap/bootstrap-4.1.3/js/bootstrap.min.js"></script>
        <script src="src/datepicker/dist/bootstrap-datepicker.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>

        <script type="text/javascript">
            $(window).load(function(){
                $('.loader').fadeOut();
            });
            $(document).ready(function (){
              
                $('.sp').select2();
                
            });
            
            $('#account').focus();
           
            var account = 0;

            function setVal() {

               account = $('#account').find(":selected").val();
                if (account === '') {
                    account = 0;

                }
                
                
            }


            $('#myModal2').on('shown.bs.modal', function () {
                $('#pay_amount').focus();
            });
            $('#myModal4').on('shown.bs.modal', function () {
                $('#cheque_amount').focus();
            });

            $("#pay_cash_l").click(function () {
                setVal();
                if( account === '0'){
                    swal("SELECT ACCOUNT FIRST !").then((value) => {
                         $('#account').focus();
                    });
                } else{
                        $("#myModal2").modal();
                }
               
            });
            $("#pay_cheque_l").click(function () {
                setVal();
                if(account === '0'){
                    swal("SELECT ACCOUNT FIRST !").then((value) => {
                         $('#account').focus();
                    });
                     
                }else{
                     $("#myModal4").modal();
                }
            });

            var pay_amount=0;
            
            //trans_amount_c pay_amount pay_cash
            $("#pay_cash").click(function (){
               savecash();
           });
           
           $('#pay_amount').keypress(function (e) {
                 pay_amount=$('#pay_amount').val();
                if (e.which === 13) {
                   savecash();
                    
                    
                }
            });
            
            function savecash(){
                
                                            swal({  
                                                title: "Want to pay with cash ?",
                                                text: "do you want to pay with cash",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                if(willDelete){
                                                       pay_amount=$('#pay_amount').val();
                                                       savCashChecked(account,pay_amount); 
                                                }else{
                                                        
                                                        $('#pay_amount').focus();
                                                }
                                            });
                
            }
            
            
            function savCashChecked(account,pay){
                    
                    $.ajax({
                             url: 'savePurchasesReciptCashServlet',
                                     data: {
                                     account: account,
                                     payment:pay,
                                     re:$('#remark').val()

                                     },
                                     type: 'post',
                                     cache: false,
                                     success: function (data) {
                                        var d=data.split("-");
                                        data=d['0'];
                                        var id=d['1'];
                                        if (data === "1") {
                                            
                                            swal({
                                                title: "Print Recipt ?",
                                                text: "do you want to print recipt now ? ",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                if(willDelete){
                                                        location.reload();
                                                        popupWindow = window.open('printreciptrelease.jsp?pid='+id,'popUpWindow','height='+screen.availHeight+',width='+screen.availWidth+',left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes');
                             
                                                }else{
                                                        swal({
                                                            title: "RECIPT SAVED!",
                                                            text: "recipt saved as Cash  !",
                                                            icon: "success",
                                                            button: "OK"
                                                            }).then((value) => {
                                                                location.reload();
                                                            });

                                                }
                                            });
                                            
                                        
                                        } else if(data === "0") {
                                              swal({
                                                title: "Empty Payment Data!",
                                                text: "can't get invoice data. please retry !",
                                                icon: "error",
                                                button: "OK"
                                            }).then((value) => {
                                                location.reload();
                                            });
                                        }
                                     },
                                     error: function () {
                                        swal({
                                            title: "Something Went Wrong !",
                                             text: "something wrong in saving data please retry.",
                                             icon: "error",
                                             button: "OK"
                                        }).then((value) => {
                                            location.reload();
                                        });
                                     }
                             });
               
           }
           
           
            var cheque_amount=0;
            
            $("#pay_cheque").click(function (){
               saveCheque();
           });
           
           $('#cheque_amount').keypress(function (e) {
                 cheque_amount=$('#cheque_amount').val();
                if (e.which === 13) {
                   $('#cheque_number').focus();
                    
                    
                }
            });
            $('#cheque_number').keypress(function (e) {
                 if (e.which === 13) {
                   $('#cheque_date').focus();
                   
                }
            });
            $('#cheque_date').keypress(function (e) {
                 if (e.which === 13) {
                   $('#cheque_branch').focus();
                   
                }
            });
            $('#cheque_branch').keypress(function (e) {
                 if (e.which === 13) {
                   $('#bank').focus();
                   
                }
            });
            
            $("#bank").change(function () {
                
               
                
            });
            
            function saveCheque(){
                
                    cheque_amount=$('#cheque_amount').val();
                    
                    if(cheque_amount==''){
                      cheque_amount=0;
                    }
                    
                    
                    
                    if(0< cheque_amount){
                        
                                        swal({
                                                title: "Want To Pay With Cheque ?",
                                                text: "do you want to pay with cheque ? ",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                if(willDelete){
                                                      cheque_amount=$('#cheque_amount').val();
                                                      savchequeChecked(account,cheque_amount);
                                                }else{
                                                        
                                                        $('#cheque_amount').focus();
                                                }
                                            });
                                            
                        
                    }else{
                        swal("ENTER AMOUNT FIRST !").then((value) => {
                         $('#cheque_amount').focus();
                        });
                        
                    }
                    
                
            }
            
            function savchequeChecked(account,pay){
                    var d=$('#cheque_date').val();
                   // var dd=d.split("/");
                    //d=dd[2]+"-"+dd[0]+"-"+dd[1];
                    $.ajax({
                             url: 'savePurchaseReciptChequeServlet',
                                     data: {
                                     account:account,
                                     payment:pay,
                                     number:$('#cheque_number').val(),
                                     date:d,
                                     branch:$('#cheque_branch').val(),
                                     bank:$('#bank').find(":selected").val(),
                                     re:$('#remark').val()
                                     

                                     },
                                     type: 'post',
                                     cache: false,
                                     success: function (data) {
                                        var d=data.split("-");
                                        data=d['0'];
                                        var id=d['1'];
                                        if (data === "1") {
                                            swal({
                                                title: "Print Recipt ?",
                                                text: "do you want to print recipt now ? ",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                if(willDelete){
                                                        location.reload();
                                                        popupWindow = window.open('printreciptrelease.jsp?pid='+id,'popUpWindow','height='+screen.availHeight+',width='+screen.availWidth+',left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes');
                             
                                                }else{
                                                        swal({
                                                            title: "RECIPT SAVED!",
                                                            text: "recipt saved as Cheque Payment !",
                                                            icon: "success",
                                                            button: "OK"
                                                            }).then((value) => {
                                                                location.reload();
                                                            });

                                                }
                                            });
                                                             
                                                

                                        } else if(data === "0") {
                                              swal({
                                                title: "Empty Recipt Data!",
                                                text: "can't get invoice data. please retry !",
                                                icon: "error",
                                                button: "OK"
                                            }).then((value) => {
                                                location.reload();
                                            });
                                        }
                                     },
                                     error: function () {
                                        swal({
                                            title: "Something Went Wrong !",
                                             text: "something wrong in saving data please retry.",
                                             icon: "error",
                                             button: "OK"
                                        }).then((value) => {
                                            location.reload();
                                        });
                                     }
                             });
               
           }
            
            




        </script>


    </body>
</html>