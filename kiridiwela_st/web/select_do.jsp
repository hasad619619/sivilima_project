<%@page import="java.util.Collections"%>
<%@page import="java.util.Collection"%>
<%@page import="resources.HoldInvoice"%>
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
            String Date="";
            String Date2="";
            
            if(request.getParameter("a") != null && request.getParameter("a").equals("390ab7b5754f7975bc1100f1566b12d5")){
            
            
            }else{
                response.sendRedirect("do.jsp");
            }
            if (request.getParameter("q") != null && !request.getParameter("q").equals("")  || request.getParameter("q2") != null && !request.getParameter("q2").equals("")) {
                Date=request.getParameter("q");
                Date2=request.getParameter("q2");
                
            }

        %>


        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <a href="do.jsp" style="font-size: 16px;"><span class="fa fa-arrow-left mb-3 mr-2"></span>BACK TO DILIIVER ORDER PAGE</a>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">please select hold invoice</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="select_do.jsp" >
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:150px;" id="inputGroup-sizing-default">START DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q" id="q" value="<%=Date %>">
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:150px;" id="inputGroup-sizing-default">END DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q2" id="q2" value="<%=Date2 %>">
                                    </div>


                                </div>
                                    <input type="hidden"  name="a" id="a" value="hash4521855854j4jnfturretgeghbsyh">
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
           
            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-striped" id="tbl1">
                            <thead>
                                <tr>
                                    <td style="background-color:#10ac84 !important; color: white !important; ">HOLD INVOICE ID</td>
                                    <td style="background-color:#10ac84 !important; color: white !important; ">CUSTOMER</td>
                                    <td style="background-color:#10ac84 !important; color: white !important; ">AMOUNT</td>
                                    <td style="background-color:#10ac84 !important; color: white !important; ">COST</td>
                                    <td style="background-color:#10ac84 !important; color: white !important; ">STATUS</td>
                                    <td style="background-color:#10ac84 !important; color: white !important; "></td>
                                    

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(true){
                                        Criteria cr=ses.createCriteria(HoldInvoice.class);
                                        if(Date != "" && Date2 != ""){
                                             cr.add(Restrictions.between("date", Date, Date2));
                                        }
                                        cr.add(Restrictions.eq("status", 1));
                                       
                                        List<HoldInvoice> IR=cr.list();
                                        Collections.reverse(IR);
                                   for (HoldInvoice ir : IR) {
                                        
                                %>
                                <tr>
                                    <td><%=ir.getIdholdInvoice()%></td>
                                    <td><%=ir.getAccount().getName().toUpperCase() %></td>
                                    <td><%= ir.getTotal() %></td>
                                    <td><%= ir.getTotalCost() %></td>
                                    <td><%= "ACTIVE" %></td>
                                    <td>
                                        <button type="submit" class="btn btn-success btn-sm select" id="select" value="<%=ir.getIdholdInvoice() %>"  >SELECT</button>
                                        <button type="submit" class="btn btn-info btn-sm view d-none" id="view" value="<%=ir.getIdholdInvoice() %>"  >VIEW</button>
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

        <script type="text/javascript">
            
            
            $(document).ready(function () {
                $('#tbl1').DataTable();
            });

           
            $('.select').click(function (){
                var hold_id=$(this).closest('tr').find('.select').val();
                $.ajax({
                        url: 'selectHoldForDoServlet',
                        data: {
                        id: hold_id
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            
                                   
                                location.replace("do.jsp");
                         

                    
                        } else if (data === "0") {
                                swal({
                                    title: "Please Try After ReFresh The Page !",
                                    text: "It Receiving Empty Date !",
                                    icon: "error",
                                    button: "OK"
                                });

                        }
                        else if (data === "2") {
                                swal({
                                    title: "Alredy Added !",
                                    text: "please remove added invoice and re try !",
                                    icon: "error",
                                    button: "OK"
                                });

                        }
                        
                    },
                    error: function () {
                            swal({
                            title: "Something Went Wrong !",
                            text: "something wrong in "+name+ " data please retry.",
                            icon: "error",
                            button: "OK"
                   });
            }
        });
                
            });

        </script>


    </body>
</html>