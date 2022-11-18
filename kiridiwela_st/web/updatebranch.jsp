<%@page import="resources.Branch"%>
<%@page import="resources.Settings"%>
<%@page import="resources.User"%>
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
                            Branch st=null;
                            String Name="";
                            String Address="";
                            String Image="";
                            String Fax="";
                            String Contact="";
                            String Emial="";
                            String ID="";
                            
                            if(request.getParameter("q") != null && !request.getParameter("q").equals("")){
                                try {
                                        st = (Branch) sesDetails.load(Branch.class, Integer.parseInt(request.getParameter("q")));
                                    } catch (Exception e) {
                                        response.sendRedirect("branch.jsp");
                                    }
                            }
                            
                            
                            
                            if(st != null){
                                Name=st.getName();
                                Address=st.getAddress();
                                Image=st.getImage();
                                Fax=st.getFax();
                                Contact=st.getContact();
                                Emial=st.getEmail(); 
                                ID=st.getIdbranch().toString(); 
                            }else{
                                response.sendRedirect("branch.jsp");
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
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-arrow-left"></span>&nbsp;<a href="branch.jsp">Back</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">View Branch</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <h4>Branch ID : <%=ID %></h4>
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default"  >NAME</span>
                                    </div>
                                    <input type="text" class="form-control" name="name" id="name" value="<%=Name %>">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">EMAIL</span>
                                    </div>
                                    <input type="emial" class="form-control" name="email" id="email" value="<%=Emial %>">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">CONTACT</span>
                                    </div>
                                    <input type="number" class="form-control" name="contact" id="contact" value="<%=Contact %>">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">FAX</span>
                                    </div>
                                    <input type="number" class="form-control" name="fax" id="fax" value="<%=Fax %>">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">ADDRESS</span>
                                    </div>
                                    <input type="text" class="form-control" name="address" id="address" value="<%=Address %>">
                                </div>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">IMAGE</span>
                                    </div>
                                    <input type="text" class="form-control" name="image" id="image" value="<%=Image %>">
                                </div>
                                <div class="input-group mb-3">
                                    <button class="btn btn-info " id="save">UPDATE</button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <img src="<%=Image %>" class="col-md-12"  >
                                
                            </div>
                        </div>

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

        <script type="text/javascript">
            
            $('#save').click(function (){
                save();
            });
            
            function save(){
                var id = <%=ID %>;
            $.ajax({
            url: 'updateBranchServlet',
                    data: {
                            name: $('input[name="name"]').val(),
                            contact: $('input[name="contact"]').val(),
                            email: $('input[name="email"]').val(),
                            address: $('input[name="address"]').val(),
                            fax: $('input[name="fax"]').val(),
                            id: id,
                            image: $('input[name="image"]').val()


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        var id = data.split('~')[1];
                        data = data.split('~')[0];
                    if (data === "1") {

                    swal({
                    title: "Good job!",
                            text: "you just update branch !",
                            icon: "success",
                            button: "OK"
                    }).then((value) =>{

                       location.replace('updatebranch.jsp?q='+id);
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