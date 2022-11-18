<%@page import="resources.CustomerType"%>
<%@page import="java.util.Collections"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Account"%>
<%@page import="resources.CustomerTypeCustomer"%>
<%@page import="resources.Settings"%>
<%@page import="resources.Category"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<<%@page import="org.hibernate.Session"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%
            if (request.getSession().getAttribute("administrator") == null) {
                response.sendRedirect("login.jsp");
            }
            int id=0;
            if(request.getParameter("c") != null  && !request.getParameter("c").equals("")){
                id=Integer.parseInt(request.getParameter("c"));
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
                        <li class="breadcrumb-item" style="font-size: 16px;"><a href="account.jsp"><i class="fa fa-arrow-left"></i> Back</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Customer Category</li>
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
                                        <div class="form-group col-sm-8">
                                        <label for="inputEmail3" class="col-sm-4 control-label">CUSTOMER :</label>

                                        <div class="col-sm-12">
                                            <select  class="form-control"   name="cust" id="cust">
                                                 <%  
                                                        Session s2 = connection.getConnection.getSessionFactory().openSession();
                                                        Criteria cr6 = s2.createCriteria(Account.class);
                                                        cr6.add(Restrictions.eq("status", 1));
                                                        cr6.add(Restrictions.eq("customer", 1));
                                                        List<Account> c6 = cr6.list();
                                                        Collections.reverse(c6);
                                                        if (c6.size() > 0) {
                                                            for (Account  B : c6) {
                                                    %>
                                                    <option value="<%=B.getIdaccount()%>"><%=B.getName()%></option>
                                                    <%

                                                        }

                                                    } else {
                                                    %>
                                                    <option> PLEASE ADD CUSTOMER FIRST</option>
                                                    <%
                                                        }
                                                    

                                                    %>  
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-4">
                                        <label for="inputEmail3" class="col-sm-12 control-label">CUSTOMER CATEGORY :</label>

                                        <div class="col-sm-12">
                                            <select  class="form-control"   name="cat" id="cat">
                                                <%  
                                                        Session s3 = connection.getConnection.getSessionFactory().openSession();
                                                        Criteria cr7 = s3.createCriteria(CustomerType.class);
                                                        cr7.add(Restrictions.eq("status", 1));
                                                        List<CustomerType> c7 = cr7.list();
                                                        Collections.reverse(c7);
                                                        if (c7.size() > 0) {
                                                            for (CustomerType  B : c7) {
                                                    %>
                                                    <option value="<%=B.getCustomerTypeId()%>"><%=B.getName().toUpperCase() %></option>
                                                    <%

                                                        }

                                                    } else {
                                                    %>
                                                    <option> PLEASE ADD TYPE FIRST</option>
                                                    <%
                                                        }
                                                    

                                                    %> 
                                            </select>
                                        </div>
                                    </div>
                                            <button  id="save_dev" type="button"  class="btn btn-info btn-sm save_dev" style="margin-left: 30px;">ADD TO CATEGORY</button>
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
                                <tr style="background-color: #10ac84 !important; color: white !important; ">
                                    <th id="dev_id" class="dev_id" >CUSTOMER</th>
                                    <th>CATEGORY</th>
                                    <th>STATUS</th>
                                    <th></th>
                                    


                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(CustomerTypeCustomer.class);
                                    List<CustomerTypeCustomer> de = cr.list();
                                    
                                    
                                    if (de.size() > 0) {
                                        for ( CustomerTypeCustomer DE : de) {


                                %>
                                <tr>
                                    <td><%=DE.getAccount().getName().toUpperCase() %></td>
                                    <td><%=DE.getCustomerType().getName().toUpperCase() %></td>
                                    
                                    <%
                                        if (DE.getStatus() == 1) {
                                    %>
                                    <td><span class="badge bg-info">Active</span></td>
                                    <%
                                    } else {
                                    %>
                                    <td><span class="badge bg-danger ">Deleted</span></td>
                                    <%
                                        }
                                    %>
                                    

                                    <td>
                                        <button class="btn btn-warning btn-sm delete_dev" id="delete_dev"  value="<%=DE.getIdcustomerTypeCustomer()%>">Delete | Reset</button>
                                        <input type="hidden" name="stat" id="stat" class="stat" value= "<%= DE.getStatus() %>"/>
                                        
                                        &nbsp; &nbsp;
                                        <input type="hidden" name="u_name" id="u_name" class="u_name" value= "<%= DE.getIdcustomerTypeCustomer() %>"/>
                                        <button  class="btn btn-success btn-sm update_dev"  id="update_dev" value="<%=DE.getIdcustomerTypeCustomer()%>">Update</button>
                                        
                                        
                                        


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



            


        </main>

       <div class="modal fade" id="myModal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Update Customer Category Details</h5>
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
                                            <select  class="form-control"   name="col_4" id="col_4">
                                                <%  
                                                        Session s = connection.getConnection.getSessionFactory().openSession();
                                                        Criteria cr8 = s.createCriteria(CustomerType.class);
                                                        cr8.add(Restrictions.eq("status", 1));
                                                        List<CustomerType> c8 = cr8.list();
                                                        Collections.reverse(c8);
                                                        if (c8.size() > 0) {
                                                            for (CustomerType  B : c8) {
                                                    %>
                                                    <option value="<%=B.getCustomerTypeId()%>"><%=B.getName()%></option>
                                                    <%

                                                        }

                                                    } else {
                                                    %>
                                                    <option> PLEASE ADD TYPE FIRST</option>
                                                    <%
                                                        }
                                                    s.close();

                                                    %> 
                                            </select>
                                            <input type="hidden" name="col_1" id="col_1">
                                        </div>
                                    </div>
                                    
                                    
                                    
                                </div>
                                <input type="hidden" name="col_4" id="col_4" class="col_" />
                                
                            </form>
                          
                        </div>
             <button  id="update_model" type="button"  class="btn btn-info col-sm-3 mt-2 update_model">UPDATE</button>             
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-dangert" data-dismiss="modal">Close</button>
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
                $('#table1').DataTable();
            });
            
            var cust_id=<%=id%>;
            if(cust_id > 0){
             $('#cust').val(cust_id);
              $("#cust").prop("disabled", true);
                $('#cat').focus();
                
            }else{
                $("#cust").prop("disabled", false);
            }
            
            $(".update_dev").click(function () {
        
         var id=$(this).closest('tr').find('.update_dev').val(); 
         var nam=$(this).closest('tr').find('.u_name').val(); 
         
         document.getElementById("col_1").value = ""+id;
         document.getElementById("col_4").value = ""+nam;
         
         
         
         $("#myModal").modal();


        
       
        
    });
    
    $(".update_model").click(function () {
        
        var id=$('input[name="col_1"]').val();
        var t=$('#col_4').find(":selected").val();
       
        
       
        
        swal({
            title: "Update category ?",
            text: "do you want to update customer category? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'updateCustomerCategoryServlet',
                        data: {
                        id: id,
                        type: t,
                        
                        
                        
                        
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you updated customer category !",
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
            text: "do you want to "+name+ " customer category ? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'deleteCustomerCategoryServlet',
                        data: {
                        id: idd
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you "+name+ " category !",
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
            url: 'saveCustomerCategoryServlet',
            data: {
                cust: $('#cust').find(":selected").val(),
                cat: $('#cat').find(":selected").val()
                
                

            },
            type: 'post',
            cache: false,
            success: function (data) {
                if (data === "1") {

                    swal({
                                title: "Good job!",
                                text: "you add new category to customer !",
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
                        
                        else if (data === "4") {
                                swal({
                                    title: "Alredy In Category !",
                                    text: "You selected customer alredy is in Category",
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