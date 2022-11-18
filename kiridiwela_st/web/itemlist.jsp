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
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">Item list</li>
                    </ol>
                </nav>
            </div>

            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-bordered" id="tbl1">
                            <thead>
                                <tr>
                                    <th style="background-color: #10ac84 !important; color: white !important; " id="dev_id" class="dev_id" >ITEM ID</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">BARCODE / IMEI</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">NAME</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">STATUS</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">IMAGE</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; "></th>


                                </tr>
                            </thead>
                            <tbody>
                                <%                                    
                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(Items.class);
                                    cr.add(Restrictions.eq("status", 1)); 
                                    List<Items> de = cr.list();

                                    if (de.size() > 0) {
                                        for (Items DE : de) {


                                %>
                                <tr>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><%=DE.getItemId()%></td>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><%=DE.getBarcodeId()%></td>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><%=DE.getName() %></td>
                                    <%
                                        if (DE.getStatus() == 1) {
                                    %>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><span class="badge bg-info">Active</span></td>
                                    <%
                                    } else {
                                    %>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><span class="badge bg-danger ">Deleted</span></td>
                                    <%
                                        }
                                    %>
                                    <%
                                        if (DE.getImage().split("\\.").length == 2) {
                                           
                                    %>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><img class="img-ez" src="itemimage/<%=DE.getImage() %>" id="profile-img-tag" width="100px"/></td>
                                   
                                    <%
                                    } else {
                                    %>
                                    <td style="border-bottom: #2d3436 solid 1px !important;"><div><img class="img-ez"  src="src/image/no_image.jpg" id="profile-img-tag" width="100px"/></div></td>
                                    <%
                                        }
                                    %>
                                     

                                    <td style="border-bottom: #2d3436 solid 1px !important;">
                                        <button class="btn btn-warning btn-sm delete_dev mt-1" id="delete_dev"  value="<%=DE.getItemId()%>">DELETE</button>
                                        <input type="hidden" name="stat" id="stat" class="stat" value= "<%= DE.getStatus()%>"/>
                                        <input type="hidden" name="devid" id="devid" class="devid" value= "<%= DE.getItemId()%>"/>

                                        &nbsp;

                                        <a  class="btn btn-info btn-sm update_devA mt-1"  id="update_devA" href="updateitem.jsp?i=<%=DE.getItemId()%>" value="">UPDATE</a>
                                        <input type="hidden" name="i_id" id="i_id" class="i_id" value= "<%= DE.getItemId()%>"/>
                                        <input type="hidden" name="i_name" id="i_name" class="i_name" value= "<%= DE.getName()%>"/>
                                        <input type="hidden" name="i_bar" id="i_bar" class="i_bar" value= "<%= DE.getBarcodeId()%>"/>
                                        <input type="hidden" name="i_type" id="i_type" class="i_type" value= "<%= DE.getType().getId()%>"/>
                                        <input type="hidden" name="i_category" id="i_category" class="i_category" value= "<%= DE.getCategory().getIdcategory()%>"/>
                                        <input type="hidden" name="i_brand" id="i_brand" class="i_brand" value= "<%= DE.getBrand().getIdbrand()%>"/>
                                        <input type="hidden" name="i_sup" id="i_sup" class="i_sup" value= "<%= DE.getAccount().getIdaccount()%>"/>
                                        &nbsp;
                                        <button  class="btn btn-success btn-sm view_dev mt-1"  id="view_dev" value="<%=DE.getItemId()%>">VIEW</button>



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
            </div>

        </main>



        <!-- include header-->
        <jsp:include page="includes/footer.jsp" />
        <!-- include header-->


        <!-- Modal update -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">update item details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <form action="" method="post">
                            <div class="card-body">
                                <input type="hidden"  name="col_1" id="col_1">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-6 control-label">Name:</label>

                                    <div class="">
                                        <input type="text" class="form-control"  placeholder="Item name" name="col_2" id="col_2">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label  class="col-sm-6 control-label">Barcode ID:</label>

                                    <div class="">
                                        <input type="text" class="form-control"  placeholder="Barcode ID" name="col_3" id="col_3">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label  class="col-sm-6 control-label">Measuring  Type :</label>
                                    <select  class="form-control"  placeholder="contact number" name="col_4" id="col_4" >
                                        <%
                                            Session ses1 = connection.getConnection.getSessionFactory().openSession();
                                            Criteria cr3 = ses1.createCriteria(Type.class);
                                            cr3.add(Restrictions.eq("status", 1));
                                            List<Type> d = cr3.list();
                                            if (d.size() > 0) {
                                                for (Type B : d) {
                                        %>
                                        <option value="<%=B.getId()%>"><%=B.getName()%></option>
                                        <%

                                            }

                                        } else {
                                        %>
                                        <option>Please Add Type First</option>
                                        <%
                                            }

                                        %>
                                    </select>

                                </div>
                                <div class="form-group">
                                    <label for="inputPassword3" class="col-sm-6 control-label">Brand:</label>

                                    <select type="" class="form-control"  placeholder="" name="col_5" id="col_5">
                                        <%                                                        Criteria cr6 = ses1.createCriteria(Brand.class);
                                            cr6.add(Restrictions.eq("status", 1));
                                            List<Brand> b = cr6.list();
                                            if (b.size() > 0) {
                                                for (Brand B : b) {
                                        %>
                                        <option value="<%=B.getIdbrand()%>"><%=B.getName()%></option>
                                        <%

                                            }

                                        } else {
                                        %>
                                        <option>Please Add Brand First</option>
                                        <%
                                            }

                                        %>

                                    </select>

                                </div>

                                

                                <div class="form-group">
                                    <label for="inputPassword3" class="col-sm-6 control-label">Supplier:</label>

                                    <select type="number" class="form-control"  placeholder="contact number" name="col_7" id="col_7">
                                        <%                                                        Criteria cr4 = ses1.createCriteria(Account.class);
                                            cr4.add(Restrictions.eq("status", 1));
                                            List<Account> e = cr4.list();
                                            if (e.size() > 0) {
                                                for (Account B : e) {
                                        %>
                                        <option value="<%=B.getIdaccount()%>"><%=B.getName()%></option>
                                        <%

                                            }

                                        } else {
                                        %>
                                        <option>Please Add Supplier First</option>
                                        <%
                                            }

                                            ses1.close();

                                        %>
                                    </select>

                                </div>

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-6 control-label">Cost:</label>

                                    <div class="">
                                        <input type="number" class="form-control d-none"  placeholder="cost per item" name="col_8" id="col_8">
                                    </div>
                                </div>


                            </div>



                        </form>
                                    <button  id="update_model" type="button"  class="btn btn-dark update_model">UPDATE</button>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal view-->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">item details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row " id="acc_details" >

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.colVis.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="src/js/EZView.js"></script>
        <script src="src/js/draggable.js"></script>
        <script>
            $(window).load(function(){
                $('.loader').fadeOut();
            });
        </script>
        <script type="text/javascript">


            $(document).ready(function () {
                $('.img-ez').EZView();

              
            });
            
    $(document).ready(function() {
        $('#tbl1').DataTable();
    });

       $(".view_dev").click(function () {
        var id=$(this).closest('tr').find('.view_dev').val(); 
        $.ajax({
                        url: 'getItemServlet',
                        data: {
                        id: id
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                          document.getElementById("acc_details").innerHTML=""+data;
                        
                    },error: function () {
                        
                        document.getElementById("acc_details").innerHTML="<p>NO DATA RECIVED !</p>";
                    }
            
        
        });
        
        $("#myModal2").modal();
        
    });
    
    $(".update_dev").click(function () {
        
        
         var id=$(this).closest('tr').find('input[name="i_id"]').val();
         var barcode=$(this).closest('tr').find('input[name="i_bar"]').val();
         var name=$(this).closest('tr').find('input[name="i_name"]').val();
         var type=$(this).closest('tr').find('input[name="i_type"]').val();
         var cost=$(this).closest('tr').find('input[name="i_cost"]').val();
         var sup=$(this).closest('tr').find('input[name="i_sup"]').val();
         var brand=$(this).closest('tr').find('input[name="i_brand"]').val();
         var category=$(this).closest('tr').find('input[name="i_category"]').val();
         
         
        
         document.getElementById("col_1").value = ""+id;
         document.getElementById("col_2").value = ""+name;
         document.getElementById("col_3").value = ""+barcode;
         document.getElementById("col_4").value = ""+type;
         document.getElementById("col_5").value = ""+brand;
         document.getElementById("col_6").value = ""+category;
         document.getElementById("col_7").value = ""+sup;
         document.getElementById("col_8").value = ""+cost;
         
         
         
         
         
         $("#myModal").modal();


        
       
        
    });
    
    
    $(".update_model").click(function () {
        
         var id=$('input[name="col_1"]').val();
         var barcode=$('input[name="col_3"]').val();
         var name=$('input[name="col_2"]').val();
         var type=$('select[name="col_4"]').val();
         var cost=$('input[name="col_8"]').val();
         var sup=$('select[name="col_7"]').val();
         var brand=$('select[name="col_5"]').val();
         var category=$('select[name="col_6"]').val();
        
       
        
        swal({
            title: "Are you sure?",
            text: "do you want to update Item details? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'updateItemServlet',
                        data: {
                        id: id,
                        name:name,
                        barcode:barcode,
                        cost:cost,
                        sup:sup,
                        brand:brand,
                        category:category,
                        type:type
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you update Customer from list !",
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
                        else if (data === "4") {
                            swal({
                                title: "Barcode ID Alredy In Use !",
                                text: "You can't add same barcode id again.",
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
            text: "do you want to "+name+ " Item ? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'deleteItemServlet',
                        data: {
                        id: idd
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you "+name+ " Item from list !",
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


        </script>


    </body>
</html>