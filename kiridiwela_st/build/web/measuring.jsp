<%@page import="resources.Mess"%>
<%@page import="java.util.Collections"%>
<%@page import="resources.Account"%>
<%@page import="resources.Me"%>
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
    </head>

    <body>

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->



        <main role="main" class="container">
            
            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Projects</li>
                        <li class="breadcrumb-item active" aria-current="page">Measuring</li>
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
                                    <th id="dev_id" class="dev_id" >#</th>
                                    <th>Customer Name</th>
                                    <th>Employee Name</th>
                                    <th>Date</th>
                                    <th>Remarks</th>
                                    <th>status</th>
                                    <th>option</th>
                                    


                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(Mess.class);
                                    List<Mess> de = cr.list();
                                    
                                    
                                    if (de.size() > 0) {
                                        for ( Mess DE : de) {


                                %>
                                <tr>
                                    <td><%= DE.getIdmess() %></td>
                                    <td><%= DE.getAccountByCustomer().getName() %></td>
                                    <td><%=DE.getAccountByEmployee().getName() %></td>
                                    <td><%=DE.getDate() %></td>
                                    <td><%=DE.getRemarks() %></td>
                                    
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
                                        <button class="btn btn-outline-dark btn-sm delete_dev" id="delete_dev"  value="<%=DE.getIdmess()%>">Delete | Reset</button>
                                        <input type="hidden" name="stat" id="stat" class="stat" value= "<%= DE.getStatus() %>"/>
                                        
                                        


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
                                        <label for="inputEmail3" class="col-sm-2 control-label">Customer Name:</label>

                                        <div class="col-sm-10">
                                            <select  class="form-control"   name="c" id="c">
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
                                                    s2.close();

                                                    %>  
                                            </select>
                                                    
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">Employee Name:</label>

                                        <div class="col-sm-10">
                                            <select  class="form-control"   name="e" id="e">
                                                 <%  
                                                        Session s3 = connection.getConnection.getSessionFactory().openSession();
                                                        Criteria cr7 = s3.createCriteria(Account.class);
                                                        cr7.add(Restrictions.eq("status", 1));
                                                        cr7.add(Restrictions.eq("employee", 1));
                                                        List<Account> c7 = cr7.list();
                                                        Collections.reverse(c7);
                                                        if (c7.size() > 0) {
                                                            for (Account  B : c7) {
                                                    %>
                                                    <option value="<%=B.getIdaccount()%>"><%=B.getName()%></option>
                                                    <%

                                                        }

                                                    } else {
                                                    %>
                                                    <option> PLEASE ADD EMPLOYEE FIRST</option>
                                                    <%
                                                        }
                                                    s3.close();

                                                    %>  
                                            </select>
                                        </div>
                                            <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">Date:</label>

                                        <div class="col-sm-10">
                                            <input type="date" class="form-control" id="" placeholder="" name="d" id="d">
                                            
                                        </div>
                                    </div>
                                            <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">Remarks:</label>

                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="" placeholder="" name="r" id="r">
                                            
                                        </div>
                                    </div>
                                    </div>
                                    
                                </div>
                            </form>
                        <button  id="save_dev" type="button"  class="btn btn-dark save_dev">ADD NEW</button>
                    </div>

                </div>
                



            </div>


        </main>

       <div class="modal fade" id="myModal" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
    
      <!-- Modal content-->
    
      
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
        
        <script type="text/javascript">
             $(document).ready(function () {
                $('#table1').DataTable();
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
            text: "do you want to "+name+ " Sub category ? ",
            icon: "warning",
            buttons: true,
            dangerMode: true,
            }).then((willDelete) => {
                    if (willDelete) {
                        
                        $.ajax({
                        url: 'deleteMeServlet',
                        data: {
                        id: idd
                        

                        },
                        type: 'post',
                        cache: false,
                        success: function (data) {
                        if (data === "1") {

                            swal({
                                title: "Good job!",
                                text: "you "+name+ " category from list !",
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
        });
                        
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
            url: 'saveMeServlet',
            data: {
                c: $('#c').find(":selected").val(),
                e: $('#e').find(":selected").val(),
                r: $('input[name="r"]').val(),
                d: $('input[name="d"]').val()
                
                

            },
            type: 'post',
            cache: false,
            success: function (data) {
                if (data === "1") {

                    swal({
                                title: "Good job!",
                                text: "you add new data to list !",
                                icon: "success",
                                button: "OK"
                            }).then((value) => {
                                    location.reload();
                                
                          });
                    
                    
                    
                    
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