<%@page import="java.util.Set"%>
<%@page import="javax.mail.FetchProfile.Item"%>
<%@page import="resources.Items"%>
<%@page import="resources.ItemReorder"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.SubCategory"%>
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
        
        <%
            if(request.getParameter("q") != null && !request.getParameter("q").equals("0")){
            
                try{
                    
                Session ses = connection.getConnection.getSessionFactory().openSession();
                Items ITEM = null;
                ITEM = (Items) ses.load(Items.class,Integer.parseInt(request.getParameter("q")));
                Set<ItemReorder> de= ITEM.getItemReorders();
             
            %>

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->

        <div class="loader"></div>

        <main role="main" class="container">
            
            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-arrow-left"></span>&nbsp;<a href="inventory.jsp">Back</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Item Re order level Setup</li>
                    </ol>
                </nav>
            </div>
            
            <!-- Main content -->
            <%
            if (de.size() > 0) {
            %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" >

                    <div class="card-body">
                        <table id="table1" class="table">

                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Re Order Level</th>
                                    <th>Add if QTY Empty</th>
                                    <th>Add if ROL Passed</th>
                                    <th>option</th>
                                    


                                </tr>
                            </thead>
                            <tbody>
                                <%
                               for ( ItemReorder DE : de) {
                                %>
                                <tr>
                                    <td><%=DE.getItems().getName()+"("+DE.getItems().getType().getName()+")" %></td>
                                    <td><%=DE.getRol()%></td>
                                    <td><%=DE.getAddIsEmpty() %></td>
                                    <td><%=DE.getAddReOrderPassed() %></td>
                                    <td>
                                        <% if(DE.getStatus() == 1){ %>
                                            
                                        
                                        <button class="btn btn-danger btn-sm delete_dev" id="delete_dev"  value="<%=DE.getIditemReorder()%>">DEACTIVATE</button>
                                        
                                        <% }else { %>
                                            
                                        
                                        <button class="btn btn-success btn-sm delete_dev" id="delete_dev"  value="<%=DE.getIditemReorder()%>">ACTIVATE</button>
                                        
                                        <% } %>
                                        <input type="hidden" name="stat" id="stat" class="stat" value= "<%= DE.getStatus() %>"/>
                                        <input type="hidden" name="u_item" id="u_item" class="u_item" value= "<%=DE.getItems().getName() %>"/>
                                        <input type="hidden" name="u_rol" id="u_rol" class="u_rol" value= "<%=DE.getRol() %>"/>
                                        <input type="hidden" name="u_empty" id="u_empty" class="u_empty" value= "<%=DE.getAddIsEmpty() %>"/>
                                        <input type="hidden" name="u_rolp" id="u_rolp" class="u_rolp" value= "<%=DE.getAddReOrderPassed() %>"/>
                                        <button  class="btn btn-info btn-sm update_dev"  id="update_dev" value="<%=DE.getIditemReorder()%>">UPDATE</button>
                                        
                                        
                                        


                                    </td>
                                </tr>

                                <%
                                        }
                                %>
                            </tbody>
                        </table>

                    </div>


                </div>

            </div>
            <%
            }else{
            %>



            <div class="row mt-2">

                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <!-- form start -->
                        <form action="" method="post">
                                <div class="card-body">
                                    <div class="row">
                                        
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                <label for="inputEmail3" class="col-sm-2 control-label">ITEM:</label>
                                                <div class="col-sm-12">
                                                    <input type="tetx" class="form-control" id="inputEmail3" disabled="" value="<%=ITEM.getName() %>">
                                                </div>
                                                <input type="hidden" class="form-control"    name="ct" id="ct" value="<%=ITEM.getItemId() %>">    
                                                </div>
                                                <div class="form-group">
                                                    <label for="inputEmail3" class="col-sm-2 control-label">ROL:</label>

                                                    <div class="col-sm-12">
                                                        <input type="number" class="form-control" id="inputEmail3" placeholder="RE OREDR LEVEL" name="ename" id="ename">
                                                    </div>
                                                </div>    
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="inputEmail3" class="col-sm-4 control-label">ADD IF EMPTY:</label>

                                                    <div class="col-sm-12">
                                                        <input type="number" class="form-control" id="inputEmail3" placeholder="ADD IF EMPTY" name="empty" id="empty">
                                                    </div>
                                                </div> 
                                                <div class="form-group">
                                                    <label for="inputEmail3" class="col-sm-6 control-label">ADD IF ROL PASSED:</label>

                                                    <div class="col-sm-12">
                                                        <input type="number" class="form-control" id="inputEmail3" placeholder="ADD IF ROL PASSED" name="rol" id="rol">
                                                    </div>
                                                </div> 
                                            </div>
                                        
                                    </div>
                                    
                                    
                                </div>
                            </form>
                        <button  id="save_dev" type="button"  class="btn btn-info  save_dev">SAVE</button>
                    </div>

                </div>
                



            </div>
            <%
            }
            %>

        </main>

       <div class="modal fade" id="myModal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Upate Re order level Settings</h5>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          
        </div>
        <div class="modal-body">
            <div class="card">
                            
                            <!-- /.card-header -->
                            <!-- form start -->
                            <form action="" method="post">
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-4 control-label">ITEM NAME:</label>

                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="col_1" disabled="" name="col_1" >
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-4 control-label">ROL:</label>

                                        <div class="col-sm-10">
                                            <input type="number" class="form-control" id="col_2" placeholder="ROL" name="col_2" >
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-4 control-label">ADD IF EMPTY:</label>

                                        <div class="col-sm-10">
                                            <input type="number" class="form-control" id="col_3" placeholder="ADD IF EMPTY" name="col_3" >
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-4 control-label">IF ROL PASSED:</label>

                                        <div class="col-sm-10">
                                            <input type="number" class="form-control" id="col_4" placeholder="IF ROL PASSED" name="col_4" >
                                        </div>
                                    </div>
                                    
                                    
                                    
                                    
                                </div>
                                <input type="hidden" name="col_5" id="col_5" class="col_5" />
                                
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
         
         var name=$(this).closest('tr').find('input[name="u_item"]').val();
         var rol=$(this).closest('tr').find('input[name="u_rol"]').val();
         var empty=$(this).closest('tr').find('input[name="u_empty"]').val();
         var rolp=$(this).closest('tr').find('input[name="u_rolp"]').val();
         
         
         document.getElementById("col_1").value = ""+name;
         document.getElementById("col_2").value = ""+rol;
         document.getElementById("col_3").value = ""+empty;
         document.getElementById("col_4").value = ""+rolp;
         document.getElementById("col_5").value = ""+id;
         
         
         
         
         $("#myModal").modal();


        
       
        
    });
    
    $(".update_model").click(function () {
        
            var id=$('input[name="col_5"]').val();
            var name=$('input[name="col_1"]').val();
            var rol=$('input[name="col_2"]').val();
            var empty=$('input[name="col_3"]').val();
            var rolp=$('input[name="col_4"]').val();
        
       
        
        swal({
            title: "Are you sure?",
            text: "do you want to update ROL details? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'updateROLServlet',
                        data: {
                        id: id,
                        name:name,
                        rol:rol,
                        empty:empty,
                        rolp:rolp
                        
                        
                        
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you update ROL list !",
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
            
            name="Deactivate";
        }else{
            
            name="Activate";
            
        }
        
        swal({
            title: "Are you sure?",
            text: "do you want to "+name+ " ROL ? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'deleteROLServlet',
                        data: {
                        id: idd
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you "+name+ " ROL from list !",
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
            url: 'saveROLServlet',
            data: {
                name: $('input[name="ename"]').val(),
                rol: $('input[name="rol"]').val(),
                empty: $('input[name="empty"]').val(),
                ct: $('input[name="ct"]').val()
                
                

            },
            type: 'post',
            cache: false,
            success: function (data) {
                if (data === "1") {

                    swal({
                                title: "Good job!",
                                text: "you update ROL Settings !",
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
                                    title: "Alredy Updated !",
                                    text: "ROL Settings in selected Item Alredy Added ! Please Update It",
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
    <%
        }catch(Exception e){
            response.sendRedirect("inventory.jsp");
        }
      }else{
        response.sendRedirect("inventory.jsp");
      } 
            %>
</html>