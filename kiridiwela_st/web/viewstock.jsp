<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.StockPrice"%>
<%@page import="resources.CustomerType"%>
<%@page import="dataclass.stockPriceModel"%>
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
            DecimalFormat df = new DecimalFormat("##########0.00");
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
        <%

                    helper h = new helper();
                    String date = h.getDate();

                    Session Hses = connection.getConnection.getSessionFactory().openSession();
                    String ID = "";
                    String I_ID = "";
                    if (request.getParameter("q") != null && !request.getParameter("q").equals("")) {
                        ID = request.getParameter("q");
                        Stock I = (Stock) Hses.load(Stock.class,Integer.parseInt(ID) );
                        I_ID = I.getItems().getItemId().toString();
                                
                    }

        %>


        <main role="main" class="container"  >
            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item" style="font-size: 16px;" ><span class="fa fa-arrow-left ml-2 mr-2"></span><a href="stocks.jsp?b=0&a=<%=I_ID  %>">Go Back</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">Stock Price Details</li>
                   </ol>
                </nav>
            </div>
            <div class="container-fluid" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); padding: 25px 25px 25px 25px;border-radius: 8px;">
                


             
                <div class="row mt-1 d-none">
                    <form action="viewstock.jsp" method="get">
                        <div class="input-group input-group-append">
                            <div class="mr-2">
                                <div class="input-group ">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:130px;height: 35px;" id="inputGroup-sizing-default">STOCK ID</span>
                                    </div>
                                    <input class="form-control" style="width:200px ;height: 35px;" id="q" name="q" value="<%=ID%>">
                                    <input class="btn btn-info mt-2 btn-sm" type="submit"  value="FIND STOCK"> 

                                </div>
                            </div>




                        </div>
                    </form>
                </div>

                <%

                    if (request.getParameter("q") != null && !request.getParameter("q").equals("")) {
                        Stock SI = (Stock) Hses.load(Stock.class, Integer.parseInt(ID));
                        ArrayList<stockPriceModel> invoicep = new ArrayList();
                        ArrayList<stockPriceModel> invoiceb = new ArrayList();
                        if (request.getSession().getAttribute("viewStock") != null) {

                            request.getSession().removeAttribute("viewStock");

                        }

                        Criteria cr = Hses.createCriteria(CustomerType.class);
                        cr.add(Restrictions.eq("status", 1));
                        List<CustomerType> CU = cr.list();
                        Set<StockPrice> SP = SI.getStockPrices();

                        if (SP.isEmpty()) {
                            for (CustomerType CT : CU) {
                                stockPriceModel SPM = new stockPriceModel();
                                SPM.setCustomerType(CT.getName());
                                SPM.setCustomerTypeid(CT.getCustomerTypeId());
                                SPM.setStockId(SI.getStockId());
                                SPM.setPrice(0.0);
                                invoicep.add(SPM);
                            }
                        } else {

                            for (StockPrice sp : SP) {

                                stockPriceModel SPM = new stockPriceModel();
                                SPM.setCustomerType(sp.getCustomerType().getName());
                                SPM.setCustomerTypeid(sp.getCustomerType().getCustomerTypeId());
                                SPM.setStockId(sp.getStock().getStockId());
                                SPM.setPrice(sp.getPrice());
                                invoicep.add(SPM);

                            }

                            for (CustomerType CT : CU) {
                                int a = 0;
                                stockPriceModel ss=null; 
                                System.out.print(invoicep.size());
                                for (stockPriceModel spm : invoicep) {
                                    if (spm.getCustomerTypeid() == CT.getCustomerTypeId()) {
                                        a = 1;
                                        ss=spm;
                                    }

                                }
                                if (a == 0) {
                                    stockPriceModel SPM = new stockPriceModel();
                                    SPM.setCustomerType(CT.getName());
                                    SPM.setCustomerTypeid(CT.getCustomerTypeId());
                                    SPM.setStockId(SI.getStockId());
                                    SPM.setPrice(0.0);
                                    invoiceb.add(SPM);
                                } else {
                                    invoiceb.add(ss);
                                }

                            }

                        }
                        if (invoiceb.isEmpty()) {
                            request.getSession().setAttribute("viewStock", invoicep);
                        } else {
                            request.getSession().setAttribute("viewStock", invoiceb);
                        }


                %>
                <div class="row mt-2">
                    <div class="card col-md-12" >
                        <div class="card-body">

                            <div class="row">
                                <div class="col-md-4">
                                    <h6>Stock ID:<span id="F"><%= SI.getStockId()%></span></h6> 
                                    <input type="hidden" name="st_id_top"  value="<%=SI.getStockId()%>">
                                    <h6>Stock Branch:<span id="F"><%= SI.getBranch().getName() %></span></h6>    
                                    <h6>Barcode ID:<span id="F"><%= SI.getItems().getBarcodeId() %></span></h6>    
                                    <h6>Item:<span id="F"><%= SI.getItems().getName() %></span></h6>    
                                    <h6>Supplier: <%= SI.getItems().getAccount().getName()%></h6>    
                                    <h6>Available QTY: <%= SI.getQty() + " (" + SI.getItems().getType().getName() + ")"%> </h6>    
                                    <h6>Date: <%= SI.getDate()%></h6>    
                                    

                                </div>
                                <div class="col-md-4">
                                    <h6>Cost:<input type="number" name="cost_c"  id="cost_c" value="<%=df.format(SI.getCost()) %>" class="form-control col-md-5"><button id="cost_b" class="btn btn-danger mt-1 btn-sm" >UPDATE</button></h6>    
                                    <p>Note : it only change current Cost price only. ledger account details can not be edit.</p>

                                </div>
                                <div class="col-md-4">
                                    <h6>Selling Price: <input id="sell_c" name="sell_c" type="number" value="<%=df.format(SI.getPrice()) %>" class="form-control col-md-5"><button  id="sell_b" class="btn btn-danger mt-1 btn-sm" >UPDATE</button> </h6>    
                                    <p>Note : it only change current Selling price only. ledger account details can not be edit.</p>

                                </div>
                            </div>


                        </div>
                    </div>
                </div>


                <%
                    }
                %>



                <div class="row mt-2">
                    <table class="table table-sm  table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Customer Type</th>
                                <th>Price</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ArrayList<stockPriceModel> invoice = new ArrayList();
                                if (request.getSession().getAttribute("viewStock") != null) {
                                    invoice = (ArrayList<stockPriceModel>) request.getSession().getAttribute("viewStock");

                                    for (stockPriceModel IM : invoice) {


                            %>

                            <tr>
                                <td><%=IM.getCustomerType()%></td>
                                <td>
                                    <div class="form-inline">
                                        <input type="number" name="up_qtt" class=" col-md-2 form-control"  value="<%= df.format(IM.getPrice()) %>"><button type="button" class="btn_up_qtt btn btn-warning" >CHANGE</button>
                                     
                                    </div>
                                    <input type="hidden" name="st_id"  value="<%=IM.getStockId()%>">
                                    <input type="hidden" name="ct_id"  value="<%=IM.getCustomerTypeid()%>">
                                </td>
                            </tr>

                            <%
                                    }

                                }
                            %>
                        </tbody>
                    </table>
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


            function reload() {
                location.reload();
            }
            $('#sell_b').click(function (e) {
                
                var price = $('input[name=sell_c]').val();
                var st_id = $('input[name=st_id_top]').val();
                if (price == '' | price == 0 | price < 0) {
                    swal("please enter valid Price !");
                } else {
               
                swal({
                    title: "Are you sure?",
                    text: "do you want to change price on this stock ? ",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then((willDelete) =>{
                
                
                    if (willDelete){
                        
                        $.ajax({
                            url: 'updateStockPriceServlet',
                            data: {
                            id: st_id,
                            cost: price
                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                                
                                if (data === "1") {

                                    swal({
                                        title: "Good job!",
                                        text: "you updated price for selected stock !",
                                        icon: "success",
                                        button: "OK"
                                    }).then((value) =>{

                                        location.reload();
                    
                                    });
                                } else if (data === "0") {
                                    swal({
                                        title: "Empty Field Data !",
                                        text: "Can't let any field id empty.",
                                        icon: "error",
                                        button: "OK"
                                    });
                                }
                    else if (data === "3") {
                    swal({
                    title: "Wrong Price !",
                            text: "Please enter valid price amount;",
                            icon: "error",
                            button: "OK"
                    });
                    }
                    else if (data === "4") {
                             swal({
                    title: "Too Small !",
                            text: "Please enter high price amount than cost.",
                            icon: "error",
                            button: "OK"
                    });
                    }
                    },
                    error: function () {
                    swal({
                    title: "Something Went Wrong !",
                            text: "something wrong in processing data please retry.",
                            icon: "error",
                            button: "OK"
                    });
                    }
            });
            } else {
                    swal({
                        title: "Cancelled !",
                    text: "you cancelled updating process.",
                    icon: "error",
                    button: "OK"
                    });
            }
            });
            
                }
            });
            $('#cost_b').click(function (e) {
                
                var price = $('input[name=cost_c]').val();
                var st_id = $('input[name=st_id_top]').val();
                if (price == '' | price == 0 | price < 0) {
                    swal("please enter valid Price !");
                } else {
               
                swal({
                    title: "Are you sure?",
                    text: "do you want to change cost on this stock ? ",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then((willDelete) =>{
                
                
                    if (willDelete){
                        
                        $.ajax({
                            url: 'updateStockCostServlet',
                            data: {
                            id: st_id,
                            cost: price
                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                                
                                if (data === "1") {

                                    swal({
                                        title: "Good job!",
                                        text: "you updated Cost for selected stock !",
                                        icon: "success",
                                        button: "OK"
                                    }).then((value) =>{

                                        location.reload();
                    
                                    });
                                } else if (data === "0") {
                                    swal({
                                        title: "Empty Field Data !",
                                        text: "Can't let any field id empty.",
                                        icon: "error",
                                        button: "OK"
                                    });
                                }
                    else if (data === "3") {
                    swal({
                    title: "Wrong Price !",
                            text: "Please enter valid cost amount;",
                            icon: "error",
                            button: "OK"
                    });
                    }
                    else if (data === "4") {
                             swal({
                    title: "Too high !",
                            text: "Please enter small cost amount than selling.",
                            icon: "error",
                            button: "OK"
                    });
                    }
                    },
                    error: function () {
                    swal({
                    title: "Something Went Wrong !",
                            text: "something wrong in processing data please retry.",
                            icon: "error",
                            button: "OK"
                    });
                    }
            });
            } else {
                    swal({
                        title: "Cancelled !",
                    text: "you cancelled updating process.",
                    icon: "error",
                    button: "OK"
                    });
            }
            });
            
                }
            });
            

            $('.btn_up_qtt').click(function (e) {

                var stockid = $(this).closest('tr').find('input[name=st_id]').val();
                var customerid = $(this).closest('tr').find('input[name=ct_id]').val();
                var price = $(this).closest('tr').find('input[name=up_qtt]').val();


                if (price === '' || price === 0 || price < 0) {

                    swal("please enter valid Price !");
                } else {

                    $.ajax({
                        url: 'updateStockPriceServet',
                        data: {
                            st: stockid,
                            cu: customerid,
                            price: price


                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {

                            if (data === "1") {
                                location.reload();
                            } else if (data === "0") {

                                swal("PLEASE SELECT DATA FIRST !");
                            } else if (data === "2") {

                                swal("COST > SELLING PRICE");
                            } else if (data === "3") {

                                swal("YOU NOT HAVE ACCESS !");
                            }


                        },
                        error: function () {
                            swal("TRY AGAIN !");
                        }
                    });

                }


            });








        </script>


    </body>
</html>