<%@page import="resources.Settings"%>
<%@page import="resources.Items"%>
<%@page import="resources.StockDamage"%>
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
        <title><%= Name %></title>

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
        <link href="src/datepicker/dist/datepicker.css" rel="stylesheet">
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

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->

        <div class="loader"></div>

        <main role="main" class="container">
            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">Damage stocks</li>
                    </ol>
                </nav>
            </div>

            <!-- Main content -->
             <div class="row mt-2">

                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <!-- form start -->
                        <form action="" method="post">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <label class="input-group-text" for="supp" style="width:100px; ">Stock ID:</label>
                                            </div>

                                            <input class="form-control" id="sup" name="sup" type="number">



                                        </div>
                                    </div>
                                <div class="col-sm-4">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;">Comment:</span>
                                    </div>
                                    <input type="text" aria-label="First name"  class="form-control" name="com" id="com" >

                                </div>
                                </div>
                                    <div class="col-sm-3">
                                        <div class="input-group ">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" style="width:100px;" >quantity:</span>
                                            </div>
                                            <input type="number" aria-label="First name"  class="form-control" name="qty" id="qty">

                                        </div>
                                    </div>
                                     <button  id="save_dev" type="button"  class="btn btn-sm btn-info save_dev">ADD TO DAMAGE STOCKS</button>
                            </div>    
                            </div>
                        </form>
                       
                    </div>

                </div>




            </div>

            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" >

                    <div class="card-body">
                        <table id="table1" class="table">

                            <thead>
                                <tr>
                                    <th style="background-color: #10ac84 !important; color: white !important; " id="dev_id" class="dev_id  d-none" >Id</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">Date</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">QTY</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">Item</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">Supplier</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">Stocks Branch</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; " >status</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; "></th>



                                </tr>
                            </thead>
                            <tbody>
                                <%                                    
                                    Session ses1 = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr1 = ses1.createCriteria(StockDamage.class);
                                    List<StockDamage> de = cr1.list();

                                    if (de.size() > 0) {
                                        for (StockDamage DE : de) {


                                %>
                                <tr>

                                    <td class="d-none"><%=DE.getStockDamageId()%></td>
                                    <td><%=DE.getDate()%></td>
                                    <td><%=DE.getQty() + " " +DE.getStock().getItems().getType().getName() %></td>
                                    <td><%=DE.getStock().getItems().getName()%></td>
                                    <td><%=DE.getStock().getItems().getAccount().getName()%></td>
                                    <td><%=DE.getBranch().getName() %></td>
                                    <%
                                        if (DE.getStatus() == 1) {
                                    %>
                                    <td><span class="badge bg-info">Pending</span></td>
                                    <%
                                    } else if (DE.getStatus() == 2) {
                                    %>
                                    <td><span class="badge bg-info ">Send To Return</span></td>
                                    <%
                                    } else {
                                    %>
                                    %>
                                    <td><span class="badge bg-danger ">Deleted</span></td>
                                    <%
                                        }
                                    %>


                                    <td>
                                        <button class="btn btn-danger btn-sm delete_dev" id="delete_dev"  value="<%=DE.getStockDamageId()%>">Delete | Reset</button>
                                        <input type="hidden" name="stat" id="stat" class="stat" value= "<%= DE.getStatus()%>"/>
                                        <input type="hidden" name="devid" id="devid" class="devid" value= "<%= DE.getStockDamageId()%>"/>


                                        <button  class="btn btn-info btn-sm return_dev" id="return_dev"  value="<%=DE.getStockDamageId()%>">Return</button>
                                        &nbsp; &nbsp;





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

            </div><!-- /.container-fluid -->      



           

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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js" type="text/javascript"></script>
        <script src="src/datepicker/dist/datepicker.js" type="text/javascript"></script>
        <script>
            $(window).load(function(){
                $('.loader').fadeOut();
            });
        </script>
        <script type="text/javascript">

            $(document).ready(function () {
                
                $('#sup').focus();

                $('#table1').DataTable();

            });



$("#save_dev").click(function () {
        
        $.ajax({
            url: 'saveDamageServlet',
            data: {
                com: $('input[name="com"]').val(),
                qty: $('input[name="qty"]').val(),
                sup: $('input[name="sup"]').val()
                

            },
            type: 'post',
            cache: false,
            success: function (data) {
                
                if (data === "1") {

                    
                    swal({
                                title: "Good job!",
                                text: "you saved new Damage Stock to list !",
                                icon: "success",
                                button: "OK"
                            }).then((value) => {
                                    location.reload();
                                
                          });
                    $('input[name="qty"]').val(""),
                    $('input[name="com"]').val("");

                    
                } else if (data === "0") {
                    swal({
                        title: "Empty Field Data !",
                        text: "Can't let any field empty.",
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
                        else if (data === "4") {
                                swal({
                                    title: "Wrong Stock Id !",
                                    text: "please enter correct stock id and try.",
                                    icon: "error",
                                    button: "OK"
                                });

                        }
                        else if (data === "5") {
                                swal({
                                    title: "Not Enough Stock !",
                                    text: "available qty is low.",
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
    );
    
    
    $(".return_dev").click(function () {
        
        
        

        var idd=$(this).closest('tr').find('.return_dev').val();
        
        
        swal({
            title: "Are you sure?",
            text: "do you want to Return Stock ? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'returnDamageServlet',
                        data: {
                        id: idd
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you Return The Stock !",
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
                                    title: "Can't Return Aftre Deleting",
                                    text: "Can't Delete After Returned To Seller",
                                    icon: "error",
                                    button: "OK"
                                });

                        }
                        else if (data === "7") {
                                swal({
                                    title: "Alredy Returned !",
                                    text: "Can't Return Again.",
                                    icon: "error",
                                    button: "OK"
                                });

                        }
                        else if (data === "4") {
                                swal({
                                    title: "Wrong Stock Id !",
                                    text: "please enter correct stock id and try.",
                                    icon: "error",
                                    button: "OK"
                                });

                        }
                        else if (data === "5") {
                                swal({
                                    title: "Not Enough Stock !",
                                    text: "available stock is low.",
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
        }
        );
                        
                    } else {
                        swal({
                        title: "Cancelled !",
                        text: "you cancelled Return process.",
                        icon: "error",
                        button: "OK"
                        });
                    }
            });
        
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
            text: "do you want to "+name+ " Details ? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'deleteDAServlet',
                        data: {
                        id: idd
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you "+name+ " Details from list !",
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
                        else if (data === "4") {
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