<%@page import="resources.User"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.StockTransfer"%>
<%@page import="resources.Settings"%>
<%@page import="resources.Branch"%>
<%@page import="resources.Category"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<<%@page import="org.hibernate.Session"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%
            User admin = null;
            int branch_id= 0;
            if (request.getSession().getAttribute("administrator") == null) {
                response.sendRedirect("login.jsp");
            }else{
               admin  = (User) request.getSession().getAttribute("administrator");
               branch_id = admin.getBranch().getIdbranch();
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
        <title><%= Name %></title>

        <!-- Bootstrap core CSS -->
        <link href="src/boostrap/bootstrap-4.1.3/css/bootstrap.min.css" rel="stylesheet">
        
        
  
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">

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
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-arrow-left"></span>&nbsp;<a href="stocktransfer.jsp">Back</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Request Inbox</li>
                    </ol>
                </nav>
            </div>
            
            <!-- Main content -->

            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" >

                    <div class="card-body">
                        <table id="table1" class="table table-sm table-active">

                            <thead>
                                <tr style="background-color: #10ac84 !important; color: white !important; ">
                                    <th id="dev_id" class="dev_id" >Request ID</th>
                                    <th>Date</th>
                                    <th>Item</th>
                                    <th>Amount</th>
                                    <th>Request Branch</th>
                                    <th></th>
                                    


                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(StockTransfer.class);
                                    cr.add(Restrictions.eq("status", 1));
                                    List<StockTransfer> de = cr.list();
                                    
                                    
                                    if (de.size() > 0) {
                                        for ( StockTransfer DE : de) {
                                            if(branch_id == DE.getBranchByToBranch().getIdbranch() ){


                                %>
                                <tr>
                                    <td><%=DE.getIdstockTransfer() %></td>
                                    <td><%=DE.getDate()+" "+DE.getTime() %></td>
                                    <td><%=DE.getItems().getName() %></td>
                                    <td><%=df.format(DE.getRequestQty()) %></td>
                                    <td><%=DE.getBranchByToBranch().getName() %></td>
                                    
                                    <td>
                                        <button class="btn btn-warning btn-sm delete_dev" id="delete_dev"  value="<%=DE.getIdstockTransfer() %>">REJECT</button>
                                        <button class="btn btn-info btn-sm approve_dev" id="approve_dev"  value="<%=DE.getIdstockTransfer() %>">APPROVE</button>
                                        <input type="hidden" name="stat" id="stat" class="stat" value= "<%= DE.getStatus() %>"/>
                                        <input type="hidden" name="ite" id="ite" class="ite" value= "<%= DE.getItems().getItemId() %>"/>
                                    </td>
                                </tr>

                                <%
                                       } }

                                    }
                                    ses.close();


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


        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="src/jquery/jquery-1.11.1.min.js" ></script>
        <script src="src/boostrap/bootstrap-4.1.3/js/bootstrap.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
            $(window).load(function(){
                 $('.loader').fadeOut();
            });
        </script>

        <script type="text/javascript">
             $(document).ready(function () {
                $('#table1').dataTable();
            });
     var id = 0;
     var item = 0;
     $(".approve_dev").click(function () {
         id=$(this).closest('tr').find('.approve_dev').val();
         item=$(this).closest('tr').find('input[name="ite"]').val();
         getItemStock(item);
     });
            
    function clickUse(ID) {
        
       
        
        
        swal({
            title: "Accept request ?",
            text: "do you want to accept this request.",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'acceptStockTransferServlet',
                        data: {
                        id: id,
                        stock:ID
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Accepted!",
                                text: "you just accepted request.",
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
                                    title: "Not Enough Stock!",
                                    text: "Not Enough qty found on you selected stock.",
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
                        
                    } else {
                        swal({
                        title: "Cancelled !",
                        text: "you cancelled the process.",
                        icon: "error",
                        button: "OK"
                        });
                    }
            });
        
    }
    
    function getItemStock(ID){
                 var dataString ='hash='+ID ;
                 
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
   
    $(".delete_dev").click(function () {
        
       
        var idd=$(this).closest('tr').find('.delete_dev').val();
        
        swal({
            title: "Reject request ?",
            text: "do you want to reject this request.",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'rejectStockTransferServlet',
                        data: {
                        id: idd
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Rejected!",
                                text: "you just reject request.",
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
                                    title: "The Request Accepted !",
                                    text: "Your request accepted before.",
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
                        
                    } else {
                        swal({
                        title: "Cancelled !",
                        text: "you cancelled the process.",
                        icon: "error",
                        button: "OK"
                        });
                    }
            });
        
    });
    
    
           
        </script>

    </body>
</html>