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
                            
                            User user = null;
                            int id=0;
                            
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
                        <li class="breadcrumb-item" style="font-size: 16px;"><a href="user.jsp"><i class="fa fa-arrow-left"></i> User</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">User Account</li>
                    </ol>
                </nav>
            </div>
            
            <%
                Session s=connection.getConnection.getSessionFactory().openSession();
                if(request.getParameter("q") != null && !request.getParameter("q").equals("")  && !request.getParameter("q").equals("0")){
                    
                    user = (User) s.load(User.class, Integer.parseInt(request.getParameter("q"))); 
                    if(user != null){
                    id=user.getIduser();
                    

                %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Branch</span>
                                    </div>
                                    <input type="text" class="form-control" name="branch" id="branch" value="<%=user.getBranch().getName() %>" disabled="">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Access</span>
                                    </div>
                                    <select disabled="" class="form-control" name="level" id="level">
                                        
                                        <option value="1">Administrator</option>
                                        <option value="2">Inspector</option>
                                        
                                                
                                    </select>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Name</span>
                                    </div>
                                    <input type="text" class="form-control" name="name" id="name" value="<%=user.getName() %>" disabled="">
                                </div>
                                
                            </div>
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Contact</span>
                                    </div>
                                    <input type="number" class="form-control" name="contact" id="contact" value="<%=user.getContact() %>" disabled="">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Username</span>
                                    </div>
                                    <input type="text" class="form-control" name="username" id="username" value="<%=user.getUsername() %>" disabled="">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">Password</span>
                                    </div>
                                    <input type="text" class="form-control" name="password" id="password" value="<%=user.getPassword() %>" disabled="">
                                </div>
                                <a class="btn btn-sm btn-warning mb-3" href="src/ACD.pdf" target="_blank">ACCESS CODE BOOK</a>
                                
                            </div>
                                <div class="row p-3" style="border: #27ae60 solid 2px;">
                                    <div class="input-group mb-3 col-md-6">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"   style="width:120px;" id="inputGroup-sizing-default">ACCOUNT</span>
                                    </div>
                                    <input type="text" value="<%=user.getAc() %>" class="form-control" name="ac" id="ac">
                                    </div>
                                    <div class="input-group mb-3 col-md-6">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"   style="width:120px;" id="inputGroup-sizing-default">CREATE</span>
                                    </div>
                                    <input type="text" value="<%=user.getCr() %>" class="form-control" name="cr" id="cr">
                                    </div>
                                    <div class="input-group mb-3 col-md-6">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"   style="width:120px;" id="inputGroup-sizing-default">ADMIN</span>
                                    </div>
                                    <input type="text" value="<%=user.getAd() %>" class="form-control" name="ad" id="ad">
                                    </div>
                                    <div class="input-group mb-3 col-md-6">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"   style="width:120px;" id="inputGroup-sizing-default">INVOICING</span>
                                    </div>
                                    <input type="text" value="<%=user.getInv() %>" class="form-control" name="in" id="in">
                                    </div>
                                    <div class="input-group mb-3 col-md-6">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"   style="width:120px;" id="inputGroup-sizing-default">STOCKS</span>
                                    </div>
                                    <input type="text" value="<%=user.getSt() %>" class="form-control" name="st" id="st">
                                    </div>
                                    <div class="input-group mb-3 col-md-6">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"   style="width:120px;" id="inputGroup-sizing-default">ACCOUNTING</span>
                                    </div>
                                    <input type="text" value="<%=user.getAcc() %>" class="form-control" name="acc" id="acc">
                                    </div>
                                    <div class="input-group mb-3 col-md-6">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"   style="width:120px;" id="inputGroup-sizing-default">CHEQUE</span>
                                    </div>
                                    <input type="text" value="<%=user.getCh() %>" class="form-control" name="ch" id="ch">
                                    </div>
                                    <div class="input-group mb-3 col-md-6">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"   style="width:120px;" id="inputGroup-sizing-default">OTHER</span>
                                    </div>
                                    <input type="text" value="<%=user.getOt() %>" class="form-control" name="ot" id="ot">
                                    </div>
                                    <div class="input-group mb-3 col-md-6">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text"   style="width:120px;" id="inputGroup-sizing-default">REPORTS</span>
                                    </div>
                                    <input type="text" value="<%=user.getRe() %>" class="form-control" name="re" id="re">
                                    </div>
                                    <div class="input-group mb-3 col-md-6">
                                        
                                    </div>
                                    <div class="btn-group col-md-3" role="group" aria-label="Basic example">
                                    <button type="button" class="btn btn-sm btn-success" id="save"><span class="fa fa-save mr-2"></span>UPDATE</button>
                                    <a href="useraccess.jsp?q=<%=user.getIduser() %>" class="btn btn-sm btn-danger" id="clear"><span class="fa fa-trash mr-2"></span>RESET</a>
                                    </div>
                                </div>
                        </div>

                    </div>
                </div>
            </div>
                                    <%
                                        }else{
                        response.sendRedirect("user.jsp");
                    }
                    
                }else{
                    response.sendRedirect("user.jsp");
                }
                                        %>
                                
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
            
            $('#level').val(<%=user.getLevel() %>);
            $('#acc').keypress(function (e) {
                var key = e.which;
                 if(key == 13)  // the enter key code
                 {
                   save();
                 }
            });
            
            
            
            $("#save").click(function () {
                save();
            });
            
         
            
            function save(){
                var id_u=<%=id %>;
            $.ajax({
            url: 'updateAccessUserServlet',
                    data: {
                            id:id_u,
                            ac: $('#ac').val(),
                            cr: $('#cr').val(),
                            ad: $('#ad').val(),
                            in: $('#in').val(),
                            st: $('#st').val(),
                            acc:$('#acc').val(),
                            ch: $('#ch').val(),
                            ot: $('#ot').val(),
                            re: $('#re').val()


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                    if (data === "1") {

                    swal({
                    title: "Good job!",
                            text: "you updated Access level !",
                            icon: "success",
                            button: "OK"
                    }).then((value) =>{

                    location.reload();
                    });
                    } else if (data === "0") {
                    swal({
                    title: "Try Again !",
                            text: "please try againg",
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