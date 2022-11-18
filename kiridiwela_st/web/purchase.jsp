<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.PoOrderItems"%>
<%@page import="java.util.Set"%>
<%@page import="resources.ChequeBook"%>
<%@page import="resources.TextList"%>
<%@page import="resources.PurchaseInvoiceOrder"%>
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
            <div class="container-fluid mt-5" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); padding: 25px 25px 25px 25px;border-radius: 5px;">
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
                    String F = "0";
                    PurchaseInvoiceOrder PO=null;

                    if (request.getSession().getAttribute("p1") != null) {
                        String[] AA = (String[]) request.getSession().getAttribute("p1");
                        A = AA[0];
                        B = AA[1];
                        C = AA[2];
                        D = AA[3];
                        E = AA[4];
                        F = AA[5];
                        PO=(PurchaseInvoiceOrder) ses.load(PurchaseInvoiceOrder.class, Integer.parseInt(F));
                        ISP1 = 1;
                    }

                    double grandtotal = 0.0;
                    DecimalFormat df = new DecimalFormat("##########0.00");

                %>
            <div class="row mt-3">
                <h5>Receive Purchase Order Items</h5>
            </div>
            
            <div class="row mt-1">
                <div class="input-group-append">
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:100px;height:35px;" id="inputGroup-sizing-default">SUPPLIER</span>
                            </div>
                            <select class="form-control sp" style="width:286px; height:35px;"  name="supplier" id="supplier" >
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
                <div class="mr-2">
                        <div class="input-group ">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:110px;height: 35px;" id="inputGroup-sizing-default">PO NO:</span>
                            </div>
                            <select class="form-control"  style="width:265px; height:35px;"  name="po_number" id="po_number" >
                                <option value="0">SELECT SUPPLIER FIRST</option>
                                
                            </select>
                                
                        </div>
                </div>
                <div class="input-group-append">
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:100px; height: 35px;" id="inputGroup-sizing-default">PAY TYPE</span>
                            </div>
                            <select class="form-control" style="width:160px;height: 35px;" name="paytype" id="paytype">
                                 <option value="0">PLEASE SELECT</option>
                                <%                                    
                                    Session ses5 = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr3 = ses5.createCriteria(PaymentType.class);
                                    cr3.add(Restrictions.eq("status", 1));
                                    List<PaymentType> d = cr3.list();
                                    if (d.size() > 0) {
                                        for (PaymentType B2 : d) {
                                            
                                        
                                %>
                                <option value="<%=B2.getIdpaymentType()%>"><%=B2.getName()%></option>
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
            <% if(ISP1 == 1 && PO != null){ %>
            <div class="row mt-2" style="border: #636e72 1px solid; padding: 5px 5px 5px 5px;">
                <table>
                    <tr>
                        <td>PO NUMBER:</td>
                        <td><%=PO.getIdpurchaseInvoiceOrder() %></td>
                        <td>&nbsp;&nbsp;</td>
                        <td>Supplier:</td>
                        <td><%=PO.getAccount().getName() %></td>
                        <td>&nbsp;&nbsp;</td>
                        <td>Branch:</td>
                        <td><%=PO.getBranch().getName() %></td>
                    </tr>
                    <tr>
                        <td>PO Date:</td>
                        <td><%=PO.getPoDate() %></td>
                        <td>&nbsp;&nbsp;</td>
                        <td>Remarks:</td>
                        <td><%=PO.getRemarks() %></td>
                        <td>&nbsp;&nbsp;</td>
                        <td><button class="btn btn-sm btn-info" id="v_po" >view</button></td>
                    </tr>
                </table>
            </div>
            <% } %>
            <div class="row mt-1">
               
            </div>
            <div class="row mt-1">
                <div class="input-group input-group-append">
                    <div class="mr-2">
                        <div class="input-group ">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:100px;height: 35px;" id="inputGroup-sizing-default">ITEM</span>
                            </div>
                            <input class="form-control" type="text" style="width:286px;height: 35px;" id="item" name="item">
                                
                        </div>
                    </div>
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:110px;height: 35px;" id="inputGroup-sizing-default">QUANTITY</span>
                            </div>
                            <input type="number" class="form-control" style="width:100px;height: 35px;" name="qty" id="qty">
                            
                        </div>
                    </div>
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:60px;height: 35px;" id="inputGroup-sizing-default">COST</span>
                            </div>
                            <input type="number" class="form-control" style="width:100px;height: 35px;" name="co" id="co">
                            
                        </div>
                    </div>
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:70px;height: 35px;" id="inputGroup-sizing-default">PRICE</span>
                            </div>
                            <input type="number" class="form-control" style="width:100px;height: 35px;" name="pr" id="pr">
                            
                        </div>
                    </div>
                    
                    <div class="mr-2">
                        <button class="btn  btn-info add " id="add" style="height:35px !important;">ADD TO LIST</button>
                    </div>
                </div>
            </div>
            <div class="row mt-2">
                <table class="table table-sm table-light table-bordered" id="">
                    <thead>
                        <tr>
                            <th style="background-color:#10ac84 !important; color: white !important; ">ITEM ID</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">ITEM</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">QTY</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">COST</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">NET TOTAL</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">SELLING PRICE</th>
                            <th style="background-color:#10ac84 !important; color: white !important; "></th>
                        </tr>
                    </thead>
                    <tbody>
                                            <%
                                                ArrayList<itemModel> invoice = new ArrayList();
                                                if (request.getSession().getAttribute("invp") != null) {
                                                    invoice = (ArrayList<itemModel>) request.getSession().getAttribute("invp");
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
                                                <td><%=df.format(IM.getPrice()) + " LKR"%></td>
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
                    <div class="col-sm-4 mt-1">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">DISCOUNT RS:</span>
                            </div>
                            <input type="number" class="form-control"  name="desct" id="desct">
                            
                        </div>
                    </div>
                    <div class="col-sm-4 mt-1">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"  style="width:130px;" id="inputGroup-sizing-default">RETURN RS:</span>
                            </div>
                            <select class="form-control"  id="return" name="return">
                                <option>NO DATA FOUND</option>
                            </select>
                            
                        </div>
                    </div>
                    <div class="col-sm-4 mt-1">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">NET TOTAL RS:</span>
                            </div>
                            <input type="number" class="form-control"  disabled="" name="nettotal" id="nettotal" >
                            
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

        
        
        <!-- Modal update -->
        <div class="modal fade" id="v_po2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog  modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">PO ITEMS</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row">
                            <div class="col-md-12">
                                 <table class="table table-bordered table-sm">
                                    <tr>
                                        <th>Item</th>
                                        <th>Qty Ordered</th>
                                        <th>Qty Received</th>
                                        <th>Qty Receivable</th>
                                    </tr>
                                    <% if(ISP1 == 1 && PO != null){ 
                                        Set<PoOrderItems> POITEM=PO.getPoOrderItemses();
                                        for(PoOrderItems PI : POITEM){
                                    %>
                                    <tr>
                                    <td><%= PI.getItems().getName() %></td>
                                    <td><%= df.format(PI.getQty())   +"  "+PI.getItems().getType().getName() %></td>
                                    <td><%= df.format(PI.getQtyRecived())  +"  "+PI.getItems().getType().getName() %></td>
                                    <td><%= df.format((PI.getQty() - PI.getQtyRecived()))  +"  "+PI.getItems().getType().getName() %></td>
                                    </tr>
                                    
                                    
                                    <% }} %>
                                </table>
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
                                                    <input type="number" class="form-control" style="width:320px;" name="cheque_amount" id="cheque_amount" onload="" >
                                                </div>
                                            </div>


                                        </div>
                                        <div class="input-group-append mt-1">
                                            <div class="mr-2">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" style="width:150px;" id="inputGroup-sizing-default">Cheque Number:</span>
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
                                                Session st_tx2=connection.getConnection.getSessionFactory().openSession();
                                                Criteria cr2=st_tx2.createCriteria(TextList.class);
                                                List<TextList> TL2=cr2.list();
                                                for(TextList tl : TL2){
                                                %>
                                            <option value="<%= tl.getTest() %>" >
                                            
                                                <% } st_tx2.close(); %>
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
                                        'getItemJsonServlet',
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
            
            $('#v_po').click(function (){
                $("#v_po2").modal();
                
            });
            $('#v_po2').on('hidden.bs.modal', function (e) {
                if(i==0){
                   $("#item").focus(); 
                }else{
                    $("#mess").focus();
                }
                
            });
            
            $('#myModal12').on('hidden.bs.modal', function (e) {
                if(i==0){
                   $("#item").focus(); 
                }else{
                    $("#mess").focus();
                }
                
            });
            $('#myModal12').on('shown.bs.modal', function (e) {
                $(".typeahead").val("");
                $(".typeahead").focus();
            });
            
            function closeModel(){
                $('#myModal12').modal('hide');
                i=1;
            }
            
            
            
            
            
            var supid = 0;
            var pay = 0;
            var date = "";
            var user = 0;
            var bran=0;
            var po=0;
            var P1 =<%=ISP1%>;
            
            
            $('#paytype').off();
            $('#supplier').focus();
            
            $('#supplier').change(function (){
                supid= $('#supplier').find(":selected").val();
                getPoList();
                getSuppList();
                
            });
            
            if (P1 === 1) {
               
                supid =<%=D%>;
                pay =<%=A%>;
                date =<%=B%>;
                user =<%=C%>;
                bran =<%=E%>;
                po =<%=F%>;
                getSuppList();
                getPoList();
                document.getElementById("paytype").value = "" + pay;
                document.getElementById("supplier").value = "" + supid;
                document.getElementById("po_number").val = ""+po;
                $("#po_number").prop("disabled", true);
                //$("#paytype").prop("disabled", true);
                $("#supplier").prop("disabled", true);
                $('#item').focus();
                
                
            }
            
            function getPoList() {
               
                var dataString = 'p2=' + supid;
                
                
                $.ajax({
                    url: 'getPoListServlet',
                    dataType: "json",
                    data: dataString,
                    cache: false,
                    success: function (player) {
                        let dropdown = $('#po_number');
                        dropdown.empty();
                        if (player.length === 0) {

                            $("#po_number").append("<option>NO PO FOUND</option>");
                        } else {
                            $("#po_number").append("<option value=" + 0 + ">PLEASE SELECT</option>");
                            $.each(player, function (key, value) {
                            $("#po_number").append("<option value=" + value.id + " >" + value.name + "</option>");
                            });
                    }


                    }
                });
                $('#po_number').focus();
            }
            
            function getSuppList() {
                    
                    var dataString = 'p2=' + supid;
                
                
                    $.ajax({
                            url: 'getReturnServlet',
                            dataType: "json",
                            data: dataString,
                            cache: false,
                            success: function (player) {
                                let dropdown = $('#return');
                                dropdown.empty();
                                if (player.length === 0) {

                                    $("#return").append("<option>NO ITEM FOUND</option>");
                                } else {
                                    $("#return").append("<option value=" + 0 + ">Please select Return</option>");
                                    $.each(player, function (key, value) {
                                    $("#return").append("<option value=" + value.id + " >" + value.name + "</option>");
                                    });
                            }


                            }
                    });
            }

            $("#paytype").change(function () {
                pay = $('#paytype').find(":selected").val();
                po = po;
                
                date =<%=date%>;
                user =<%=adminId%>;
            if (po > 0 && pay > 0 ) {

            $.ajax({
            url: 'P1Servlet',
                    data: {
                            type: pay,
                            date: date,
                            user: user,
                            po: po
                            

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {
                        location.reload();
                    } else if (data === "0") {

                        alert("");
                    }else if (data === "2") {

                        alert("2");
                    }



                    },
                    error: function () {
                        alert("error");
                    }
            });
            }
        });
            $("#po_number").change(function () {
                pay = 1;
                po = $('#po_number').find(":selected").val();
                
                date =<%=date%>;
                user =<%=adminId%>;
            if (po > 0 && pay > 0 ) {

            $.ajax({
            url: 'P1Servlet',
                    data: {
                            type: pay,
                            date: date,
                            user: user,
                            po: po
                            

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {
                        location.reload();
                    } else if (data === "0") {

                        alert("");
                    }else if (data === "2") {

                        alert("2");
                    }



                    },
                    error: function () {
                        alert("error");
                    }
            });
            }
        });
            
            $("#clr").click(function () {

            $.ajax({
            url: 'P1Clear',
                    data: {
                    type: pay

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {

                    $("#supplier").prop("disabled", false);
                    $("#paytype").prop("disabled", false);
                    $("#po_number").prop("disabled", false);
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
            var DesC = 0;
            
            
            
            
            $('#qty').keypress(function (e) {
                
                if (e.which === 13) {
                    
                
                    if (ItemID == 0){

                            swal("PLEASE SELECT ITEM FIRST !");
                    } else{

                             $('#co').focus();
                    }
                }
            });
            
            $('#co').keypress(function (e) {
                
                if (e.which === 13) {
                    
                
                    if (ItemID == 0){

                            swal("PLEASE SELECT ITEM FIRST !");
                    } else{

                            $('#pr').focus();
                    }
                }
            });
            
            $('#pr').keypress(function (e) {
                
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
                var co = $('#co').val();
                var pr = $('#pr').val();
                
                if (qty == ''){
                    qty = 0;
                }
                if (pr == ''){
                    pr = 0;
                }
                if (co == ''){
                    co = 0;
                }
            if (supid == 0 || pay == 0 || date == '' || user == 0 ){
                swal("PLEASE SET SUPPLIER DATE USER PAYMENT TYPE FIRST !");
                $('#item').focus();
            } else{
            if (ItemID == 0 || qty == 0 || pr==0 || co == 0){

                swal("PLEASE SET ITEM DISCOUNT AND QTY FIRST !");
                $('#item').focus();
            } else{
                
                        if(parseFloat(pr) > parseFloat(co) ){
                            $.ajax({
                                url: 'SetInvoiceServletP1',
                                data: {
                                        itemid: ItemID,
                                        qty: qty,
                                        pr:pr,
                                        co:co,
                                        po:po
                                },
                                type: 'post',
                                cache: false,
                                success: function (data) {
                                if (data === "1") {
                                reload();
                                } else if (data === "0") {
                                   swal("PLEASE SELECT DATA FIRST !").then(function (){
                                       $('#item').focus();
                                   });
                                }
                                else if (data === "8") {
                                   swal("SELCTED ITEM IS NOT FOUND IN PO !").then(function (){
                                       $('#item').focus();
                                   });
                                }



                                },
                                error: function () {
                                     swal("TRY AGAIN !");
                                     $('#item').focus();
                                }
                        });
                            
                        }else{
                            swal("PRICE VALUE INCORECT !").then(function (){
                                
                                $('#co').focus();
                            });
                            
                            
                            
                        }

                        
            }

            }

            }
            
            

            $('.remove').click(function (e) {

            var hash = $(this).closest('tr').find('.remove').val();
            $.ajax({
            url: 'RemoveInvoiceServletP1',
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
            var grand =<%=grandtotal%>
            var des_grand = $('#desct').val();
            var de = des_grand;
            var rett = 0;
            var grand_tot = 0;
            onGoDown();
            
            function onGoDown(){

            grand =<%=grandtotal%>
            des_grand = $('#desct').val();
            de = des_grand;
            rett = 0;
            grand_tot = 0;
            if (des_grand == ''){

            des_grand = 0;
            }
            des_grand = (grand / 100) * des_grand;
            grand_tot = (grand - des_grand);
            $('#nettotal').val(grand_tot);
            }



            $('#desct').keyup(function (e) {
            des_grand = $('#desct').val();
            de = des_grand;
            des_grand = (grand / 100) * des_grand;
            grand_tot = (grand - des_grand);
            $('#nettotal').val(grand_tot);
            checkReturn();
            });
            function checkReturn(){
                
            onGoDown();

            var retid = $('#return').find(":selected").val();
            rett = retid;
            if (retid != 0){
                
                

            $.ajax({
            url: 'getReturnAmount',
                    data: {
                    p2:retid


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {

                    if (data != ''){
                    var iNum = parseFloat(data);
                    var iNum2 = $('#nettotal').val();
                    grand_tot2 = (iNum2 - iNum);
                    $('#nettotal').val(grand_tot2);
                    }


                    },
                    error: function () {

                    }
            }
            );
            }
            }

            $("#return").change(function () {
                checkReturn();
            });
            
            
            $('#myModal4').on('shown.bs.modal', function () {
                    
                    $('#cheque_amount').val($('#nettotal').val());
                     $('#cheque_amount').focus();
            }); 
            
            var cheque_amount=0;
            var transport_cheque=0;
            
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
                   $('#cheque_b').focus();
                   
                }
            });
            
            
            
            
            
             function saveCheque(){
                    var p = $('#nettotal').val();
                    
                    cheque_amount=$('#cheque_amount').val();
                    de=$('#desct').val();
                    
                    grand_tot=p;
                    if(de==''){
                      de=0;
                    }
                    if(transport_cheque==''){
                       transport_cheque=0;
                    }
                    
                    if(cheque_amount==''){
                       cheque_amount=0;
                    }
                    
                    if(rett==''){
                      rett=0;
                    }
                    
                    if(parseFloat(grand_tot) > parseFloat(cheque_amount)){
                        
                                        swal({
                                                title: "Payment Not Enough !",
                                                text: "you anterd amount is low. want to add res for credit ? ",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                if(willDelete){
                                                    cheque_amount=$('#cheque_amount').val();
                                                      savchequeChecked(de,rett,transport_cheque,cheque_amount);
                                                }else{
                                                        
                                                        $('#cheque_amount').focus();
                                                }
                                            });
                                            
                        
                    }
                    if(parseFloat(grand_tot) < parseFloat(cheque_amount)){
                        
                                   swal({
                                                title: "Payment Is High !",
                                                text: "you anterd amount is High. want to add res for account ? ",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                if(willDelete){
                                                    cheque_amount=$('#cheque_amount').val();
                                                      savchequeChecked(de,rett,transport_cheque,cheque_amount);
                                                }else{
                                                        
                                                        $('#cheque_amount').focus();
                                                }
                                            });        
                        
                    }
                    if( parseFloat(grand_tot) == parseFloat(cheque_amount)){
                        cheque_amount=$('#cheque_amount').val();
                        savchequeChecked(de,rett,transport_cheque,cheque_amount);
                        
                    }
                
            }
            
             function savchequeChecked(de,rett,transport_cheque,cheque_amount){
                    if(de==''){
                        de=0;
                    }
                    if(rett==''){
                        rett=0;
                    }
                    var d=$('#cheque_date').val();
                   $.ajax({
                             url: 'savePChequeServlet',
                                     data: {
                                     payment:cheque_amount,
                                     number:$('#cheque_number').val(),
                                     date:d,
                                     branch:$('#cheque_branch').val(),
                                     bank:$('#bank').find(":selected").val(),
                                     re:$('#remark').val(),
                                     desc: de,
                                     ret: rett,
                                     po:po
                                     

                                     },
                                     type: 'post',
                                     cache: false,
                                     success: function (data) {
                                        var d=data.split("-");
                                        data=d['0'];
                                        var id=d['1'];
                                        if (data === "1") {
                                            swal({
                                                            title: "RECIPT SAVED!",
                                                            text: "recipt saved as Cheque recipt !",
                                                            icon: "success",
                                                            button: "OK"
                                                            }).then((value) => {
                                                                location.reload();
                                                            })
                                                             
                                                

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
            
            $("#save_dev").click(function () {
              
                if(pay==1){
                    
                   save();
                    
                }else if(pay==2){
                    
                    savecash();
                    
                }else if(pay==3){
                   $("#myModal4").modal();
                    
                }
            
            }
            );
           
           
           
           function save(){
               
               if(de==''){
                    de=0;
            }
            if(rett==''){
                    rett=0;
            }

            $.ajax({
            url: 'savePCreditServlet',
                    data: {
                            desc: de,
                            ret: rett,
                            po:po

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        
                    var d=data.split("-");
                    data=d['0'];
                    var id=d['1'];
                    if (data === "1") {
                        
                        
                        
                                
                                
                            swal({
                                title: "INVOICE SAVED!",
                                text: "invoice saved as credit invoice !",
                                icon: "success",
                                button: "OK"
                               }).then((value) => {
                                   location.reload();
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
           
           function savecash(){
               
               if(de==''){
                    de=0;
            }
            
            if(rett==''){
                    rett=0;
            }
            
            
            $.ajax({
            url: 'savePCashServlet',
                    data: {
                            desc: de,
                            ret: rett,
                            po:po

                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    var d=data.split("-");
                    data=d['0'];
                    var id=d['1'];
                    if (data === "1") {
                        
                        
                        
                                
                                
                            swal({
                                title: "INVOICE SAVED!",
                                text: "invoice saved as credit invoice !",
                                icon: "success",
                                button: "OK"
                               }).then((value) => {
                                   location.reload();
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