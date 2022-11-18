<%@page import="java.text.DecimalFormat"%>
<%@page import="dataclass.helper"%>
<%@page import="resources.QuotationInvoice"%>
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
            DecimalFormat df = new DecimalFormat("##########0.00");
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
    </head>

    <body>
         <div class="loader"></div>
        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->
        <%
            Session ses=connection.getConnection.getSessionFactory().openSession(); 
            String Date="";
            String Date2="";
            
            double total_sales=0.0;
            double total_cost=0.0;
            double total_return=0.0;
            double total_income=0.0;
            
            double total_cash_sales=0.0;
            double total_credit_sales=0.0;
            double total_cheque_sales=0.0;
            
           
            if (request.getParameter("q") != null && !request.getParameter("q").equals("")  || request.getParameter("q2") != null && !request.getParameter("q2").equals("")) {
                Date=request.getParameter("q");
                Date2=request.getParameter("q2");
                
            }else{
                
                helper h=new helper();
                Date=h.getDate();
                Date2=h.getDate();
            }

        %>


        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">Issued quotation list</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="quotationlist.jsp" >
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

                                    <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                        <button type="submit" class="btn btn-success" id="save">FIND</button>
                                        <a  class="btn btn-info ml-1" href="quotationlist.jsp?all=ok" >GET ALL</a>

                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <%
                if ( Date != "" && Date2 != "") {
            %>
            <div class="row mt-2 d-none">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-6">
                                <table class="table table-bordered table-sm">
                                    <tr>
                                        <td>Total Sales :</td>
                                        <td id="A"></td>
                                    </tr>
                                    <tr>
                                        <td>Total Credit Sales :</td>
                                        <td id="E"></td>
                                    </tr>
                                    <tr>
                                        <td>Total Cash Sales :</td>
                                        <td id="F"></td>
                                    </tr>
                                    <tr>
                                        <td>Total Cheque Sales :</td>
                                        <td id="G"></td>
                                    </tr>
                                    <tr>
                                        <td>Total Cost :</td>
                                        <td id="B"></td>
                                    </tr>
                                    <tr>
                                        <td>Total Return :</td>
                                        <td id="D"></td>
                                    </tr>
                                    <tr>
                                        <td>Total Income :</td>
                                        <td id="C"></td>
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
                                    <td style="background-color: #10ac84 !important; color: white !important; ">#</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">Customer</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">Total</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">Profit</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">Date</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; "></td>
                                    

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(Date != null && Date2 != null){
                                        Criteria cr=ses.createCriteria(QuotationInvoice.class);
                                        if(request.getParameter("all") != null && request.getParameter("all").equals("ok")){
                                            
                                        }else{
                                            cr.add(Restrictions.between("date", Date, Date2));
                                        }
                                        
                                        List<QuotationInvoice> IR=cr.list();

                                    for (QuotationInvoice ir : IR) {
                                        total_sales=total_sales + ir.getTotal();
                                        total_cost=total_cost + ir.getTotalCost();
                                        total_return=total_return + ir.getReturnAmount();
                                        if(ir.getPaymentType().getIdpaymentType() == 2){
                                            total_cash_sales=total_cash_sales + ir.getTotal();
                                        }else if(ir.getPaymentType().getIdpaymentType() == 1){
                                            total_credit_sales=total_credit_sales + ir.getTotal();
                                        }else if(ir.getPaymentType().getIdpaymentType() == 3){
                                            total_cheque_sales=total_cheque_sales + ir.getTotal();
                                        }
                                %>
                                <tr>
                                    <td><%=ir.getIdquotationInvoice()%></td>
                                    <td><%=ir.getAccount().getName() %></td>
                                    <td><%="Rs."+ df.format(ir.getTotal()) %></td>
                                    <td><%="Rs."+ df.format(ir.getTotal()-ir.getTotalCost()) %></td>
                                    <td><%=ir.getDate()+" "+ir.getTime() %></td>
                                    <td>
                                        <a type="submit" target="_blank"   class="btn btn-sm btn-success" href="printquatation.jsp?q=<%=ir.getIdquotationInvoice()%>" >PRINT</a>
                                        <a type="submit" target="_blank" class="btn btn-sm btn-info" href="printquatation.jsp?q=<%=ir.getIdquotationInvoice()%>&n=1" >VIEW</a>
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
        <script>
            $(window).load(function(){
                $('.loader').fadeOut();
            });
        </script>
        <script type="text/javascript">
            
            
            $(document).ready(function () {
                $('#tbl1').DataTable();
            });

            


        </script>


    </body>
</html>