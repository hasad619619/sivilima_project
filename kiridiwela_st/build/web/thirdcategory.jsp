<%@page import="resources.SubCategory"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.ThirdCategory"%>
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
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Other Category</li>
                    </ol>
                </nav>
            </div>
            
            <!-- Main content -->

            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" >

                    <div class="card-body">
                        <table id="table1" class="table">

                            <thead>
                                <tr style="background-color: #10ac84 !important; color: white !important; ">
                                    <th id="dev_id" class="dev_id" >Category ID</th>
                                    <th>name</th>
                                    <th>Sub Category</th>
                                    <th>status</th>
                                    <th>option</th>
                                    


                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(ThirdCategory.class);
                                    List<ThirdCategory> de = cr.list();
                                    
                                    
                                    if (de.size() > 0) {
                                        for ( ThirdCategory DE : de) {


                                %>
                                <tr>
                                    <td><%=DE.getThirdcategoryId() %></td>
                                    <td><%=DE.getName() %></td>
                                    <td><%=DE.getSubCategory().getName() %></td>
                                    
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
                                        <button class="btn btn-warning btn-sm delete_dev" id="delete_dev"  value="<%=DE.getThirdcategoryId() %>">Delete | Reset</button>
                                        <input type="hidden" name="stat" id="stat" class="stat" value= "<%= DE.getStatus() %>"/>
                                        
                                        &nbsp; &nbsp;
                                        <input type="hidden" name="u_name" id="u_name" class="u_name" value= "<%= DE.getName() %>"/>
                                        <input type="hidden" name="u_subcat" id="u_subcat" class="u_subcat" value= "<%= DE.getSubCategory().getSubcategoryId() %>"/>
                                        <button  class="btn btn-info btn-sm update_dev"  id="update_dev" value="<%=DE.getThirdcategoryId()%>">Update</button>
                                        
                                        
                                        


                                    </td>
                                </tr>

                                <%
                                        }

                                    }
                                    ses.close();


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
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">Category:</label>

                                        <div class="col-sm-10">
                                            <select type="number" class="form-control"    name="sct" id="sct">
                                                    <%  
                                                        Session s = connection.getConnection.getSessionFactory().openSession();
                                                        Criteria cr5 = s.createCriteria(SubCategory.class);
                                                        cr5.add(Restrictions.eq("status", 1));
                                                        List<SubCategory> c5 = cr5.list();
                                                        if (c5.size() > 0) {
                                                            for (SubCategory B : c5) {
                                                    %>
                                                    <option value="<%=B.getSubcategoryId()%>"><%=B.getName()%></option>
                                                    <%

                                                        }

                                                    } else {
                                                    %>
                                                    <option>Please Add Sub Category First</option>
                                                    <%
                                                        }
                                                    s.close();

                                                    %>
                                                </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">Name:</label>

                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="inputEmail3" placeholder="Other Category name" name="ename" id="ename">
                                        </div>
                                    </div>
                                    
                                </div>
                            </form>
                        <button  id="save_dev" type="button"  class="btn btn-info save_dev">ADD NEW</button>
                    </div>

                </div>
                



            </div>


        </main>

       <div class="modal fade" id="myModal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Update Other Category Details</h5>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          
        </div>
        <div class="modal-body">
            <div class="card">
                            
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form action="" method="post">
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-4 control-label">Category:</label>

                                        <div class="col-sm-10">
                                            <select type="number" class="form-control"    name="sct2" id="sct2">
                                                    <%  
                                                        Session s2 = connection.getConnection.getSessionFactory().openSession();
                                                        Criteria cr6 = s2.createCriteria(SubCategory.class);
                                                        cr6.add(Restrictions.eq("status", 1));
                                                        List<SubCategory> c6 = cr6.list();
                                                        if (c6.size() > 0) {
                                                            for (SubCategory B : c6) {
                                                    %>
                                                    <option value="<%=B.getSubcategoryId()%>"><%=B.getName()%></option>
                                                    <%

                                                        }

                                                    } else {
                                                    %>
                                                    <option>Please Add Sub Category First</option>
                                                    <%
                                                        }
                                                    s2.close();

                                                    %>
                                                </select>
                                        </div>
                                    </div>
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
         var cat=$(this).closest('tr').find('input[name="u_subcat"]').val();
         
         
         document.getElementById("col_1").value = ""+name;
         document.getElementById("col_4").value = ""+id;
         document.getElementById("sct2").value = ""+cat;
         
         
         
         $("#myModal").modal();


        
       
        
    });
    
    $(".update_model").click(function () {
        
        var id=$('input[name="col_4"]').val();
        var name=$('input[name="col_1"]').val();
        var cat=$('#sct2').find(":selected").val();
       
        
        
       
        
        swal({
            title: "Are you sure?",
            text: "do you want to update Other Category details? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'updateThirdCategoryServlet',
                        data: {
                        id: id,
                        name:name,
                        cat:cat
                        
                        
                        
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you update Other Category from list !",
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
            text: "do you want to "+name+ "other category ? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'deleteThirdCategoryServlet',
                        data: {
                        id: idd
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you "+name+ " other category from list !",
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
            url: 'saveThirdCategoryServlet',
            data: {
                name: $('input[name="ename"]').val(),
                sct: $('#sct').find(":selected").val()
                
                

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