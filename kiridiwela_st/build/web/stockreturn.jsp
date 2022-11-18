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
    </head>

    <body>

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->



        <main role="main" class="container" >
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
                    

                    if (request.getSession().getAttribute("r1") != null) {
                        String[] AA = (String[]) request.getSession().getAttribute("r1");
                        A = AA[0];
                        B = AA[1];
                        
                        ISP1 = 1;
                    }

                    double grandtotal = 0.0;

                %>
                <div class="container-fluid mt-5" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); padding: 25px 25px 25px 25px;border-radius: 5px;">
                     <div class="row mt-3">
                <h5>Return to supplier</h5>
            </div>
            
            <div class="row mt-1">
                
                <div class="input-group-append">
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">SUPPLIER</span>
                            </div>
                            <select class="form-control sp" style="width:440px;" name="supplier" id="supplier" >
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
            </div>
                            <div class="row mt-1">
                <div class="input-group-append">
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">BRANCH</span>
                            </div>
                            <select class="form-control" style="width:440px;" name="branch" id="branch">
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
                                <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">STOCK</span>
                            </div>
                            <select class="form-control sp" style="width:440px;" id="item" name="item">
                                <option value="0">SELECT DATA FIRST</option>
                            </select>
                        </div>
                    </div>
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">QUANTITY</span>
                            </div>
                            <input type="number" class="form-control" style="width:100px;" name="qty" id="qty">
                            
                        </div>
                    </div>
                    <div class="">
                        <button class="btn btn-info add" id="add">ADD TO LIST</button>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <table class="table table-sm table-light table-bordered" id="">
                    <thead>
                        <tr>
                            <th style="background-color:#10ac84 !important; color: white !important; ">STOCK ID</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">ITEM</th>
                            <th style="background-color:#10ac84 !important; color: white !important; " >QTY</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">COST</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">NET TOTAL</th>
                            <th style="background-color:#10ac84 !important; color: white !important; "></th>
                        </tr>
                    </thead>
                    <tbody>
                                            <%
                                                ArrayList<itemModel> invoice = new ArrayList();
                                                if (request.getSession().getAttribute("invr") != null) {
                                                    invoice = (ArrayList<itemModel>) request.getSession().getAttribute("invr");
                                                    BigDecimal tot = new BigDecimal(0);
                                                    int i = 0;
                                                    for (itemModel IM : invoice) {
                                                        BigDecimal now = new BigDecimal(IM.getTotal());
                                                        tot = now.add(tot);


                                            %>

                                            <tr>
                                                <td><%=IM.getItemId()%></td>
                                                <td><%=IM.getItemName()%></td>
                                                <td><%=df.format(IM.getQty()) +" " +IM.getType() %></td>
                                                <td><%=df.format(IM.getCost()) + " LKR"%></td>
                                                <td><%=df.format(IM.getTotal()) + " LKR"%></td>
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
                <div class="col-sm-12 pl-0">
                    <div class="col-sm-4">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">TOTAL RS:</span>
                            </div>
                            <input type="number" class="form-control" value="<%= df.format(grandtotal) %>"  disabled="" name="total" id="total" >
                            
                        </div>
                    </div>
                    
                    <div class="btn-group mb-3 mt-2" role="group" aria-label="Basic example">
                                    
                        <button type="button" class="btn btn-success btn-sm" id="save_dev"><span class="fa fa-save mr-2"></span>PROCEED</button>
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
        <script src="src/js/jquery.printPage.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>
        
        <script type="text/javascript">
             $(document).ready(function() {
                $('.sp').select2();
            });
            
            $('#paytype').off();
            $('#supplier').off();
            
            var supid = 0;
            var bran=0;
            
            var P1 =<%=ISP1%>;
            
            if (P1 === 1) {

                supid =<%=A%>;
                bran =<%=B%>;
                
                document.getElementById("supplier").value = "" + supid;
                document.getElementById("branch").value = "" + bran;
                
                $("#supplier").prop("disabled", true);
                $("#branch").prop("disabled", true);
                
                getSuppList();
            }

            function getSuppList() {

                supid = $('#supplier').find(":selected").val();
                bran = $('#branch').find(":selected").val();
                var dataString = 'p2=' + supid + '&b='+bran;
                
                $.ajax({
                        url: 'getSupplierServlet',
                        dataType: "json",
                        data: dataString,
                        cache: false,
                        success: function (player) {
                            let dropdown = $('#item');
                            dropdown.empty();
                            if (player.length === 0) {

                                $("#item").append("<option>NO ITEM FOUND</option>");
                                
                            } else {
                                $("#item").append("<option value=" + 0 + ">Please select Stock</option>");
                                $.each(player, function (key, value) {
                                $("#item").append("<option value=" + value.id + " >" + value.name + "</option>");
                                });
                            }
                    }
            });
            
            }

            $("#supplier").change(function () {
                 $("#branch").focus();
            });
            $("#branch").change(function () {
                
                bran = $('#branch').find(":selected").val();
                supid = $('#supplier').find(":selected").val();
                if (supid > 0 && bran >0) {

                            $.ajax({
                                url: 'R1Servlet',
                                data: {
                                    sup: supid,
                                    branch:bran

                                },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                                if (data === "1") {
                                    $("#supplier").prop("disabled", true);
                                    $("#branch").prop("disabled", true);
                                    getSuppList();
                                } else if (data === "0") {
                                    
                                }

                            },
                            error: function () {
                              

                            }
                        });
            }else{
                
                
            }
           

        });
            
            $("#clr").click(function () {

                    $.ajax({
                        url: 'R1Clear',
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
                });
            });
            
            function reload() {

                location.reload();
            
            }


            var ItemID = 0;
            
            $("#item").change(function () {
                var item = $('#item').find(":selected").val();
                ItemID = item;
                $('#qty').focus();
            });
            
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
            function onAddPress(){

                var qty = $('#qty').val();
                if (qty == ''){
                    qty = 0;
                }
                
                if (supid == 0){
                    swal("PLEASE SET SUPPLIER FIRST !");
                } else{
                    if (ItemID == 0 || qty == 0){

                    swal("PLEASE SET ITEM  AND QTY FIRST !");
                } else{
                        
                        $.ajax({
                             url: 'chequeQtyServlet',
                             data: {
                                 itemid: ItemID,
                                    qty: qty,
                                    branch:bran

                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                                var d=data.split("-");
                                data=d['0'];
                                var ava=d['1'];
                                if (data === "1") {
                                    
                                                
                                                $.ajax({
                                                    url: 'SetReturnServletR1',
                                                    data: {
                                                        itemid: ItemID,
                                                        qty: qty,
                                                        branch:bran

                                                    },
                                                    type: 'post',
                                                    cache: false,
                                                    success: function (data) {
                                                        if (data === "1") {
                                                            location.reload();
                                                        } else if (data === "0") {

                                                            swal("PLEASE SELECT DATA FIRST !");
                                                        }



                                                        },
                                                    error: function () {
                                                            swal("TRY AGAIN !");
                                                    }
                                                });
                                    
                                    
                                } else if (data === "0") {

                                   swal("PLEASE SELECT DATA AND TRY AGAIN !");
                                }
                                else if (data === "2") {
                                    swal("AVAILABLE QTY NOT ENOUGH !AVAILABLE :"+ava);
                                    
                                }else if (data === "3") {
                                    swal("STOCK NOT FOUNT !");
                                    
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
                    url: 'RemoveReturnServletR1',
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
                });
            });
            var grand =<%=grandtotal%>
            
            

            
            $("#save_dev").click(function () {
                save();
            
            });
           
           
           
           function save(){
               
               

            $.ajax({
            url: 'SaveRservlet',
                    data: {
                            desc: 1,
                            

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    
                        if (data === "1") {
                            swal({
                                title: "STOCK (S) RETURNED!",
                                text: "please use List - return to view  and print details !",
                                icon: "success",
                                button: "OK"
                            }).then((value) => {
                                
                                   location.reload();
                                
                          });
                          
                        } else if(data === "0") {
                            swal({
                                title: "Empty return Data!",
                                text: "can't get return data. please retry !",
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
            });
               
           }
           
        



        </script>


    </body>
</html>