<%@page import="dataclass.helper"%>
<%@page import="resources.PurchusInvoiceItem"%>
<%@page import="resources.PurchusInvoice"%>
<%@page import="resources.SaleInvoiceItem"%>
<%@page import="resources.Items"%>
<%@page import="resources.Branch"%>
<%@page import="resources.SaleInvoice"%>
<%@page import="resources.PurchusInvoiceRecipt"%>
<%@page import="resources.InvoiceRecipt"%>
<%@page import="java.util.Set"%>
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
    </head>

    <body>

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->
        <%
            Session ses=connection.getConnection.getSessionFactory().openSession(); 
            helper help=new helper();
            String Date=help.getDate();
            String Date2=help.getDate();

            
            String BranchN="ALL";
            String AccountN="ALL";
            
            int branch=0;
            int account=0;
            
           
            double total_cost=0.0;
            double total_cash_sales=0.0;
            double total_credit_sales=0.0;
            double total_cheque_sales=0.0;
            
            
            if (request.getParameter("q") != null && !request.getParameter("q").equals("") 
                    && request.getParameter("q2") != null && !request.getParameter("q2").equals("") 
                    && request.getParameter("b") != null && !request.getParameter("b").equals("") 
                    && request.getParameter("a") != null && !request.getParameter("a").equals("") ) {
                Date=request.getParameter("q");
                Date2=request.getParameter("q2");
                branch=Integer.parseInt(request.getParameter("b"));
                account=Integer.parseInt(request.getParameter("a"));
                if(! request.getParameter("b").equals("0")){
                 Branch B=(Branch) ses.load(Branch.class, branch);
                 BranchN=B.getName();
                }
                if(! request.getParameter("a").equals("0")){
                Account A=(Account) ses.load(Account.class, account);
                AccountN=A.getName();
                }
                 
                
            }

        %>


        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Sales Analysis By Branch & Supplier</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="purchaseanalysebc.jsp" >
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">ST: DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q" id="q" value="<%=Date %>">
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">END DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q2" id="q2" value="<%=Date2 %>">
                                    </div>


                                </div>
                                    <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">BRANCH</span>
                                        </div>
                                       <select class="form-control" name="b" id="b"  >
                                           <option value="0">ALL</option>
                                        <%
                                           
                                            Criteria crb=ses.createCriteria(Branch.class);
                                            crb.add(Restrictions.eq("status", 1));
                                            List<Branch> br=crb.list();
                                            for(Branch BR:br){
                                            
                                            %>
                                                <option value="<%= BR.getIdbranch() %>"><%= BR.getName() %></option>
                                        <%
                                            }
                                            
                                            %>
                                                
                                    </select>
                                    </div>


                                </div>
                                    <div class="col-md-8">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">SUPPLIER</span>
                                        </div>
                                        <select class="form-control" name="a" id="a"  >
                                           <option value="0">ALL</option>
                                        <%
                                           
                                            Criteria cra=ses.createCriteria(Account.class);
                                            cra.add(Restrictions.eq("status", 1));
                                            cra.add(Restrictions.eq("supplier", 1));
                                            List<Account> bra=cra.list();
                                            for(Account BR:bra){
                                            
                                            %>
                                                <option value="<%= BR.getIdaccount() %>"><%= BR.getName() %></option>
                                        <%
                                            }
                                            
                                            %>
                                                
                                    </select>
                                    </div>


                                </div>
                                <div class="col-md-4">

                                    <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                        <button type="submit" class="btn btn-success" id="save"><span class="fa fa-save mr-2"></span>FIND</button>

                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <%
                if ( Date != "" && Date2 !="") {
            %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-6">
                                <table class="table table-bordered table-sm">
                                    <tr>
                                        <td>Total Purchase Amount :</td>
                                        <td id="B"></td>
                                    </tr>
                                    <tr>
                                        <td>Total Cash Purchase RS:</td>
                                        <td id="H"></td>
                                    </tr>
                                    <tr>
                                        <td>Total Credit Purchase RS:</td>
                                        <td id="I"></td>
                                    </tr>
                                    
                                    <tr>
                                        <td>Start Date :</td>
                                        <td id="D"><%=Date  %></td>
                                    </tr>
                                    <tr>
                                        <td>End Date :</td>
                                        <td id="E"><%=Date2  %></td>
                                    </tr>
                                    <tr>
                                        <td>Supplier Name :</td>
                                        <td id="F"><%=AccountN  %></td>
                                    </tr>
                                    <tr>
                                        <td>Branch :</td>
                                        <td id="G"><%=BranchN  %></td>
                                    </tr>
                                    
                                </table>
                                   
                                 
                                   


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
            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-light" id="tbl1">
                            <thead>
                                <tr>
                                    <td>Invoice ID</td>
                                    <td>Supplier</td>
                                    <td>Payment Type</td>
                                    <td>Amount</td>
                                    <td>Unit Price</td>
                                    <td>Print</td>
                                    

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(Date != null && Date2 != null){
                                        Criteria cr=ses.createCriteria(PurchusInvoice.class);
                                        //cr.add(Restrictions.eq("date", Date));
                                        cr.add(Restrictions.between("date", Date, Date2));
                                        List<PurchusInvoice> IR=cr.list();
                                      
                                    for (PurchusInvoice r : IR) {
                                        Set<PurchusInvoiceItem> II=r.getPurchusInvoiceItems(); 
                                        for(PurchusInvoiceItem ir: II){
                                       
                                        
                                        
                                        if(branch > 0 && account ==0){
                                            if(ir.getPurchusInvoice().getBranch().getIdbranch()  == branch ){
                                                total_cost=total_cost+ir.getTotal();
                                                if(ir.getPurchusInvoice().getPaymentType().getIdpaymentType() == 2){
                                                    total_cash_sales=total_cash_sales + ir.getTotal();
                                                }else if(ir.getPurchusInvoice().getPaymentType().getIdpaymentType() == 1){
                                                    total_credit_sales=total_credit_sales + ir.getTotal();
                                                }
                                                %>
                                                    <tr>
                                                        <td><%=ir.getPurchusInvoice().getIdpurchusInvoice() %></td>
                                                       <td><%=ir.getPurchusInvoice().getAccount().getName() %></td>
                                                        <td><%= ir.getPurchusInvoice().getPaymentType().getName() %></td>
                                                        <td><%= ir.getTotal() %></td>
                                                        <td><%= ir.getUnitPrice() %></td>
                                                        <td>
                                                            <a type="submit" class="btn btn-success" href="purchaseprint.jsp?pid=<%=ir.getPurchusInvoice().getIdpurchusInvoice() %>" >PRINT</a>
                                                        </td>

                                                    </tr>
                                                <%
                                            }
                                        }else if(account > 0 && branch==0){
                                            if(ir.getPurchusInvoice().getAccount().getIdaccount() == account){
                                                total_cost=total_cost+ir.getTotal();
                                                if(ir.getPurchusInvoice().getPaymentType().getIdpaymentType() == 2){
                                                    total_cash_sales=total_cash_sales + ir.getTotal();
                                                }else if(ir.getPurchusInvoice().getPaymentType().getIdpaymentType() == 1){
                                                    total_credit_sales=total_credit_sales + ir.getTotal();
                                                }
                                                %>
                                                    <tr>
                                                        <td><%=ir.getPurchusInvoice().getIdpurchusInvoice() %></td>
                                                       <td><%=ir.getPurchusInvoice().getAccount().getName() %></td>
                                                        <td><%= ir.getPurchusInvoice().getPaymentType().getName() %></td>
                                                        <td><%= ir.getTotal() %></td>
                                                        <td><%= ir.getUnitPrice() %></td>
                                                        <td>
                                                            <a type="submit" class="btn btn-success" href="invoiceeprint.jsp?pid=<%=ir.getPurchusInvoice().getIdpurchusInvoice() %>" >PRINT</a>
                                                        </td>

                                                    </tr>
                                                <%
                                            }
                                        }else if(account == 0 && branch == 0){
                                            total_cost=total_cost+ir.getTotal();
                                            if(ir.getPurchusInvoice().getPaymentType().getIdpaymentType() == 2){
                                                    total_cash_sales=total_cash_sales + ir.getTotal();
                                                }else if(ir.getPurchusInvoice().getPaymentType().getIdpaymentType() == 1){
                                                    total_credit_sales=total_credit_sales + ir.getTotal();
                                                }
                                                %>
                                                    <tr>
                                                        <td><%=ir.getPurchusInvoice().getIdpurchusInvoice() %></td>
                                                       <td><%=ir.getPurchusInvoice().getAccount().getName() %></td>
                                                        <td><%= ir.getPurchusInvoice().getPaymentType().getName() %></td>
                                                        <td><%= ir.getTotal() %></td>
                                                        <td><%= ir.getUnitPrice() %></td>
                                                        <td>
                                                            <a type="submit" class="btn btn-success" href="purchaseprint.jsp?pid=<%=ir.getPurchusInvoice().getIdpurchusInvoice() %>" >PRINT</a>
                                                        </td>

                                                    </tr>
                                                <%
                                            
                                        }else if(account > 0 && branch >  0){
                                            if(ir.getPurchusInvoice().getAccount().getIdaccount() == account && ir.getPurchusInvoice().getBranch().getIdbranch()  == branch ){
                                            total_cost=total_cost+ir.getTotal();
                                            if(ir.getPurchusInvoice().getPaymentType().getIdpaymentType() == 2){
                                                    total_cash_sales=total_cash_sales + ir.getTotal();
                                                }else if(ir.getPurchusInvoice().getPaymentType().getIdpaymentType() == 1){
                                                    total_credit_sales=total_credit_sales + ir.getTotal();
                                                }
                                                
                                                %>
                                                    <tr>
                                                        <td><%=ir.getPurchusInvoice().getIdpurchusInvoice() %></td>
                                                        <td><%=ir.getPurchusInvoice().getAccount().getName() %></td>
                                                        <td><%= ir.getPurchusInvoice().getPaymentType().getName() %></td>
                                                        <td><%= ir.getTotal() %></td>
                                                        <td><%= ir.getUnitPrice() %></td>
                                                        <td>
                                                            <a type="submit" class="btn btn-success" href="purchaseprint.jsp?pid=<%=ir.getPurchusInvoice().getIdpurchusInvoice() %>" >PRINT</a>
                                                        </td>

                                                    </tr>
                                                <%
                                            }
                                        
                                        }
                                        
                                    }
                                
                                    }
                                    }
                                   
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

        <script type="text/javascript">
            $('#b').val(<%=branch %>);
            $('#a').val(<%=account %>);
            var sDate=$('#D').html();
            var eDate=$('#E').html();
            var eBranch=$('#G').html();
            var eAccount=$('#F').html();
            
            $(document).ready(function () {
                $('#tbl1').DataTable({
                    dom: 'Blfrtip',
                    buttons: [
                        {
                            extend: 'copyHtml5',
                            exportOptions: {
                                columns: [0, 1, 2]
                            }
                        },
                        {
                            extend: 'excelHtml5',
                            exportOptions: {
                                columns: [0, 1, 2]
                            }
                        },
                        {
                            extend: 'pdfHtml5',
                            exportOptions: {
                                columns: [0, 1, 2]
                            }
                        },
                        {
                            extend: 'print',
                            exportOptions: {
                                columns: [0, 1, 2]
                            },customize: function(win) {
                    $(win.document.body).append('<h5>-------------------------------------------</h5>'); //after the table
                    $(win.document.body).append('<h5>Total Cost:'+"RS "+ <%=total_cost %>+'</h5>'); //after the table
                    $(win.document.body).append('<h5>Total Cash Purchase:'+"RS "+<%=total_cash_sales %>+'</h5>'); //after the table
                    $(win.document.body).append('<h5>Total Credit Purchase:'+"RS "+<%=total_credit_sales %>+'</h5>'); //after the table
                    $(win.document.body).append('<h5>Start Date:'+" "+ sDate +'</h5>'); //after the table
                    $(win.document.body).append('<h5>End Date:'+" "+ eDate +'</h5>'); //after the table
                    $(win.document.body).append('<h5>Item Name:'+" "+ eAccount +'</h5>'); //after the table
                    $(win.document.body).append('<h5>Branch:'+" "+ eBranch +'</h5>'); //after the table
                    $(win.document.body).append('<h5>-------------------------------------------</h5>'); //after the table
                    
                        }
                        },
                        'colvis'




                    ]

                });
            });

            document.getElementById('B').innerHTML="RS "+ <%=total_cost %>;
            document.getElementById('H').innerHTML=""+ <%=total_cash_sales %>;
            document.getElementById('I').innerHTML=""+ <%=total_credit_sales %>;
            


        </script>


    </body>
</html>