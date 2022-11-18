<%@page import="java.text.DecimalFormat"%>
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
                    Session Hses=connection.getConnection.getSessionFactory().openSession();
                    String ID="";
                    int IN=0;
                    int AC=0;
                    if (request.getParameter("q") != null && !request.getParameter("q").equals("")) {
                        ID=request.getParameter("q");
                    }

                %>
                
                
            <div class="row mt-3">
                <h5>Return Invoice</h5>
            </div>

            <div class="row mt-1">
                <form action="setReturnInvoice" method="get">
                <div class="input-group input-group-append">
                    <div class="row mr-2">
                        <div class="input-group col-sm-8">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height: 35px;" id="inputGroup-sizing-default">INVOICE NO</span>
                            </div>
                            <input class="form-control" style="height: 35px;" id="q" name="q" value="<%=ID%>">
                        </div>
                        <input class="btn btn-info col-sm-2 " type="submit"  value="FIND"> 
                    </div>
                    
                    
                                
                    
                </div>
                    </form>
            </div>
                            
            <%
                
                if (request.getSession().getAttribute("invoiceReturn") != null && request.getParameter("q") != null && !request.getParameter("q").equals("")) {
                
                SaleInvoice SI= (SaleInvoice) Hses.load(SaleInvoice.class, Integer.parseInt(ID));
            %>
            <div class="row mt-2">
                <div class="card col-md-12">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-6">
                                <h6>Invoice ID:<span id="F"><%= SI.getIdsaleInvoice() %></span></h6>    
                                <h6>Customer: <%= SI.getAccount().getName() %></h6>    
                                <h6>Invoice Total: RS <%= df.format(SI.getNetTotal() ) %></h6>    
                                <h6>Invoice Discount: RS <%= df.format(SI.getDescount()) %></h6>    
                                <h6>Invoice Net Total: RS <%= df.format(SI.getTotal()) %></h6>    
                                <h6>Transport: RS <%= df.format(SI.getTransport()) %></h6>    
                                <h6>Date: <%= SI.getDate()+"  "+SI.getTime() %></h6>    
                                   


                            </div>
                            <div class="col-md-6">
                                   

                            </div>
                        </div>


                    </div>
                </div>
            </div>


            <%
                }
            %>
                                
            
            
            <div class="row mt-3">
                <table class="table table-sm  table-bordered" >
                    <thead>
                        <tr>
                            <th style="background-color:#10ac84 !important; color: white !important; ">ID</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">ITEM</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">QTY</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">ALREADY RETURNED</th>
                            
                            <th style="background-color:#10ac84 !important; color: white !important; ">TYPE</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">PRICE</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">ITEM DESC.</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">INVOICE DESC.</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">NET TOTAL</th>
                            <th style="background-color:#10ac84 !important; color: white !important; "></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                            
                            ArrayList<invoiceReturnModel> invoice = new ArrayList();
                            if (request.getSession().getAttribute("invoiceReturn") != null) {
                                invoice = (ArrayList<invoiceReturnModel>) request.getSession().getAttribute("invoiceReturn");
                                BigDecimal tot = new BigDecimal(0);
                                int i = 0;
                                for (invoiceReturnModel IM : invoice) {
                                    if(IM.getQty() > 0 ){
                                        BigDecimal now = new BigDecimal(IM.getNet_total());
                                        tot = now.add(tot);
                                    }
                                    


                        %>

                        <tr>
                            <td><%=IM.getId() %></td>
                            <td><%=IM.getItem() %></td>
                            <td><input type="number" name="up_qtt"  value="<%=df.format(IM.getQty()) %>"><button type="button" class="btn_up_qtt" >update</button></td>
                            <td><%= df.format(IM.getAlredy_return()) %></td>
                            <td><%= IM.getNow_type()%></td>
                            <td><%=df.format(IM.getPrice()) + " LKR"%></td>
                            <td><%=df.format(IM.getDescount()) + " LKR"%></td>
                            <td><%=df.format(IM.getDescount_from_total() ) + " LKR"%></td>
                            <td><%=df.format(IM.getNet_total())+ " LKR"%></td>
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
                        <div class="input-group mt-2">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">REMARKS:</span>
                            </div>
                            <input type="text" class="form-control" name="re" id="re" >
                            
                        </div>
                    </div>
                     
                    <div class="btn-group mb-3 mt-2" role="group" aria-label="Basic example">
                                    
                        <button type="button" class="btn btn-sm btn-success" id="save_dev"><span class="fa fa-save mr-2"></span>PROCEED</button>
                        <button type="button" class="btn btn-sm btn-danger" id="clr"><span class="fa fa-trash mr-2"></span>CLEAR</button>
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
            
            $("#clr").click(function () {

                        $.ajax({
                            url: 'clearReturnIn',
                            data: {
                            type: 1

                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                                if (data === "1") {

                                    
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



            $('.btn_up_qtt').click(function (e) {
                    
                    var hash = $(this).closest('tr').find('.remove').val();
                    var qtt=$(this).closest('tr').find('input[name=up_qtt]').val();
                    if(qtt=='' || qtt == 0|| qtt < 0){
                        
                        swal("please enter valid qty !");
                    }else{
                        $.ajax({
                            url: 'UpdateQttInvoiceReturnServlet',
                            data: {
                            hash:hash,
                            qty:qtt


                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {

                            if (data === "1") {
                                location.reload();
                            } else if (data === "0") {

                                swal("PLEASE SELECT DATA FIRST !");
                            }else if (data === "2") {

                                swal("RETURN AMOUNT > INVOICE AMOUNT !");
                            }


                            },
                            error: function () {
                                swal("TRY AGAIN !");
                            }
                    });
                        
                    }
                    
                    
            });
            
            $('.remove').click(function (e) {

                    var hash = $(this).closest('tr').find('.remove').val();
                    $.ajax({
                    url: 'RemoveInvoiceReturnServlet',
                            data: {
                            hash:hash


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
            });
            
            
            $("#save_dev").click(function () {
                
                    save();
            });
            
           
           
           
           
           
           
           
           
           function save(){
               
                    var aco="";
                    var invo="";
                    var rtt=$('#re').val();
                    if(rtt== ''){
                        rtt="N/A";
                    }
                    

                             $.ajax({
                             url: 'saveReturnInvoiceServlet',
                                     data: {
                                     ac: aco,
                                     inv: invo,
                                     r:rtt
                                     },
                                     type: 'post',
                                     cache: false,
                                     success: function (data) {
                                        var d=data.split("-");
                                        data=d['0'];
                                        var id=d['1'];
                                        if (data === "1") {
                                            swal({
                                                            title: "STATEMENT SAVED!",
                                                            text: "return statement savevd !",
                                                            icon: "success",
                                                            button: "OK"
                                                            }).then((value) => {
                                                                location.reload();
                                                            });

                                        } else if(data === "0") {
                                              swal({
                                                title: "Empty  Data!",
                                                text: "can't get statement data. please retry !",
                                                icon: "error",
                                                button: "OK"
                                            }).then((value) => {
                                                location.reload();
                                            });
                                        }
                                        else if(data === "3") {
                                              swal({
                                                title: "Empty !",
                                                text: "there is no qty to return !",
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