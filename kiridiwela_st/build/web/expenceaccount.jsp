<%@page import="resources.ExpencessAccount"%>
<%@page import="resources.Settings"%>
<%@page import="resources.Category"%>
<%@page import="java.util.List"%>
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

        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
        <link href="src/css/style.css" rel="stylesheet">
        <style>
            .form-control{
                outline: none !important; 
                border: 1px solid #636e72;
                color: #636e72;

            }
            .form-control:focus {
                outline: none !important;
                border:1px solid #2980b9;
                box-shadow: 0 0 10px #2980b9;
            }
            .form-control::placeholder { /* Most modern browsers support this now. */
               color:    #636e72;
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
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Create Expenses Account</li>
                    </ol>
                </nav>
            </div>
            
            <!-- Main content -->

            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" >

                    <div class="card-body">
                        <table id="table1" class="table table-sm">

                            <thead>
                                <tr style="background-color: #10ac84 !important; color: white !important; ">
                                    <th id="dev_id" class="dev_id" >ACCOUNT ID</th>
                                    <th>NAME</th>
                                    <th>BRANCH</th>
                                    <th>STATUS</th>
                                    <th>OPTION</th>
                                    


                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(ExpencessAccount.class);
                                    List<ExpencessAccount> de = cr.list();
                                    
                                    
                                    if (de.size() > 0) {
                                        for ( ExpencessAccount DE : de) {


                                %>
                                <tr>
                                    <td style="border: #636e72 solid 1px !important;"><%=DE.getIdexpencessAccount()%></td>
                                    <td style="border: #636e72 solid 1px !important;"><%=DE.getName() %></td>
                                    <td style="border: #636e72 solid 1px !important;"><%=DE.getBranch().getName() %></td>
                                    
                                    <%
                                        if (DE.getStatus() == 1) {
                                    %>
                                    <td style="border: #636e72 solid 1px !important;"><span class="badge bg-info">Active</span></td>
                                    <%
                                    } else {
                                    %>
                                    <td style="border: #636e72 solid 1px !important;"><span class="badge bg-danger ">Deleted</span></td>
                                    <%
                                        }
                                    %>
                                    

                                    <td style="border: #636e72 solid 1px !important;">
                                        <button class="btn btn-warning btn-sm delete_dev" id="delete_dev"  value="<%=DE.getIdexpencessAccount()%>">Delete | Reset</button>
                                        <input type="hidden" name="stat" id="stat" class="stat" value= "<%= DE.getStatus() %>"/>
                                        
                                        &nbsp; &nbsp;
                                        <input type="hidden" name="u_name" id="u_name" class="u_name" value= "<%= DE.getName() %>"/>
                                        <button  class="btn btn-info btn-sm update_dev"  id="update_dev" value="<%=DE.getIdexpencessAccount()%>">Update</button>
                                        
                                        
                                        


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

            </div><!-- /.container-fluid -->      



            <div class="row mt-2">

                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <!-- form start -->
                        <form action="" method="post">
                            <div class="row">
                                <div class="col-md-10">
                                <div class="card-body">
                                    <div class="form-inline">
                                        <label for="inputEmail3" class="col-md-2 control-label">Account Name:</label>

                                            <input type="text" class="form-control col-md-7 mr-1" id="inputEmail3" placeholder="Account Name" name="ename" id="ename">
                                        
                                        <button  id="save_dev" type="button"  class="btn btn-info save_dev">ADD NEW</button>
                                    </div>
                                     
                                </div>
                                </div>
                                <div class="col-md-3">
                                   
                                </div>
                            </div>
                        </form>
                        
                    </div>

                </div>
                



            </div>


        </main>

       <div class="modal fade" id="myModal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Update Expenses Account Details</h5>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          
        </div>
        <div class="modal-body">
            <div class="card">
                            
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form action="" method="post">
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-4 control-label">Name:</label>

                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="col_1" placeholder="account name" name="col_1" >
                                        </div>
                                    </div>
                                    
                                    
                                    
                                </div>
                                <input type="hidden" name="col_4" id="col_4" class="col_" />
                                
                            </form>
                          
                        </div>
             <button  id="update_model" type="button"  class="btn btn-dark col-sm-3 mt-2 update_model">UPDATE</button>             
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
         <script>
            $(window).load(function(){
                $('.loader').fadeOut();
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                 $('#table1').dataTable({bFilter: false, bInfo: false,lengthChange : false});
            });
            
            $(".update_dev").click(function () {
        
         var id=$(this).closest('tr').find('.update_dev').val(); 
         
         var name=$(this).closest('tr').find('input[name="u_name"]').val();
         
         
         document.getElementById("col_1").value = ""+name;
         document.getElementById("col_4").value = ""+id;
         
         
         
         $("#myModal").modal();


        
       
        
    });
    
    $(".update_model").click(function () {
        
        var id=$('input[name="col_4"]').val();
        var name=$('input[name="col_1"]').val();
       
        
       
        
        swal({
            title: "Are you sure?",
            text: "do you want to update Account Details? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'updateExpensesAccountServlet',
                        data: {
                        id: id,
                        name:name,
                        
                        
                        
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you update Account Name from list !",
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
                        
                        
                    },
                    error: function () {
                            swal({
                            title: "Something Went Wrong !",
                            text: "something wrong in updating data please retry.",
                            icon: "error",
                            button: "OK"
                   });
            }
        }
        );
                        
                    } else {
                        swal({
                        title: "Cancelled !",
                        text: "you cancelled updating process.",
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
            text: "do you want to "+name+ " Expenses Account ? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'deleteExpensesAccountServlet',
                        data: {
                        id: idd
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you "+name+ " Expenses Account from list !",
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
    
    $("#save_dev").click(function () {

        $.ajax({
            url: 'saveExpensesAccountServlet',
            data: {
                name: $('input[name="ename"]').val()
                
                

            },
            type: 'post',
            cache: false,
            success: function (data) {
                if (data === "1") {

                    swal({
                                title: "Good job!",
                                text: "you add new category to list !",
                                icon: "success",
                                button: "OK"
                            }).then((value) => {
                                    location.reload();
                                
                          });
                    
                    $('input[name="ename"]').val("")
                    
                    
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
           
        </script>

    </body>
</html>