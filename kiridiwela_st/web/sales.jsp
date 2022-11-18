<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.TextList"%>
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
        <link href="src/css/bootstrap-datepicker.min.css" rel="stylesheet">
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
                    double grandprofit = 0.0;
                    Session Hses=connection.getConnection.getSessionFactory().openSession();

                %>
            <div class="row mt-3">
                <h5>New Sales Invoice</h5>
            </div>

            <div class="row mt-1">
                <div class="input-group input-group-append">
                    <div class="mr-2">
                        <div class="input-group ">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:120px;height: 35px;" id="inputGroup-sizing-default">CUSTOMER</span>
                            </div>
                            <select class="form-control sp" style="width:388px ;height: 35px;" id="customer" name="customer">
                                <option value="0">PLEASE SELECT CUSTOMER</option>
                                <%
                                    Criteria cust=Hses.createCriteria(Account.class);
                                    cust.add(Restrictions.eq("customer", 1));
                                    cust.add(Restrictions.eq("status", 1));
                                    List<Account> customerList=cust.list();
                                    for(Account CL : customerList){
                                %>
                                    <option value="<%=CL.getIdaccount() %>"><%=CL.getName() %></option>
                                
                                <%
                                    }
                                %>
                                
                            </select>
                        </div>
                    </div>
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:120px;height: 35px;" id="inputGroup-sizing-default">PAY TYPE</span>
                            </div>
                            <select class="form-control" style="width:140px ;height: 35px;" id="type" name="type">
                                <option value="0">SELECT</option>
                                <%
                                    Criteria type=Hses.createCriteria(PaymentType.class);
                                    type.add(Restrictions.eq("status", 1));
                                    List<PaymentType> paytypeList=type.list();
                                    for(PaymentType TY : paytypeList){
                                %>
                                    <option value="<%=TY.getIdpaymentType() %>"><%=TY.getName() %></option>
                                
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
                                <span class="input-group-text" style="width:120px;height: 35px;" id="inputGroup-sizing-default">ITEM</span>
                            </div>
                            
                                
                             <input type="text" class="form-control" style="width:655px;height: 35px;" id="item" name="item"> 
                        </div>
                    </div>
                </div>   
            </div>
            
            <div class="row mt-1">
                <div class="input-group input-group-append">
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:120px;height: 35px;" id="inputGroup-sizing-default">TYPE</span>
                            </div>
                            <select class="form-control" style="width:150px ;height: 35px;" id="mess" name="mess">
                                <option value="0">SELECT</option>
                                
                            </select>
                        </div>
                    </div>
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height: 35px;" id="inputGroup-sizing-default">QUANTITY</span>
                            </div>
                            <input type="number" class="form-control" style="width:100px;height: 35px;" name="qty" id="qty">

                        </div>
                    </div>
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height: 35px;" id="inputGroup-sizing-default">PRICE RS:</span>
                            </div>
                            <input type="number" class="form-control" style="width:130px;height: 35px;" name="price" id="price" disabled="">

                        </div>
                    </div>
                    <div class="mr-2">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height: 35px;" id="inputGroup-sizing-default">DISCOUNT RS:</span>
                            </div>
                            <input type="number" class="form-control" style="width:100px;height: 35px;" name="discount" id="discount" >

                        </div>
                    </div>
                    <div class="">
                        <button class="btn btn-info add mt-2" style="height: 35px;" id="add">ADD LIST</button>
                    </div>
                </div>
            </div>
            <div class="row mt-1">
                <p class="ml-2"><span style="color: green;">COST:</span><span style="color:red;" id="cost_f">RS 0.00</span></p>                     
                <p class="ml-2"><span style="color: green;">TOTAL COST:</span><span style="color:red;" id="totalcost_f">RS 0.00</span></p>                     
                <p class="ml-2"><span style="color: green;">TOTAL DISCOUNT:</span><span style="color:red;" id="des_f">RS 0.00</span></p>                     
                <p class="ml-2"><span style="color: green;">TOTAL:</span><span style="color:red;" id="total_f">RS 0.00</span></p>                     
                <p class="ml-2"><span style="color: green;">NET PROFIT:</span><span style="color:red;" id="profit_f">RS 0.00</span></p>                     
                                    
            </div>
            <div class="row mt-2">
                <table class="table table-sm table-light table-bordered" id="">
                    <thead>
                        <tr>
                            <th style="background-color:#10ac84 !important; color: white !important; ">ITEM</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">QTY</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">PRICE</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">TOTAL</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">DISCOUNT</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">NET TOTAL</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">NET COST</th>
                            <th style="background-color:#10ac84 !important; color: white !important; ">TOTAL PROFIT</th>
                            <th style="background-color:#10ac84 !important; color: white !important; "></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                            
                            ArrayList<invoiceModel> invoice = new ArrayList();
                            if (request.getSession().getAttribute("invoiceS") != null) {
                                invoice = (ArrayList<invoiceModel>) request.getSession().getAttribute("invoiceS");
                                BigDecimal tot = new BigDecimal(0);
                                BigDecimal totprof = new BigDecimal(0);
                                int i = 0;
                                for (invoiceModel IM : invoice) {
                                    BigDecimal now = new BigDecimal(IM.getTotal()-IM.getTotal_descount());
                                    BigDecimal nowprof = new BigDecimal(((IM.getTotal() - IM.getTotal_descount())-(IM.getCost()*IM.getQty_original())));
                                    tot = now.add(tot);
                                    totprof = nowprof.add(totprof);


                        %>

                        <tr>
                            <td><%=IM.getItemName()%></td>
                            <td><%=IM.getQty() + " " + IM.getType()%></td>
                            <td><%=df.format(IM.getPrice()) + " LKR"%></td>
                            <td><%=df.format(IM.getTotal()) + " LKR"%></td>
                            <td><%=df.format(IM.getTotal_descount()) + " LKR"%></td>
                            <td><%=df.format((IM.getTotal() - IM.getTotal_descount())) + " LKR"%></td>
                            <td><%=df.format((IM.getCost() * IM.getQty_original())) + " LKR"%></td>
                            <td><%=df.format(((IM.getTotal() - IM.getTotal_descount())-(IM.getCost()*IM.getQty_original()))) + " LKR"%></td>
                            <td><button class="btn btn-sm remove btn-danger" value="<%=i%>" >remove</button></td>
                        </tr>

                        <% ++i;
                                }
                                grandtotal = tot.doubleValue();
                                grandprofit = totprof.doubleValue();
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
                                <span class="input-group-text" style="width:130px;height: 35px;" id="inputGroup-sizing-default">TOTAL RS:</span>
                            </div>
                            <input type="number"  style="height: 35px;" class="form-control" value="<%= df.format(grandtotal) %>"  disabled="" name="total" id="total" >
                            
                        </div>
                    </div>
                    <div class="col-sm-4 mt-1">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height: 35px;" id="inputGroup-sizing-default">DISCOUNT RS:</span>
                            </div>
                            <input type="number" style="height: 35px;" class="form-control"  name="desct" id="desct">
                            
                        </div>
                    </div>
                    <div class="col-sm-4 mt-1">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height: 35px;" id="inputGroup-sizing-default">RETURN RS:</span>
                            </div>
                            <input type="number" style="height: 35px;" class="form-control"  name="return" id="return">
                            
                        </div>
                    </div>
                    
                    <div class="col-sm-4 mt-1">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height: 35px;" id="inputGroup-sizing-default">NET TOTAL RS:</span>
                            </div>
                            <input style="height: 35px;" type="number" class="form-control"  disabled="" name="nettotal" id="nettotal" >
                            
                        </div>
                    </div>
                    <div class="col-sm-4 mt-1">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height: 35px;" id="inputGroup-sizing-default">PROFIT RS:</span>
                            </div>
                            <input style="height: 35px;" type="number" class="form-control" value="<%= df.format(grandprofit) %>"  disabled="" name="netprofit2" id="netprofit2" >
                            
                        </div>
                    </div>
                    <div class="col-sm-4 mt-1">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="width:130px;height: 35px;" id="inputGroup-sizing-default">NET PROFIT RS:</span>
                            </div>
                            <input style="height: 35px;" type="number" class="form-control"  disabled="" name="netprofit" id="netprofit" >
                            
                        </div>
                    </div>
                    <div style="height: 35px;" class="btn-group mb-3 mt-2" role="group" aria-label="Basic example">
                                    
                        <button type="button" class="btn btn-sm btn-success" id="save_dev"><span class="fa fa-bookmark mr-2"></span>PROCEED</button>
                        <button type="button" class="btn btn-sm btn-info" onclick="location.replace('hold.jsp')" ><span class="fa fa-bookmark mr-2"></span>HOLD</button>
                        <button type="button" class="btn btn-sm btn-danger" id="clr"><span class="fa fa-trash mr-2"></span>CLEAR</button>
                    </div>
                </div>
            </div>
                            </div>
        </main>
       <!-- Modal view-->
        <div class="modal fade" id="cstockmodel" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog  modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle" >Choose Stock</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row " >
                            <div class="col-sm-12 mt-1">
                                <table class="table table-bordered table-sm" id="stocktb">
                                    <thead>
                                    
                                    <th>StockID</th>  
                                    <th>Stock Date</th>  
                                    <th>Branch</th>  
                                    <th>QTY</th>  
                                    <th>Cost(RS)</th>  
                                    <th>Option</th>  
                                    
                                    </thead>
                                    <tbody>
                                        
                                    </tbody>
                                </table>
                                    


                               
                                
                            </div>
                            

                        </div>
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
                            <div class="col-sm-12 mt-1 mb-2">
                               
                                    <div class="mr-2">
                                    <input type="text" class="typeahead form-control col-sm-12" data-provide="typeahead" > 
                                   
                                    </div>


                               
                                
                            </div>
                            

                        </div>
                    </div>
                   
                </div>
            </div>
        </div>
        <!-- Modal view-->
        <div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle" >do credit payment</h5>
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
                                                <span class="input-group-text" style="width:140px;" id="inputGroup-sizing-default">TRANSPORT RS:</span>
                                            </div>
                                            <input type="number" class="form-control" style="width:310px;" name="trans_amount" id="trans_amount" onload="">
                                        </div>
                                    </div>


                                </div>
                                
                            </div>
                            <div class="col-sm-12 mt-2">
                                <button class="btn btn-info" id="do_credit">PAY</button>
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
                                                <span class="input-group-text" style="width:140px;" id="inputGroup-sizing-default">AMOUNT RS:</span>
                                            </div>
                                            <input type="number" class="form-control" style="width:310px;" name="pay_amount" id="pay_amount" onload="">
                                        </div>
                                    </div>


                                </div>
                                <div class="input-group-append mt-1">
                                    <div class="mr-2">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="width:140px;" id="inputGroup-sizing-default">TRANSPORT RS:</span>
                                            </div>
                                            <input type="number" class="form-control" style="width:310px;" name="trans_amount_c" id="trans_amount_c" onload="">
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
                                                <span class="input-group-text" style="width:160px;" id="inputGroup-sizing-default">Amount RS:</span>
                                            </div>
                                            <input type="number" class="form-control" style="width:320px;" name="cheque_amount" id="cheque_amount" onload="">
                                        </div>
                                    </div>


                                    </div>
                                    <div class="input-group-append mt-1">
                                    <div class="mr-2">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="width:160px;" id="inputGroup-sizing-default">Cheque Number:</span>
                                            </div>
                                            <input type="text" class="form-control" style="width:320px;" name="cheque_number" id="cheque_number" onload="">
                                        </div>
                                    </div>


                                    </div>
                                    <div class="input-group-append mt-1">
                                    <div class="mr-2">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="width:160px;" id="inputGroup-sizing-default">Cheque Date:</span>
                                            </div>
                                            <input type="date"  class="form-control" style="width:320px;" name="cheque_date" id="cheque_date" onload="">
                                        </div>
                                    </div>


                                    </div>
                                    <div class="input-group-append mt-1">
                                    <div class="mr-2">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="width:160px;" id="inputGroup-sizing-default">Branch:</span>
                                            </div>
                                            <input type="text" list="text_list" class="form-control" style="width:320px;" name="cheque_branch" id="cheque_branch" onload="">
                                        </div>
                                    </div>
                                    


                                    </div>
                                    
                                    
                                    <div class="input-group-append mt-1">
                                    
                                    <div class="mr-2">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="width:160px;" id="inputGroup-sizing-default">Bank :</span>
                                            </div>
                                            <input type="text" list="text_list" class="form-control" style="width:320px;" name="cheque_b" id="cheque_b" onload="">
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
                                                <span class="input-group-text" style="width:160px;" id="inputGroup-sizing-default">Transport:</span>
                                            </div>
                                            <input type="number" class="form-control" style="width:320px;" name="cheque_transport" id="cheque_transport" onload="">
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
        <div class="modal  fade" id="opt_" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-lg modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle" >Hold or proceed invoice ?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row " >
                                <div class="col-sm-6">
                                    <a href="hold.jsp" class="btn btn-success">YES I WANT TO HOLD THIS INVOICE</a>
                                </div>
                                <div class="col-sm-6">
                                    <a href="#" onclick="afterSave()" class="btn btn-success">NO I WANT TO PROCEED THIS INVOICE</a>
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
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js" type="text/javascript"></script>
        <script src="src/datepicker/dist/datepicker.js" type="text/javascript"></script>
        <script src="src/datepicker/dist/bootstrap-datepicker.min.js"></script>
        <script src="src/js/printThis.js" type="text/javascript"></script>
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
            var ItemID = 0;
            var StockID = 0;
            var price = 0;
            var mesID=0;
            var qty=0;
            var cost=0;
            var IT_Price=0;
            var Descount=0;
            
            
            $('#cstockmodel').on('hidden.bs.modal', function (e) {
                if(StockID === 0){
                   $("#item").val("");
                   $("#item").focus(); 
                    
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
            
            $('#type').off();
            $('#customer').off();
            $('#customer').focus();
            
            var custId = 0;
            var type = 0;
            
            var P1 =<%=ISP1%>;
            
            if (P1 === 1) {

                custId =<%=A%>;
                type =<%=B%>;
                
                document.getElementById("type").value = "" + type;
                document.getElementById("customer").value = "" + custId;
                $("#customer").prop("disabled", true);
                $("#type").prop("disabled", true);
                $("#item").focus();
                
            }

            

            $("#customer").change(function () {

                $("#type").focus();  
                
            });
            
            
            $("#type").change(function () {
                onTypeChange();

            });
             
            
            function onTypeChange(){
                
                custId = $('#customer').find(":selected").val();
                type = $('#type').find(":selected").val();
                
            
                
                        if (type > 0 && custId > 0 ) {

                            $.ajax({
                                url: 'I1Servlet',
                                data: {
                                        type: type,
                                        cust: custId

                                },
                                type: 'post',
                                cache: false,
                                success: function (data) {
                                if (data === "1") {
                                    
                                    $("#customer").prop("disabled", true);
                                    $("#type").prop("disabled", true);
                                    $("#item").focus();
                                    
                                    
                                } else if (data === "0") {
                                    swal("TRY AGAIN !");

                                }



                                },
                                error: function () {
                                    swal("TRY AGAIN !");
                                }
                            });
                        }else{
                            
                            swal("SELECT CUSTOMER AND TYPE FIRST !");
                        }
                
            }
            
            $("#clr").click(function () {

                        $.ajax({
                            url: 'I1Clear',
                            data: {
                            type: 1

                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                                if (data === "1") {

                                    $("#customer").prop("disabled", false);
                                    $("#type").prop("disabled", false);
                                    
                                   
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
            
            $('#item').keypress(function (e) {
                if(e.which===112){
                     $('#desct').focus();
                }
            });
            
            function getItemStock(ID){
                 
                 var dataString ='hash='+ItemID ;
                 
                    $.ajax({
                        url: 'getItemStockServlet',
                        dataType: "json",
                        data: dataString,
                        cache: false,
                        success: function (player) {
                            if (player.length === 0) {
                                
                               
                            } else {
                                $("#stocktb").find("tr:gt(0)").remove();
                                var table = document.getElementById('stocktb');
                                $.each(player, function (key, value) {
                                    var tr = document.createElement('tr');
                                        tr.innerHTML = '<td>' + value.sid + '</td>' +
                                        '<td>' + value.date + '</td>' +
                                        '<td>' + value.branch + '</td>' +
                                        '<td>' + value.qty + '</td>' +
                                        '<td>' + value.cost + '</td>'+
                                        '<td> '+ 
                                        '<button class="btn btn-sm btn-info mr-1" onclick="clickUse('+value.sid+')" >USE</button>'+
                                        ' </td>';
                                        table.appendChild(tr);
                                });
                                 $("#cstockmodel").modal();
                        }


                        },error: function () {
                            swal("TRY AGAIN !");
                        }
                        
                    });
                 
                
                
            }
            
            function clickUse(SID){
                StockID=SID;
                getMessList(SID);
                $('#mess').focus();
                $('#cstockmodel').modal('hide');
                
            }
            function clickPrice(SID){
                alert(SID);
                
            }
            
            function getMessList(STOCKID) {

                var dataString = 'p2=' + STOCKID;
                
                
                    $.ajax({
                        url: 'getMessListServlet',
                        dataType: "json",
                        data: dataString,
                        cache: false,
                        success: function (player) {
                            let dropdown = $('#mess');
                            dropdown.empty();
                            if (player.length === 0) {

                                $("#mess").append("<option value='0' >SELECT</option>");
                            } else {
                                $("#mess").append("<option value=" + -1 + ">SELECT</option>");
                                $.each(player, function (key, value) {
                                $("#mess").append("<option value=" + value.id + " >" + value.name + "</option>");
                                });
                        }

                                $('#mess').focus();
                        }
                    });
            }
            
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
                                getItemStock(ItemID);
                               
                              
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
            
            $("#mess").change(function () {
                $('#price').val("");
                var id = $('#mess').find(":selected").val();
                var cost = $('#mess').find(":selected").html();
                $('#cost_f').val(cost.split('~')[1]); 
                $.ajax({
                    url: 'getItemPriceAsCustomer',
                            data: {
                            itemid:ItemID,
                            stockid:StockID,
                            mesid:id,
                            cust:custId


                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                               
                                var d=data.split("-");
                                data=d['0'];
                                var xx=d['1']; 
                               
                                 
                            if (data === "1") {
                                IT_Price=xx;
                               $('#price').val(xx);
                               $('#qty').focus();
                              
                            } else if (data === "0") {
                                    
                                     swal("TRY AGAIN !").then((value) => {
                                        $('#item').focus();
                                        $('#price').val("");
                                    });
                            }


                            },
                            error: function () {
                                swal("TRY AGAIN !");
                                $('#price').val("");
                            }
                    });
                
                
                
            });
            
            $('#qty').keyup(function(e) {
                
                
                var q=$('#qty').val();
                if (e.which === 13) {
                    if (ItemID == 0 ){

                            swal("PLEASE SELECT ITEM FIRST !").then((value) => {
                                  $('#item').focus();  
                            });
                           
                    } else{
                            qty=$('#qty').val();
                            if(qty == ''){qty=0;}
                            if(qty == 0){
                                
                                swal("PLEASE ENTER QTY !").then((value) => {
                                  $('#qty').focus();  
                                });
                                
                            }else{
                                $('#discount').focus();
                            }

                             
                    }
                    
                }else{
                    if(isNaN(q)){
                      swal("ENTER VALID QTY !");  
                }else{
                     if(StockID > 0 && ItemID > 0){
                         $.ajax({
                            url: 'getStockCostServlet',
                            data: {
                            st:StockID,
                            qty:q,
                            p:IT_Price,
                            mess:mesID,
                            des:0


                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                               
                                var d=data.split("~");
                                data=d['0'];
                                
                            if (data === "1") {
                                $('#cost_f').html("RS "+d['1']);
                                $('#totalcost_f').html("RS "+d['2']);
                                $('#total_f').html("RS "+d['3']);
                                $('#profit_f').html("RS "+d['4']);
                                $('#des_f').html("RS "+d['5']);
                              
                            } else if (data === "0") {
                                    
                                     swal("PLEASE ENTER DATA ! !").then((value) => {
                                       
                                     });
                            }


                            },
                            error: function () {
                                swal("TRY AGAIN !");
                            }
                    });
                         
                         
                     }else{
                         swal("DIDN'T SET STOCK OR ITEM. TRY AGAIN !");
                         
                         
                     }   
                        
                       
                }
                    
                    
                }
                
                
                
                
            });
            
            
            $('#discount').keyup(function (e) {
                Descount = $('#discount').val();
                qty=$('#qty').val();
                if(Descount == ''){
                    Descount=0.0;
                    $('#discount').val("0");
                }
                if (e.which === 13) {
                    
                
                    if (ItemID == 0  || qty == 0 || IT_Price == 0 ){
                            
                            swal("PLEASE SELECT DATA FIRST !");
                            $('#discount').focus();
                    } else{
                            
                             
                             onAddPress();
                             
                    }
                }else{
                        $.ajax({
                            url: 'getStockCostServlet',
                            data: {
                            st:StockID,
                            qty:qty,
                            p:IT_Price,
                            mess:mesID,
                            des:Descount


                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                               
                                var d=data.split("~");
                                data=d['0'];
                                
                            if (data === "1") {
                                $('#cost_f').html("RS "+d['1']);
                                $('#totalcost_f').html("RS "+d['2']);
                                $('#total_f').html("RS "+d['3']);
                                $('#profit_f').html("RS "+d['4']);
                                $('#des_f').html("RS "+d['5']);
                              
                            } else if (data === "0") {
                                   
                                     swal("PLEASE ENTER DATA ! !").then((value) => {
                                       
                                     });
                            }


                            },
                            error: function () {
                                swal("TRY AGAIN !");
                            }
                    });
                    
                    
                }
            });
            
            
            
            
            $('#add').click(function (e) {
                 onAddPress();
            });
            
            
            function onAddPress(){
                        price = IT_Price;
                        qty=$('#qty').val();
                        descount=$('#discount').val();
                        if ( custId == 0 || type == 0 ){
                            
                            swal("PLEASE SET CUSTOMER AND PAYMENT TYPE FIRST !").then((value) => {
                                              $('#customer').focus();  
                            });
                            
                        } else{
                        if (ItemID == 0 || qty == 0 || price == 0){

                            swal("PLEASE SET ITEM DISCOUNT AND QTY FIRST !").then((value) => {
                                              $('#item').focus();  
                            });

                        } else{

                                    $.ajax({
                                    url: 'setInvoiceServlet',
                                            data: {
                                                    itemID: ItemID,
                                                    stockid: StockID,
                                                    qty: qty,
                                                    discount: descount,
                                                    price:price,
                                                    mess:mesID

                                            },
                                            type: 'post',
                                            cache: false,
                                            success: function (data) {
                                                
                                                if (data === "1") {
                                                    location.reload();
                                                } else if (data === "0") {

                                                    swal("PLEASE SELECT DATA FIRST !");
                                                }
                                                else if (data === "2") {

                                                    swal("NOT ENOUGH STOCK !").then((value) => {
                                                         $('#qty').focus();  
                                                    });
                                                }
                                                else if (data === "3") {

                                                    swal("WRONG PRICE!").then((value) => {
                                                         $('#price').focus();  
                                                    });
                                                }
                                                else if (data === "4") {

                                                    swal("CALCULATION NOT FOUND !").then((value) => {
                                                         $('#mess').focus();  
                                                    });
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
                    url: 'RemoveInvoiceServletI1',
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
            
            var grand =<%=grandtotal%>
            var grandprof =<%=grandprofit%>
            var des_grand = $('#desct').val();
            var de = des_grand;
            var rett = 0;
            var grand_tot = 0;
            var transport=0;
            
            
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
            //des_grand = (grand / 100) * des_grand;
                grand_tot = (grand - des_grand);
                $('#nettotal').val(grand_tot);
            
                getRetTot();
            }



            $('#desct').keyup(function (e) {
                des_grand = $('#desct').val();
                if(des_grand == ''){de=0;}
               
                de = des_grand;
                //des_grand = (grand / 100) * des_grand;
                grand_tot = (grand - des_grand);
                $('#nettotal').val(grand_tot);
                getRetTot();
            
            });
            
            function getRetTot(){
                getNetProfit();
                var retu = $('#return').val();
                rett=retu;
                if(retu ===''){
                    retu=0;
                    
                }
                
                var ret_tot = (grand_tot - retu);
                $('#nettotal').val(ret_tot);
                
                
            }
            
            function getNetProfit(){
                var d= $('#desct').val();
                de=d;
                var p = $('#netprofit2').val();
                if(d == ''){d=0;}
                if(p == ''){p=0;}
                $('#netprofit').val(p-d);
            }
            
            
            
            $('#return').keyup(function (e) {
                getRetTot();
                
            
            });
            
            $('#desct').keypress(function (e) {
                if(de == ''){de=0;}
                if (e.which === 13) {
                    $('#return').focus();
                    
                }
            });
            $('#return').keypress(function (e) {
                if (e.which === 13) {
                   befourSave();
                    
                }
            });
            

            $("#save_dev").click(function () {
                
                    befourSave();
            });
            
           $('#myModal2').on('shown.bs.modal', function () {
                    $('#pay_amount').focus();
            });
            $('#myModal3').on('shown.bs.modal', function () {
                    $('#trans_amount').focus();
            });  
            $('#myModal4').on('shown.bs.modal', function () {
                    $('#cheque_amount').focus();
            }); 
           
           function befourSave(){
                $("#opt_").modal();
                
           }
           
           function afterSave(){
               $('#opt_').modal('hide');
               if(type==1){
                    
                     $("#myModal3").modal();
                    
                }else if(type==2){
                    
                    $("#myModal2").modal();
                    
                }else if(type==3){
                    $("#myModal4").modal();
                    
                    
                }
               
           }
           $("#do_credit").click(function (){
               transport=$('#trans_amount').val();
               save();
           });
           
           $('#trans_amount').keypress(function (e) {
                 transport=$('#trans_amount').val();
                if (e.which === 13) {
                   save();
                    
                }
            });
            var pay_amount=0;
            var transport_cash=0;
            
            //trans_amount_c pay_amount pay_cash
            $("#pay_cash").click(function (){
                pay_amount=$('#pay_amount').val();
                
                savecash();
           });
           
           $('#pay_amount').keypress(function (e) {
                 pay_amount=$('#pay_amount').val();
                if (e.which === 13) {
                   $('#trans_amount_c').focus();
                    
                    
                }
            });
            $('#trans_amount_c').keypress(function (e) {
                 transport_cash=$('#trans_amount_c').val();
                  pay_amount=$('#pay_amount').val();
                if (e.which === 13) {
                    
                   $('#trans_amount_c').focus();
                    savecash();
                }
            });
           
           function save(){
                    pay_amount=$('#pay_amount').val();
                    de=$('#desct').val();
                    if(de==''){
                      de=0;
                    }
                    if(transport==''){
                      transport=0;
                    }
                    if(rett==''){
                      rett=0;
                    }
                    

                             $.ajax({
                             url: 'saveInCreditServlet',
                                     data: {
                                     desc: de,
                                     ret: rett,
                                     trans:transport

                                     },
                                     type: 'post',
                                     cache: false,
                                     success: function (data) {
                                        var d=data.split("-");
                                        data=d['0'];
                                        var id=d['1'];
                                        if (data === "1") {
                                            swal({
                                                title: "Print Invoice ?",
                                                text: "do you want to print invoice now ? ",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                if(willDelete){
                                                       // location.replace('invoiceeprint.jsp?pid='+id);
                                                       location.reload();
                                                       popupWindow = window.open('invoiceeprint.jsp?pid='+id,'popUpWindow','height='+screen.availHeight+',width='+screen.availWidth+',left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes');
                                                
                                                }else{
                                                        swal({
                                                            title: "INVOICE SAVED!",
                                                            text: "invoice saved as credit invoice !",
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
           
           function savecash(){
                    var p = $('#nettotal').val();
                    
                    pay_amount=$('#pay_amount').val();
                    de=$('#desct').val();
                    
                    grand_tot=p;
                    
                    if(de==''){
                      de=0;
                    }
                    if(transport_cash==''){
                      transport_cash=0;
                    }
                    
                    if(pay_amount==''){
                      pay_amount=0;
                    }
                    
                    if(rett==''){
                      rett=0;
                    }
                    
                    if(parseFloat(grand_tot) > parseFloat(pay_amount)){
                        
                                            swal({
                                                title: "Payment Not Enough !",
                                                text: "you anterd amount is low. want to add res for credit ? ",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                if(willDelete){
                                                        pay_amount=$('#pay_amount').val();
                                                       savCashChecked(de,rett,transport_cash,pay_amount); 
                                                }else{
                                                      
                                                        $('#pay_amount').focus();
                                                }
                                            });
                        
                    }
                    else if(parseFloat(grand_tot) < parseFloat(pay_amount)){
                        
                                            swal({
                                                title: "Payment Is High !",
                                                text: "you anterd amount is high. want to add res for account ?",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                 if(willDelete){
                                                      pay_amount=$('#pay_amount').val();
                                                      savCashChecked(de,rett,transport_cash,pay_amount); 
                                                       
                                                }else{
                                                        
                                                        $('#pay_amount').focus();
                                                       
                                                }
                                            });
                        
                    }
                   else if(parseFloat(grand_tot) == parseFloat(pay_amount)){
                        pay_amount=$('#pay_amount').val();
                        savCashChecked(de,rett,transport_cash,pay_amount);
                         
                        
                    }
                    

                             
               
               
           }
           
           
           function savCashChecked(descount,return_amount,transport,pay){
               
                    $.ajax({
                             url: 'saveInCashServlet',
                                     data: {
                                     desc: descount,
                                     ret: return_amount,
                                     trans:transport,
                                     payment:pay

                                     },
                                     type: 'post',
                                     cache: false,
                                     success: function (data) {
                                        var d=data.split("-");
                                        data=d['0'];
                                        var id=d['1'];
                                        if (data === "1") {
                                            swal({
                                                title: "Print Invoice ?",
                                                text: "do you want to print invoice now ? ",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                if(willDelete){
                                                        //location.replace('invoiceeprint.jsp?pid='+id);
                                                        location.reload();
                                                        popupWindow = window.open('invoiceeprint.jsp?pid='+id,'popUpWindow','height='+screen.availHeight+',width='+screen.availWidth+',left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes');
                                                }else{
                                                        swal({
                                                            title: "INVOICE SAVED!",
                                                            text: "invoice saved as Cash invoice !",
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
            $('#cheque_b').keypress(function (e) {
                 if (e.which === 13) {
                  $('#cheque_transport').focus();
                   
                }
            });
            
            
            
            $('#cheque_transport').keypress(function (e) {
                 if (e.which === 13) {
                  
                   transport_cheque=$('#cheque_transport').val();
                   saveCheque();
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
                    if(parseFloat(grand_tot) == parseFloat(cheque_amount)){
                        cheque_amount=$('#cheque_amount').val();
                        savchequeChecked(de,rett,transport_cheque,cheque_amount);
                        
                    }
                
            }
            
            function savchequeChecked(descount,return_amount,transport,pay){
                    var d=$('#cheque_date').val();
                    var bran=$('#cheque_b').val()
                    var b=$('#cheque_branch').val();
                    var tt=$('#cheque_branch').val();
                    var t=$('#cheque_b').val();
                    $.ajax({
                             url: 'saveInChequeServlet',
                                     data: {
                                     desc: descount,
                                     ret: return_amount,
                                     trans:transport,
                                     payment:pay,
                                     number:$('#cheque_number').val(),
                                     date:d,
                                     branch:bran,
                                     bank:b,
                                     t1:tt,
                                     t2:t
                                     

                                     },
                                     type: 'post',
                                     cache: false,
                                     success: function (data) {
                                        var d=data.split("-");
                                        data=d['0'];
                                        var id=d['1'];
                                        if (data === "1") {
                                            swal({
                                                title: "Print Invoice ?",
                                                text: "do you want to print invoice now ? ",
                                                icon: "warning",
                                                buttons: true,
                                                dangerMode: true,
                                            }).then((willDelete) =>{
                                                if(willDelete){
                                                        //location.replace('invoiceeprint.jsp?pid='+id);
                                                        location.reload();
                                                        popupWindow = window.open('invoiceeprint.jsp?pid='+id,'popUpWindow','height='+screen.availHeight+',width='+screen.availWidth+',left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no, status=yes');
                                                
                                                }else{
                                                        swal({
                                                            title: "INVOICE SAVED!",
                                                            text: "invoice saved as Cheque invoice !",
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