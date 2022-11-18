<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.StockReturn"%>
<%@page import="resources.Settings"%>
<%@page import="resources.Category"%>
<%@page import="resources.Brand"%>
<%@page import="resources.Type"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Items"%>
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



        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><a href="index.jsp"><i class="fa fa-home"></i> Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">List - Goods return to supplier</li>
                    </ol>
                </nav>
            </div>

            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-light" id="tbl1">
                            <thead>
                                <tr>
                                    <th style="background-color:#10ac84 !important; color: white !important; " id="dev_id" class="dev_id" >Id</th>
                                    <th style="background-color:#10ac84 !important; color: white !important; ">Date</th>
                                    <th style="background-color:#10ac84 !important; color: white !important; ">Amount</th>
                                    <th style="background-color:#10ac84 !important; color: white !important; ">Supplier</th>
                                    <th style="background-color:#10ac84 !important; color: white !important; ">status</th>
                                    <th style="background-color:#10ac84 !important; color: white !important; "></th>
                                    


                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses1 = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr1 = ses1.createCriteria(StockReturn.class);
                                    List<StockReturn> de = cr1.list();
                                    
                                    
                                    if (de.size() > 0) {
                                        for ( StockReturn DE : de) {


                                %>
                                <tr>
                                    
                                    <td><%=DE.getIdstockReturn() %></td>
                                    <td><%=DE.getDate() %></td>
                                    <td><%=df.format(DE.getAmount()) %></td>
                                   <td><%=DE.getAccount().getName() %></td>
                                    <%
                                        if (DE.getStatus() == 1) {
                                    %>
                                    <td><span class="badge bg-info">Pending</span></td>
                                    <%
                                    } else if(DE.getStatus()==2) {
                                    %>
                                    <td><span class="badge bg-info ">Returned To Seller</span></td>
                                    <%
                                        }else{
                                    %>
                                    %>
                                    <td><span class="badge bg-danger ">Deleted</span></td>
                                    <%
                                        }
                                    %>
                                    

                                    <td>
                                        
                                        <input type="hidden" name="stat" id="stat" class="stat" value= "<%= DE.getStatus() %>"/>
                                        <input type="hidden" name="devid" id="devid" class="devid" value= "<%= DE.getIdstockReturn() %>"/>
                                        
                                        
                                        <a  class="btn btn-info btn-sm " target="_blank"  href="showreturn.jsp?pid=<%=DE.getIdstockReturn()%>&n=1">VIEW</a>
                                        <a  class="btn btn-primary btn-sm " target="_blank"   href="showreturn.jsp?pid=<%=DE.getIdstockReturn()%>">PRINT</a>
                                        &nbsp; &nbsp;
                                        <%
                                            if(DE.getStatus()==1 ){
                                            %>
                                        <button class="btn btn-danger btn-sm delete_dev" id="delete_dev"  value="<%=DE.getIdstockReturn() %>">Delete</button>
                                        <%
                                            }
                                            %>
                                        
                                        
                                        


                                    </td>
                                </tr>

                                <%
                                        }

                                    }

                                    ses1.close();
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
                //$('#tbl1').DataTable();
            });
            
            $(document).ready(function() {
                $('#tbl1').DataTable();
            });

            $(".view_dev").click(function () {
                
        
            });
            
            $(".delete_dev").click(function () {
        
        
        

        var idd=$(this).closest('tr').find('.delete_dev').val();
        var stat=$(this).closest('tr').find('input[name="stat"]').val();
        
        var name="";
        if(stat=="1"){
            
            name="delete";
        }else{
            
            name="restore";
            
        }
        
        swal({
            title: "Are you sure?",
            text: "do you want to "+name+ " Return Details ? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'seleteStockR1Servlet',
                        data: {
                        id: idd
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you "+name+ " Invoice from list !",
                                icon: "success",
                                button: "OK"
                            }).then((value) => {
                                   
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
                                    title: "Access denied !",
                                    text: "You can't do this action without permision.",
                                    icon: "error",
                                    button: "OK"
                                });

                        }
                        else if (data === "6") {
                                swal({
                                    title: "Can't Delete After Returned",
                                    text: "Can't Delete After Returned To Seller",
                                    icon: "error",
                                    button: "OK"
                                });

                        }
                        
                        else if (data === "8") {
                                location.replace("login.jsp");

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
        }
        );
                        
                    } else {
                        swal({
                        title: "Cancelled !",
                        text: "you cancelled "+name+ " process.",
                        icon: "error",
                        button: "OK"
                        });
                    }
            });
        
    });
    
    


        </script>


    </body>
</html>