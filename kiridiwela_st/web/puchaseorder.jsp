<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.Settings"%>
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
                            Session sesDetails=connection.getConnection.getSessionFactory().openSession();
                            Settings st=null;
                            String Name;
                            String Address;
                            String Image;
                            String Fax;
                            String Contact;
                            String Emial;
                            
                            Criteria crDetails=sesDetails.createCriteria(Settings.class);
                            List<Settings> set=crDetails.list();
                            
                            if(set.size()>0){
                                for(Settings ST:set){
                                    if(ST.getIdsettings()==1){
                                        st=ST;
                                        
                                    }
                                }
                            }
                            
                            if(st != null){
                                Name=st.getName();
                                Address=st.getAddress();
                                Image=st.getImage();
                                Fax=st.getFax();
                                Contact=st.getMobile();
                                Emial=st.getEmail(); 
                            }else{
                                Name="";
                                Address="";
                                Image="";
                                Fax="";
                                Contact="";
                                Emial=""; 
                            }
                            sesDetails.close();
                            DecimalFormat df = new DecimalFormat("##########0.00");

                            %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="icon" href="src/image/favicon.ico">
        <title><%=Name %></title>

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
        <link href="src/datepicker/dist/datepicker.css" rel="stylesheet">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    </head>

    <body>

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->



        <main role="main" class="container">
            <div class="container-fluid mt-5" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); padding: 25px 25px 25px 25px;border-radius: 6px;">
            <%
                    helper h = new helper();
                    String date = h.getDate();
                    User adm=(User) request.getSession().getAttribute("administrator");
                    int adminId = 0;
                    String aname = "";
                    if (adm != null) {
                        adminId = adm.getIduser();
                        aname = adm.getName();
                    }

                    int supid = 0;
                    Session ses = connection.getConnection.getSessionFactory().openSession();

                    int ISP1 = 0;

                    String A = "0";
                    String B = "0";
                    String C = "0";
                    String D = "0";
                    String E = "0";

                    if (request.getSession().getAttribute("po1") != null) {
                        String[] AA = (String[]) request.getSession().getAttribute("po1");
                        A = AA[0];
                        B = AA[1];
                        C = AA[2];
                        D = AA[3];
                        E = AA[4];
                        ISP1 = 1;
                    }

                    double grandtotal = 0.0;

                %>
            <div class="row mt-3">
                <h5>PURCHASE ORDER</h5>
            </div>
            
            <div class="row mt-1">
                
                <div class="input-group-append">
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height:35px;" id="inputGroup-sizing-default">SUPPLIER</span>
                            </div>
                            <select class="form-control sp" style="width:440px; height:35px;"  name="supplier" id="supplier" >
                               <option value="0">PLEASE SELECT SUPPLIER</option>
                                <%                                    
                                    Session ses4 = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr4 = ses4.createCriteria(Account.class);
                                    cr4.add(Restrictions.eq("status", 1));
                                    cr4.add(Restrictions.eq("supplier", 1));
                                    List<Account> d2 = cr4.list();
                                    if (d2.size() > 0) {
                                        for (Account B2 : d2) {
                                %>
                                <option value="<%=B2.getIdaccount() %>"><%=B2.getName()%></option>
                                <%

                                    }

                                } else {
                                %>
                                <option value="0">NO DATA FOUND</option>
                                <%
                                    }
                                    ses4.close();

                                %>
                            </select>
                        </div>
                    </div>
                    
                    
                </div>
                <div class="input-group-append">
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height:35px;" id="inputGroup-sizing-default">BRANCH</span>
                            </div>
                            <select class="form-control" style="width:225px;height:35px;" name="branch" id="branch">
                                 <option value="0">PLEASE SELECT</option>
                                <%                                    
                                    Session ses6 = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr6 = ses6.createCriteria(Branch.class);
                                    cr6.add(Restrictions.eq("status", 1));
                                    List<Branch> dd = cr6.list();
                                    if (dd.size() > 0) {
                                        for (Branch B2 : dd) {
                                            
                                        
                                %>
                                <option value="<%=B2.getIdbranch() %>"><%=B2.getName()%></option>
                                <%
                                    
                                    }

                                } else {
                                %>
                                <option value="0">NO DATA FOUND</option>
                                <%
                                    }

                                %>
                            </select>
                        </div>
                    </div>
                    
                </div>
            </div>
            
            
            <div class="row mt-1">
                <div class="input-group input-group-append">
                    <div class="mr-2">
                        <div class="input-group ">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height:35px;" id="inputGroup-sizing-default">ITEM</span>
                            </div>
                            <input class="form-control" type="text" style="width:440px;height:35px;" id="item" name="item">
                                
                        </div>
                    </div>
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height:35px;" id="inputGroup-sizing-default">QUANTITY</span>
                            </div>
                            <input type="number" class="form-control" style="width:108px;height:35px;" name="qty" id="qty">
                            
                        </div>
                    </div>
                    
                    <div class="">
                        <button class="btn btn-info add  ml-1"  style="height: 35px;" id="add">ADD TO LIST</button>
                    </div>
                </div>
            </div>
            <div class="row mt-1">
                        <div class="btn-group" role="group" aria-label="Basic example">
                            <button type="button"  id="b_rol" style="background-color:#ff9f43 !important; color: white !important; "class="btn btn-sm">ADD ROL PASSED</button>
                            <button type="button" id="b_hold" style="background-color:#341f97 !important; color: white !important; " class="btn btn-sm">ADD FROM HOLD INVOICE</button>
                            <button type="button" id="b_empty" style="background-color:#f368e0 !important; color: white !important; " class="btn btn-sm">ADD IF EMPTY</button>
                        </div>
                        
            </div>
            <div class="row mt-2">
                <table class="table table-sm table-bordered table-striped" id="">
                    <thead>
                        <tr>
                            <th style="background-color:#10ac84 !important; color: white !important; ">ITEM ID</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">ITEM</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">TYPE</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">QTY</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">TOTAL</th>
                            <th style="background-color:#10ac84 !important; color: white !important; "></th>
                        </tr>
                    </thead>
                    <tbody >
                                            <%
                                                ArrayList<itemModel> invoice = new ArrayList();
                                                if (request.getSession().getAttribute("invpo") != null) {
                                                    invoice = (ArrayList<itemModel>) request.getSession().getAttribute("invpo");
                                                    BigDecimal tot = new BigDecimal(0);
                                                    int i = 0;
                                                    for (itemModel IM : invoice) {
                                                        BigDecimal now = new BigDecimal(IM.getTotal());
                                                        tot = now.add(tot);
                                                        

                                            %>

                                            <tr>
                                                <td><%=IM.getItemId()%></td>
                                                <td><%=IM.getItemName()%></td>
                                                <td><%=IM.getType() %></td>
                                                <td><%=df.format(IM.getQty()) %></td>
                                                <td><%=df.format(IM.getTotal()) %></td>
                                                <td><button class="btn btn-sm remove btn-danger" value="<%=i%>" >remove</button></td>
                                            </tr>

                                            <% ++i;
                                                    }
                                                    grandtotal = tot.doubleValue();
                                                }
                                            %>
                                        </tbody>
                </table>
            </div>
                                        <div class="row mt-2">
                                            <table class="table table-sm">
                                                <tr>
                                                    <td style="background-color:#192a56 !important; color: white !important; ">Estimated cost RS.</td>
                                                    <td style="background-color:#192a56 !important; color: white !important; "><%=df.format(grandtotal) %></td>
                                                </tr>
                                            </table>
                                           
                                        </div>
            <div class="row mt-2">
                <div class="col-sm-12 pl-0">
                    <div class="btn-group mb-3 mt-2" role="group" aria-label="Basic example">
                                    
                        <button type="button" class="btn btn-success btn-sm" id="save_dev"><span class="fa fa-save mr-2"></span>SAVE PURCHASE ORDER</button>
                        <button type="button" class="btn btn-danger btn-sm" id="clr"><span class="fa fa-trash mr-2"></span>CLEAR</button>
                    </div>
                </div>
            </div>
        </div>
        </main>



        <!-- include header-->
        <jsp:include page="includes/footer.jsp" />
        <!-- include header-->


        
        <!-- Modal view-->
        <div class="modal fade" id="d_model_1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">DEFAULT QTY FOR IF ON EMPTY NOT SETUP</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row " >
                            <div class="col-sm-12 mt-1">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">QTY:</span>
                            </div>
                            <input type="number" class="form-control"   name="p_qty_1" id="p_qty_1" >
                            
                            
                        </div>
                    </div>
                            <div class="col-sm-12 mt-2">
                                <button class="btn btn-info" id="p_save_1">ADD TO LIST</button>
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
        <div class="modal fade" id="r_model_1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">REMARKS</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row " >
                            <div class="col-sm-12 mt-1">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">REMARKS:</span>
                            </div>
                            <input type="text" class="form-control"   name="r_qty_1" id="r_qty_1" >
                            
                            
                        </div>
                    </div>
                            <div class="col-sm-12 mt-2">
                                <button class="btn btn-info" id="r_save_1">SAVE</button>
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
        <div class="modal fade" id="myModal12" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog  modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle" >please select item</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row " >
                            <div class="col-sm-12 mt-1">
                               
                                    <div class="mr-2">
                                    <input type="text" class="typeahead form-control col-sm-12" data-provide="typeahead" > 
                                   
                                    </div>


                               
                                
                            </div>
                            

                        </div>
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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js" type="text/javascript"></script>
        <script src="src/datepicker/dist/datepicker.js" type="text/javascript"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script src="src/js/bootstrap3-typeahead.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>
        
        <script type="text/javascript">
            $(document).ready(function() {
                $('.sp').select2();
            });
                $(document).ready(function(){
                    
                            
                            
                            var $input = $(".typeahead");
                                $input.typeahead({
                                source: function (query, process) {
                                    return $.getJSON(
                                        'getItemJsonServlet3?id=<%=D%>',
                                        { query: query },
                                        function (data) {

                                            return process(data);

                                        });
                                },
                                    autoSelect: true,
                                    hint:true,
                                    highlight:true
                                });
                          $input.change(function() {
                          var current = $input.typeahead("getActive");
                          if (current) {
                            // Some item from your model is active!
                            if (current.name == $input.val()) {
                              getItemName(current.id);
                              closeModel();
                            } else {
                              // This means it is only a partial match, you can either add a new item
                              // or take the active if you don't want new items
                              $("#item").focus();
                              $('#myModal12').modal('hide');
                            }
                          } else {
                            // Nothing is active so it is a new value (or maybe empty value)
                            $("#item").focus();
                            $('#myModal12').modal('hide');
                          }
                        });
                });
                
                
    </script>
        <script type="text/javascript">
            var i=0;
            $('#myModal12').on('hidden.bs.modal', function (e) {
                if(i==0){
                   $("#item").focus(); 
                }else{
                    $("#mess").focus();
                }
                
            });
            $('#myModal12').on('shown.bs.modal', function (e) {
                $(".typeahead").val('');
                $(".typeahead").focus();
            });
            
            function closeModel(){
                $('#myModal12').modal('hide');
                i=1;
            }
            
            
            $('#supplier').off();
            $('#supplier').focus();
            
            
            var supid = 0;
            var date = "";
            var user = 0;
            var bran=0;
            var P1 =<%=ISP1%>;
            
            if (P1 === 1) {

                supid =<%= D%>;
                date =<%=B%>;
                user =<%=C%>;
                bran =<%=E%>;
                document.getElementById("supplier").value = "" + supid;
                document.getElementById("branch").value = "" + bran;
                $("#supplier").prop("disabled", true);
                $("#branch").prop("disabled", true);
                $('#item').focus();
                
                
                
            }
            
            $("#supplier").change(function () {
                supid = $('#supplier').find(":selected").val();
                $("#branch").focus();
            });
            $("#branch").change(function () {
                bran = $('#branch').find(":selected").val();
            
                date =<%=date%>;
                user =<%=adminId%>;
            if (supid > 0 && bran >0) {

            $.ajax({
            url: 'Po1Servlet',
                    data: {
                    
                            date: date,
                            user: user,
                            sup: supid,
                            branch:bran

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {
                    $("#supplier").prop("disabled", true);
                    $("#branch").prop("disabled", true);
                    $('#item').focus();
                    location.reload();
                    } else if (data === "0") {


                    }



                    },
                    error: function () {

                    }
            }
            );
            }






            });
            
            $("#clr").click(function () {

            $.ajax({
            url: 'Po1Clear',
                    data: {
                    type: 1

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {

                    $("#supplier").prop("disabled", false);
                    $("#branch").prop("disabled", false);
                    reload();
                    } else if (data === "0") {


                    }



                    },
                    error: function () {

                    }
            }
            );
            });
            function reload() {

                location.reload();
                $('#item').focus();
            }


            var ItemID = 0;
            
            $('#qty').keypress(function (e) {
                
                if (e.which === 13) {
                    
                
                    if (ItemID == 0){

                            swal("PLEASE SELECT ITEM FIRST !");
                    } else{

                            onAddPress();
                    }
                }
            });
            
            
            
            
            $('#add').click(function (e) {
                onAddPress();
            });
            
            
            $("#item").click(function () {
               
                var item = $('#item').val();
                if(item == '' || item == '0'){
                     $("#myModal12").modal();
                    
                }else{
                    if(isNaN(item)){
                        $('#item').val("");
                        $('#item').focus();
                    }else{
                        getItemName(item); 
                    }
                   
                }
                
            });
            $('#item').keypress(function (e) {
                
                if (e.which === 13) {
                   var item = $('#item').val();
                if(item == '' || item == '0'){
                    $("#myModal12").modal();
                    
                }else{
                    getItemName(item);
                }
                    
                }
            });
            
            
            
            
            function  getItemName(itemId){
                    
                    var hash = itemId;
                    $.ajax({
                    url: 'getItemNameServlet2',
                            data: {
                            hash:hash


                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                               
                                var d=data.split("~");
                                data=d['0'];
                                var xx=d['1'];   
                                 
                            if (data === "1") {
                               ItemID = d['2'];
                               $('#item').val(xx);
                               $('#qty').focus();
                              
                            } else if (data === "0") {
                                    ItemID=0;
                                    
                                     swal("PLEASE ENTER VALID  ITEM ID ! !").then((value) => {
                                        $('#item').focus();
                                    });
                            }


                            },
                            error: function () {
                            swal("TRY AGAIN !");
                            }
                    });
                
                
            }
            
            
            function onAddPress(){
                
            var qty = $('#qty').val();
               
            if (qty == ''){
            qty = 0;
            }
            
            if (supid == 0  || date == '' || user == 0 ){
            swal("PLEASE SET SUPPLIER DATE USER BRANCH FIRST !");
            } else{
            if (ItemID == 0 || qty == 0){

            swal("PLEASE SET ITEM AND QTY FIRST !");
            } else{

            $.ajax({
            url: 'SetInvoiceServletPo1',
                    data: {
                            itemid: ItemID,
                            qty: qty
                            

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {
                    reload();
                    } else if (data === "0") {

                        swal("PLEASE SELECT DATA FIRST !");
                    }



                    },
                    error: function () {
                    swal("TRY AGAIN !");
                    }
            });
            }

            }

            }
            
            

            $('.remove').click(function (e) {

            var hash = $(this).closest('tr').find('.remove').val();
            $.ajax({
            url: 'RemoveInvoiceServletPo1',
                    data: {
                    hash:hash


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {

                    if (data === "1") {
                    reload();
                    } else if (data === "0") {

                    swal("PLEASE SELECT DATA FIRST !");
                    }


                    },
                    error: function () {
                    swal("TRY AGAIN !");
                    }
            }
            );
            });
            
            // get from rol empty hold
            
            
            $("#b_rol").click(function () {
              
                 onROL();
            
            });
            $("#b_hold").click(function () {
              
                onHOLD();
            
            });
            
            $("#b_empty").click(function () {
                 $("#d_model_1").modal();

                 
            
            });
            
            
            $('#d_model_1').on('shown.bs.modal', function (e) {
                $("#p_qty_1").focus();
            });
            
            $("#p_save_1").click(function () {
              
                onEmpty();
            
            });
            $('#p_qty_1').keypress(function (e) {
                
                if (e.which === 13) {
                   onEmpty();
                }
            });
            
            
            function onHOLD(){
                
                $.ajax({
                    url: 'SetHoldServletPo1',
                    data: {
                            sp: supid
                            

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {
                    reload();
                    } else if (data === "0") {

                        swal("PLEASE SELECT DATA FIRST !");
                    }



                    },
                    error: function () {
                    swal("TRY AGAIN !");
                    }
              });
                
            }
            function onROL(){
                
                $.ajax({
                    url: 'SetROLServletPo1',
                    data: {
                            sp: supid
                            

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {
                    reload();
                    } else if (data === "0") {

                        swal("PLEASE SELECT DATA FIRST !");
                    }



                    },
                    error: function () {
                    swal("TRY AGAIN !");
                    }
              });
                
            }
            
            function onEmpty(){
                var q=$('#p_qty_1').val();
                if(q == ''){
                    q=0;
                    
                }
                $.ajax({
                    url: 'SetEmptyServletPo1',
                    data: {
                            qty: q,
                            sp:supid
                            

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {
                    reload();
                    } else if (data === "0") {

                        swal("PLEASE SELECT DATA FIRST !");
                    }



                    },
                    error: function () {
                    swal("TRY AGAIN !");
                    }
              });
                
            }
            
             // get from rol empty hold
            
            
            $("#save_dev").click(function () {
                 $("#r_model_1").modal();

                 
            
            });
            
            
            $('#r_model_1').on('shown.bs.modal', function (e) {
                $("#r_qty_1").focus();
            });
            
            $("#r_save_1").click(function () {
              
                save();
            
            });
            $('#r_qty_1').keypress(function (e) {
                
                if (e.which === 13) {
                   save();
                }
            });
           
           
           
           function save(){
            
            var q=$('#r_qty_1').val();
                if(q == ''){
                    q="N/A";
                    
                }
            
            $.ajax({
            url: 'savePOServlet',
                    data: {
                            re:q

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        
                    var d=data.split("-");
                    data=d['0'];
                    var id=d['1'];
                    if (data === "1") {
                        
                        
                        
                                
                                swal({
                    title: "Print Purchase Order ?",
                    text: "do you want to Purchase Order now ? ",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then((willDelete) =>{
                        if(willDelete){
                            location.reload();
                            popupWindow = window.open('poprint.jsp?pid='+id,'popUpWindow','height='+screen.availHeight+',width='+screen.availWidth+',left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes');
                                                
                             
                            
                        }else{
                            swal({
                                title: "PO SAVED!",
                                text: "purchase order saved !",
                                icon: "success",
                                button: "OK"
                               }).then((value) => {
                                   location.reload();
                            });
                            
                        }
                    });
                                
                                    
                                
                          



                    } else if(data === "0") {
                        swal({
                        title: "Empty invoice Data!",
                            text: "can't get invoice data. please retry !",
                            icon: "error",
                            button: "OK"
                        });
                    }
                    },
                    error: function () {
                    swal({
                    title: "Something Went Wrong !",
                            text: "something wrong in saving data please retry.",
                            icon: "error",
                            button: "OK"
                    });
                    }
            }
            );
               
           }
           
        



        </script>


    </body>
</html>