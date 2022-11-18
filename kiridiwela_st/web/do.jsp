<%@page import="resources.HoldInvoice"%>
<%@page import="dataclass.do_id"%>
<%@page import="dataclass.do_data"%>
<%@page import="servlet.invoiceReturnModel"%>
<%@page import="java.util.Set"%>
<%@page import="resources.SaleInvoiceItem"%>
<%@page import="resources.SaleInvoice"%>
<%@page import="dataclass.invoiceModel"%>
<%@page import="resources.Stock"%>
<%@page import="resources.Settings"%>
<%@page import="dataclass.quotationModel"%>
<%@page import="resources.Items"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="dataclass.itemModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="resources.User"%>
<%@page import="dataclass.helper"%>
<%@page import="resources.Branch"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.PaymentType"%>
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
        <title><%=Name%></title>

        <!-- Bootstrap core CSS -->
        <link href="src/boostrap/bootstrap-4.1.3/css/bootstrap.min.css" rel="stylesheet">
        
        
  
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
        <!-- Data Tables CDN -->
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
        <link href="src/datepicker/dist/datepicker.css" rel="stylesheet">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <style>
            .twitter-typeahead, .tt-hint, .tt-input, .tt-menu { width: 100%; }
        </style>

    </head>

    <body>

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->



        <main role="main" class="container"  >
            <div class="container-fluid mt-5" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); padding: 25px 25px 25px 25px;border-radius: 8px;">
                <%

                    helper h = new helper();
                    String date = h.getDate();

                    int ISP1 = 0;

                    String A = "0";
                    String B = "0";
                    String C = "";

                    if (request.getSession().getAttribute("i1") != null) {
                        String[] AA = (String[]) request.getSession().getAttribute("i1");
                        A = AA[0];
                        B = AA[1];
                        C = AA[2];

                        ISP1 = 1;
                    }

                    double grandtotal = 0.0;
                    Session Hses = connection.getConnection.getSessionFactory().openSession();
                    String ID = "";
                    int IN = 0;
                    int AC = 0;
                    if (request.getParameter("q") != null && !request.getParameter("q").equals("")) {
                        ID = request.getParameter("q");
                    }

                %>


                <div class="row mt-3">
                    <h5>Delivery Order</h5>
                </div>

                <div class="row mt-1">
                    <div class="input-group input-group-append">
                        <div class="mr-2">
                            <div class="input-group ">
                                <a class="btn btn-info mt-2 btn-sm" href="select_do.jsp?a=390ab7b5754f7975bc1100f1566b12d5">FIND INVOICE</a>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row mt-2">
                    <table class="table table-sm table-bordered" id="">
                        <thead>
                            <tr style="background-color:#10ac84 !important; color: white !important; ">
                                <th style="border: #2d3436 solid 1px;">DETAILS</th>
                                <th style="border: #2d3436 solid 1px;">TRANSPORT</th>
                                <th style="border: #2d3436 solid 1px;">ITEMS</th>
                                
                            </tr>
                        </thead>
                        <tbody>

                            <% 
                                if(request.getSession().getAttribute("do_id_list") != null && request.getSession().getAttribute("do_item_list") != null){
                                 
                                       ArrayList<do_data> do_item_list = (ArrayList<do_data>) request.getSession().getAttribute("do_item_list");
                                       ArrayList<do_id> do_id_list = (ArrayList<do_id>) request.getSession().getAttribute("do_id_list");
                                       for(do_id did : do_id_list){
                                            int i = 0;                
                                           Session ses = connection.getConnection.getSessionFactory().openSession();
                                           HoldInvoice HI = (HoldInvoice) ses.load(HoldInvoice.class, did.getHold_id());
                                       
                                      
                                    
                                
                            %>
                            <tr style="background-color: #ffffff !important; color: black !important; ">
                                <td style="border: #2d3436 solid 1px;">
                                   Name : <%=HI.getAccount().getName() %><br>
                                   ID : <%=HI.getIdholdInvoice() %><br>
                                   Date : <%=HI.getDate()%><br>
                                   <button class="btn btn-sm remove_i btn-primary" value="<%=i %>" >remove</button>
                               </td>
                               
                               <td style="border: #2d3436 solid 1px;"><input type="number" style="width: 100px;" class="tt" value="<%=did.getTranport() %>"><button class="change_trans" value="<%=i %>">change</button></td>
                               
                               <td style="border: #2d3436 solid 1px;">
                                    <table class="table table-sm ">
                                        
                                        
                                        <tr style="background-color: #e1b12c !important; color: white !important; ">
                                            <th>ITEM ID</th>
                                            <th>NAME</th>
                                            <th>QTY</th>
                                            <th>QTY SENT</th>
                                            <th>NOW SENDING</th>
                                            <th></th>
                                            
                                        </tr>
                                        <%
                                            for(do_data di:do_item_list){ 
                                                int j=0;
                                                if(di.getHold_Invoice_Number() == did.getHold_id()){
                                            %>
                                        <tr style="background-color: #f5f6fa !important; color: black !important; ">
                                            <td style="border: #eb4d4b solid 1px;"><%=di.getItem_ID() %></td>
                                            <td style="border: #eb4d4b solid 1px;"><%=di.getItem_Name() %></td>
                                            <td style="border: #eb4d4b solid 1px;"><%=di.getQty() %></td>
                                            <td style="border: #eb4d4b solid 1px;"><%=di.getQty_sended() %></td>
                                            <td style="border: #eb4d4b solid 1px;"><input type="number" class="qq" style="width: 100px;" value="<%=di.getQty_send() %>"><button class="change_qty" value="<%=j %>">change</button></td>
                                            <td style="border: #eb4d4b solid 1px;"><button class="btn btn-sm remov btn-info" value="<%=j %>" >remove</button></td>
                                        </tr>
                                        
                                        <%
                                            ++j;
                                            }
                                            }
                                            %>
                                    </table>


                                </td>
                               
                            </tr>
                           
                            <%
                                ++i;
                                }
                                }

                            %>

                        </tbody>
                    </table>
                </div>
                <div class="row mt-2">
                    <div class="col-sm-12 pl-0">
                        <div class="col-sm-4">
                            
                            <div class="input-group mt-2">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">REMARKS:</span>
                                </div>
                                <input type="text" class="form-control" name="re" id="re" >

                            </div>
                        </div>

                        <div class="btn-group mb-3 mt-2" role="group" aria-label="Basic example">

                            <button type="button" class="btn btn-success btn-sm" id="savedo"><span class="fa fa-save mr-2"></span>PROCEED</button>
                            <button type="button" class="btn btn-danger btn-sm" id="clr"><span class="fa fa-trash mr-2"></span>CLEAR</button>
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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js" type="text/javascript"></script>
        <script src="src/datepicker/dist/datepicker.js" type="text/javascript"></script>
        <script src="src/js/printThis.js" type="text/javascript"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script src="src/js/bootstrap3-typeahead.min.js"></script>

        <script>

        </script>



        <script type="text/javascript">

            $("#q").focus();
            $('.change_trans').click(function (e) {

            var hash = $(this).closest('tr').find('.change_trans').val();
            var tt = $(this).closest('tr').find('.tt').val();
                $.ajax({
                    url: 'ChangeDOTransSertvlet',
                    data: {
                    hash:hash,
                    tt:tt


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        if(data === '1'){
                            location.reload();
                            
                        }else if(data === '2'){
                            swal(" Value Is High ! ").then(function (){
                                location.reload();
                            });;
                            
                            
                        }else if(data === '3'){
                            swal("Value Is Zero ! ").then(function (){
                                location.reload();
                            });;
                            
                            
                        }else{
                             swal("Something Went Wrong ! Please Re Try...");
                            
                        }
                    


                    },
                    error: function () {
                        swal("TRY AGAIN !");
                    }
                });
            });
            $('.change_qty').click(function (e) {

            var hash = $(this).closest('tr').find('.change_qty').val();
            var qty = $(this).closest('tr').find('.qq').val();
                $.ajax({
                    url: 'ChangeDOQtySertvlet',
                    data: {
                    hash:hash,
                    qty:qty


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        if(data === '1'){
                            location.reload();
                            
                        }else if(data === '2'){
                            swal("Qty Value Is High ! ").then(function (){
                                location.reload();
                            });;
                            
                            
                        }else if(data === '3'){
                            swal("Qty Value Is Zero ! ").then(function (){
                                location.reload();
                            });;
                            
                            
                        }else{
                             swal("Something Went Wrong ! Please Re Try...");
                            
                        }
                    


                    },
                    error: function () {
                        swal("TRY AGAIN !");
                    }
                });
            });
            $('.remove_i').click(function (e) {

            var hash = $(this).closest('tr').find('.remove_i').val();
                $.ajax({
                    url: 'RemoveDOInvoiceServlet',
                    data: {
                    hash:hash


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        location.reload();
                    


                    },
                    error: function () {
                        swal("TRY AGAIN !");
                    }
                });
            });
            
            $('.remov').click(function (e) {

            var hash = $(this).closest('tr').find('.remov').val();
                $.ajax({
                    url: 'RemoveDOItemServlet',
                    data: {
                    hash:hash


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        location.reload();
                    


                    },
                    error: function () {
                        swal("TRY AGAIN !");
                    }
                });
            });
            
            $('#clr').click(function (e) {

            var hash = 0;
                $.ajax({
                    url: 'RemoveAllDOServlet',
                    data: {
                    hash:hash


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        location.reload();
                    


                    },
                    error: function () {
                        swal("TRY AGAIN !");
                    }
                });
            });
            
            $('#savedo').click(function (e) {

            var hash = 0;
                $.ajax({
                    url: 'SaveDoServlet',
                    data: {
                    hash:hash,
                    re:$('#re').val()

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        var d=data.split('~');
                        data=d[0];
                        if(data==="1"){
                                                           swal({
                                                            title: "DO SAVED!",
                                                            text: "do saved. press ok to print",
                                                            icon: "success",
                                                            button: "OK"
                                                            }).then((value) => {
                                                                //location.replace('printdo.jsp?q='+d[1]);
                                                                location.reload();
                                                                popupWindow = window.open('printdo.jsp?q='+d[1],'popUpWindow','height='+screen.availHeight+',width='+screen.availWidth+',left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes');
                                                
                                                            });
                            
                        }else{
                            swal("PLEASE TRY AGAIN !");
                            
                        }
                    


                    },
                    error: function () {
                        swal("TRY AGAIN !");
                    }
                });
            });
            
            
            
            
           






        </script>


    </body>
</html>