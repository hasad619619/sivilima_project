<%@page import="resources.Settings"%>
<%@page import="resources.User"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Branch"%>
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
            }else{
                User u=(User) request.getSession().getAttribute("administrator");
                if(u.getLevel() != 1){
                    response.sendRedirect("noaccess.jsp");
                }
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
                        <li class="breadcrumb-item" style="font-size: 16px;"><a href="settings.jsp"><i class="fa fa-arrow-left"></i> Back</a></li>
                        <li class="breadcrumb-item  active" aria-current="page" style="font-size: 16px;">User Account</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Branch</span>
                                    </div>
                                    <select class="form-control" name="branch" id="branch">
                                        <%
                                            Session ses=connection.getConnection.getSessionFactory().openSession();
                                            Criteria cr=ses.createCriteria(Branch.class);
                                            cr.add(Restrictions.eq("status", 1));
                                            List<Branch> br=cr.list();
                                            for(Branch BR:br){
                                            
                                            %>
                                                <option value="<%= BR.getIdbranch() %>"><%= BR.getName() %></option>
                                        <%
                                            }
                                            ses.close();
                                            %>
                                                
                                    </select>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Access</span>
                                    </div>
                                    <select class="form-control" name="level" id="level">
                                        
                                        <option value="1">Administrator</option>
                                        
                                        
                                                
                                    </select>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Name</span>
                                    </div>
                                    <input type="text" class="form-control" name="name" id="name">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Contact</span>
                                    </div>
                                    <input type="number" class="form-control" name="contact" id="contact">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Username</span>
                                    </div>
                                    <input type="text" class="form-control" name="username" id="username">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Password</span>
                                    </div>
                                    <input type="password" class="form-control" name="password" id="password">
                                </div>
                                
                                <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                    <button type="button" class="btn btn-sm btn-success" id="save"><span class="fa fa-save mr-2"></span>SAVE</button>
                                    <button type="button" class="btn btn-sm btn-danger" id="clear"><span class="fa fa-trash mr-2"></span>CLEAR</button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-active table-sm" id="tbl1">
                            <thead>
                                <tr style="background-color: #10ac84 !important; color: white !important; ">
                                    <td>Account ID</td>
                                    <td>Name</td>
                                    <td>Status</td>
                                    <td>Options</td>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses1 = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr1 = ses1.createCriteria(User.class);
                                    List<User> ac = cr1.list();

                                    for (User AC : ac) {
                                %>
                                <tr>
                                    <td><%=AC.getIduser() %></td>
                                    <td><%= AC.getName().toUpperCase() %></td>
                                    <%
                                        if (AC.getStatus() == 1) {
                                    %>
                                    <td><span class="badge bg-info">active</span></td>
                                    <%
                                    } else {
                                    %>
                                    <td><span class="badge bg-danger">deleted</span></td>

                                    <% }%>
                                    <td>
                                        <input name="accid" id="accid" type="hidden" value="<%=AC.getIduser()%>">
                                        <input name="stat" type="hidden" value="<%=AC.getStatus()%>">
                                        
                                        <input name="h_name" type="hidden" value="<%= AC.getName() %>">
                                        <input name="h_contact" type="hidden" value="<%= AC.getContact() %>">
                                        <input name="h_username" type="hidden" value="<%= AC.getUsername() %>">
                                        <input name="h_password" type="hidden" value="<%= AC.getPassword() %>">
                                        <input name="h_branch" type="hidden" value="<%= AC.getBranch().getIdbranch() %>">
                                        <input name="h_level" type="hidden" value="<%= AC.getLevel() %>">
                                        
                                        
                                        <div class="btn-group" role="group" aria-label="Basic example">
                                            <button type="button" class="btn btn-sm btn-success update">UPDATE</button>
                                            <button type="button" class="btn btn-sm btn-warning delete">DELETE / RESET</button>
                                            <button type="button" class="btn btn-sm btn-secondary view">VIEW</button>
                                            <button type="button" class="btn btn-sm btn-info change">CHANGE PASSWORD</button>
                                            <a type="button" class="btn btn-sm btn-danger access" href="useraccess.jsp?q=<%=AC.getIduser() %>">ACCESS</a>
                                        </div>

                                    </td>

                                </tr>
                                <%
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


        <!-- Modal update -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">update user account</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Branch</span>
                                    </div>
                                    <select class="form-control" name="u_branch" id="u_branch">
                                        <%
                                            Session ses2=connection.getConnection.getSessionFactory().openSession();
                                            Criteria cr2=ses2.createCriteria(Branch.class);
                                            cr2.add(Restrictions.eq("status", 1));
                                            List<Branch> br2=cr2.list();
                                            for(Branch BR:br2){
                                            
                                            %>
                                                <option value="<%= BR.getIdbranch() %>"><%= BR.getName() %></option>
                                        <%
                                            }
                                            ses2.close();
                                            %>
                                                
                                    </select>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Access</span>
                                    </div>
                                    <select class="form-control" name="u_level" id="u_level">
                                        
                                        <option value="1">Administrator</option>
                                        <option value="2">Inspector</option>
                                        
                                                
                                    </select>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Name</span>
                                    </div>
                                    <input type="text" class="form-control" name="u_name" id="u_name">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Contact</span>
                                    </div>
                                    <input type="number" class="form-control" name="u_contact" id="u_contact">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Username</span>
                                    </div>
                                    <input type="text" class="form-control" name="u_username" id="u_username">
                                </div>
                                
                                <input type="hidden" id="u_aid" name="u_aid" >
                                <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                    <button type="button" class="btn btn-success" id="u_save"><span class="fa fa-save mr-2"></span>SAVE</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal view-->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">user account details</h5>
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
        <!-- Modal change password-->
        <div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">change user password</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body ">
                        <div class="row " id="" >
                            <div class="row ml-2">
                                <div class="col-sm-12">
                                    <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:120px;" id="inputGroup-sizing-default">Old Password</span>
                                    </div>
                                    <input type="password" class="form-control" name="c_password" id="c_password">
                            </div>
                            <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:120px;" id="inputGroup-sizing-default">New Password</span>
                                    </div>
                                    <input type="password" class="form-control" name="c_npassword" id="c_npassword">
                            </div>
                                    <input type="hidden" name="c_acid" id="c_acid">
                            <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                    <button type="button" class="btn btn-success" id="c_save"><span class="fa fa-save mr-2"></span>SAVE</button>
                            </div>
                                </div>
                            </div>
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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
   $(window).load(function(){
        $('.loader').fadeOut();
   });
</script>

        <script type="text/javascript">
            
            $('select[name="level"]').change(function (){
                $('#name').focus();
            });
            $('#name').keypress(function (e) {
                var key = e.which;
                 if(key == 13)  // the enter key code
                 {
                   $('#contact').focus();
                 }
            });
            $('#contact').keypress(function (e) {
                var key = e.which;
                 if(key == 13)  // the enter key code
                 {
                   $('#username').focus();
                 }
            });
            $('#username').keypress(function (e) {
                var key = e.which;
                 if(key == 13)  // the enter key code
                 {
                   $('#password').focus();
                 }
            });
            $('#password').keypress(function (e) {
                var key = e.which;
                 if(key == 13)  // the enter key code
                 {
                   save();
                 }
            });
            
            
            $(document).ready(function () {
                $('#tbl1').DataTable();
            });
            $("#save").click(function () {
                save();
            });
            $(".change").click(function () {
                var id=$(this).closest('tr').find('input[name="accid"]').val(); 
                document.getElementById("c_acid").value = ""+id;
                $('#myModal3').modal('show');
                
            });
            $("#c_save").click(function () {
                $.ajax({
                    url: 'changeUserPasswordServlet',
                    data: {
                            id: $('input[name="c_acid"]').val(),
                            op: $('input[name="c_password"]').val(),
                            np: $('input[name="c_npassword"]').val()
                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        if (data === "1") {

                                    swal({
                                        title: "Good job!",
                                        text: "you change your password !",
                                        icon: "success",
                                        button: "OK"
                                    }).then((value) =>{

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
                    else if (data === "2") {
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
                    title: "Something went wrong !",
                            text: "something wrong in saving data please retry.",
                            icon: "error",
                            button: "OK"
                    });
                    }
                });
                
            });
            $(".update").click(function () {
                
                var id=$(this).closest('tr').find('input[name="accid"]').val(); 
         
                var name=$(this).closest('tr').find('input[name="h_name"]').val();
                var contact=$(this).closest('tr').find('input[name="h_contact"]').val();
                var username=$(this).closest('tr').find('input[name="h_username"]').val();
                var branch=$(this).closest('tr').find('input[name="h_branch"]').val();
                var level=$(this).closest('tr').find('input[name="h_level"]').val();
                
         
                document.getElementById("u_name").value = ""+name;
                document.getElementById("u_contact").value = ""+contact;
                document.getElementById("u_username").value = ""+username;
                document.getElementById("u_aid").value = ""+id;
                $("#u_branch").val(branch);
                $('#u_level').val(level);
                $('#myModal').modal('show');
                

            });
            
            $("#clear").click(function () {
                
               $('input[name="name"]').val("");
               $('input[name="contact"]').val("");
               $('input[name="username"]').val("");
               $('input[name="password"]').val("");
               $('input[name="name"]').focus();
               
            });
            
            
            $("#u_save").click(function () {
                update();
            });
            
            $(".view").click(function () {
                 var i=$(this).closest('tr').find('input[name="accid"]').val(); 
                 $.ajax({
                    url: 'viewUserServlet',
                    data: {
                            id: i
                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        document.getElementById("acc_details").innerHTML = ""+data;
                    
                    },
                    error: function () {
                    swal({
                    title: "Something went wrong !",
                            text: "something wrong in saving data please retry.",
                            icon: "error",
                            button: "OK"
                    });
                    }
                });
                 
                  $('#myModal2').modal('show');
            });
            
            $(".delete").click(function () {

                var idd = $(this).closest('tr').find('#accid').val();
                var stat = $(this).closest('tr').find('input[name="stat"]').val();
                var name = "";
            
                if (stat == "1"){

                    name = "delete";
                } else{

                    name = "restore";
                }

                swal({
                    title: "Are you sure?",
                    text: "do you want to " + name + " account ? ",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then((willDelete) =>{
                
                
                    if (willDelete){
                        
                        $.ajax({
                            url: 'deleteUserServlet',
                            data: {
                            id: idd
                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                                
                                if (data === "1") {

                                    swal({
                                        title: "Good job!",
                                        text: "you " + name + " account from list !",
                                        icon: "success",
                                        button: "OK"
                                    }).then((value) =>{

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
                             location.replace("login.jsp");
                    }
                    },
                    error: function () {
                    swal({
                    title: "Something Went Wrong !",
                            text: "something wrong in " + name + " data please retry.",
                            icon: "error",
                            button: "OK"
                    });
                    }
            });
            } else {
                    swal({
                        title: "Cancelled !",
                    text: "you cancelled " + name + " process.",
                    icon: "error",
                    button: "OK"
                    });
            }
            });
            });
            
            function update(){
                
                $.ajax({
                    url: 'updateUserServlet',
                    data: {
                            name: $('input[name="u_name"]').val(),
                            id: $('input[name="u_aid"]').val(),
                            contact: $('input[name="u_contact"]').val(),
                            username: $('input[name="u_username"]').val(),
                            level: $('#u_level').find(":selected").val(),
                            branch: $('#u_branch').find(":selected").val()


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        
                    if (data === "1") {

                    swal({
                    title: "Good job!",
                            text: "you update account !",
                            icon: "success",
                            button: "OK"
                    }).then((value) =>{

                    location.reload();
                    });
                    } else if (data === "0") {
                    swal({
                    title: "Empty Data !",
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
                             location.replace("login.jsp");
                    }
                    },
                    error: function () {
                    swal({
                    title: "Something went wrong !",
                            text: "something wrong in saving data please retry.",
                            icon: "error",
                            button: "OK"
                    });
                    }
            });
                
            }
            
            function save(){
            $.ajax({
            url: 'saveUserServlet',
                    data: {
                            branch: $('#branch').find(":selected").val(),
                            level: $('#level').find(":selected").val(),
                            name: $('input[name="name"]').val(),
                            contact: $('input[name="contact"]').val(),
                            username: $('input[name="username"]').val(),
                            password: $('input[name="password"]').val()


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {

                    swal({
                    title: "Good job!",
                            text: "you create new user !",
                            icon: "success",
                            button: "OK"
                    }).then((value) =>{

                    location.reload();
                    });
                    } else if (data === "0") {
                    swal({
                    title: "Empty Data !",
                            text: "Can't let any field empty.",
                            icon: "error",
                            button: "OK"
                    });
                    }
                    },
                    error: function () {
                    swal({
                    title: "Something went wrong !",
                            text: "something wrong in saving data please retry.",
                            icon: "error",
                            button: "OK"
                    });
                    }
            });
            }


        </script>


    </body>
</html>