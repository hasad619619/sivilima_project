<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Settings"%>
<%@page import="resources.Items"%>
<%@page import="resources.TypeCalc"%>
<%@page import="resources.Type"%>
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
                        <li class="breadcrumb-item" style="font-size: 16px;"><a href="settings.jsp" ><i class="fa fa-arrow-left"></i> Back</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">Measuring Equation</li>
                    </ol>
                </nav>
            </div>

            <!-- Main content -->

            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" >

                    <div class="card-body">
                        <table id="table1" class="table">

                            <thead>
                                <tr>
                                    <th id="dev_id" class="dev_id" >Equation ID</th>
                                    <th>Type 01</th>
                                    <th>Equation</th>
                                    <th>Type 02</th>
                                    <th>Item</th>
                                    <th>Option</th>



                                </tr>
                            </thead>
                            <tbody>
                                <%                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(TypeCalc.class);
                                    List<TypeCalc> de = cr.list();

                                    if (de.size() > 0) {
                                        for (TypeCalc DE : de) {


                                %>
                                <tr>
                                    <td><%=DE.getIdtypeCalc()%></td>
                                    <td><%= "(1)"+DE.getTypeByType1().getName() + " (X)"%></td>
                                    <td><%=DE.getFormula() + " (=)"%></td>
                                    <td><%="(1)"+DE.getTypeByType2().getName()%></td>
                                    <td><%=DE.getItems().getName()%></td>




                                    <td>
                                        <button class="btn btn-danger btn-sm delete_dev" id="delete_dev"  value="<%=DE.getIdtypeCalc()%>">Delete</button>

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
                        <form action="" method="post">
                            <div class="input-group ">
                                <div class="input-group col-sm-4 ">
                                    <div class="input-group-prepend">
                                        <label class="input-group-text" for="ba">Type one</label>
                                    </div>
                                    <%                                        
                                        Session se = connection.getConnection.getSessionFactory().openSession();
                                        Criteria cr2 = se.createCriteria(Type.class);

                                        List<Type> sup = cr2.list();
                                    %>
                                    <select class="form-control" id="ty1">
                                        <option value="0">PLEASE SELECT</option>
                                        <%
                                            if (sup.size() > 0) {
                                                for (Type P : sup) {
                                        %>

                                        <option value="<%=P.getId()%>"><%=P.getName()%></option>
                                        <%

                                            }

                                        } else {
                                        %>
                                        <option selected>NO TYPE FOUND</option>
                                        <% }
                                            se.close(); %>
                                    </select>

                                    <div class="input-group-prepend">
                                        <label class="input-group-text" for="ba">(x)</label>
                                    </div>


                                </div>
                            </div>

                            <div class="input-group mt-2">
                                <div class="input-group col-sm-4 ">
                                    <div class="input-group-prepend">
                                        <label class="input-group-text" for="ba">Formula&nbsp;&nbsp;</label>
                                    </div>
                                    <input class="form-control" id="formula" name="formula">

                                    <div class="input-group-prepend">
                                        <label class="input-group-text" for="ba">(=)</label>
                                    </div>


                                </div>
                            </div>

                            <div class="input-group mt-2">
                                <div class="input-group col-sm-4 ">
                                    <div class="input-group-prepend">
                                        <label class="input-group-text" for="ba">Type two</label>
                                    </div>
                                    <%
                                        Session se2 = connection.getConnection.getSessionFactory().openSession();
                                        Criteria cr3 = se2.createCriteria(Type.class);
                                        
                                        List<Type> su3 = cr3.list();
                                    %>
                                    <select class="form-control" id="ty2">
                                        <option value="0">PLEASE SELECT</option>
                                        <%
                                            if (su3.size() > 0) {
                                                for (Type P : su3) {
                                        %>

                                        <option value="<%=P.getId()%>"><%=P.getName()%></option>
                                        <%

                                            }

                                        } else {
                                        %>
                                        <option selected>NO TYPE FOUND</option>
                                        <% }
                                            se2.close();  %>
                                    </select>

                                    <%

                                    %>
                                </div>
                            </div>
                            <div class="input-group mt-2">
                                <div class="input-group col-sm-4 ">
                                    <div class="input-group-prepend">
                                        <label class="input-group-text" for="ba">Set &nbsp;Item</label>
                                    </div>
                                    <%
                                        Session se4 = connection.getConnection.getSessionFactory().openSession();
                                        Criteria cr4 = se4.createCriteria(Items.class);
                                        cr4.add(Restrictions.eq("status", 1));

                                        List<Items> su4 = cr4.list();
                                    %>
                                    <select class="form-control" id="item">
                                        <option value="0">PLEASE SELECT</option>
                                        <%
                                            if (su4.size() > 0) {
                                                for (Items P : su4) {
                                        %>

                                        <option value="<%=P.getItemId()%>"><%=P.getName()%></option>
                                        <%

                                            }

                                        } else {
                                        %>
                                        <option selected>NO ITEM FOUND</option>
                                        <% }
                                            se4.close();  %>
                                    </select>

                                    <%

                                    %>
                                </div>
                            </div>
                        </form>
                                  <button  id="save_dev" type="button"  class="btn btn-info col-sm-2 mt-2 save_dev">ADD NEW</button>
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

            $("#save_dev").click(function () {

                    $.ajax({
                            url: 'saveMeasuringCalcServlet',
                            data: {
                                t1: $('#ty1').find(":selected").val(),
                                t2: $('#ty2').find(":selected").val(),
                                item:$('#item').find(":selected").val(),
                                f: $('input[name="formula"]').val()
                            },
                            type: 'post',
                            cache: false,
                                success: function (data) {
                                    
                                    if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you add Measuring Formula from list !",
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

                        }else if (data === "2") {
                                swal({
                                    title: "Same Type !",
                                    text: "Can't load same measuring types.",
                                    icon: "error",
                                    button: "OK"
                                });

                        }else if (data === "3") {
                                swal({
                                    title: "Calculation Is Wrong !",
                                    text: "Can't compile your calculation.",
                                    icon: "error",
                                    button: "OK"
                                });

                        }
                        else if (data === "4") {
                                swal({
                                    title: "Formula alredy saved !",
                                    text: "your formula is already on the list",
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
                    });
            });
            
            
            $(".delete_dev").click(function () {
        
        
        

        var idd=$(this).closest('tr').find('.delete_dev').val();
        
        var name="delete";
        
        
        swal({
            title: "Are you sure?",
            text: "do you want to "+name+ " Item ? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'deleteCalcServlet',
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