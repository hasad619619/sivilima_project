<%@page import="resources.ThirdCategory"%>
<%@page import="resources.SubCategory"%>
<%@page import="resources.Settings"%>
<%@page import="resources.Account"%>
<%@page import="java.util.function.Supplier"%>
<%@page import="resources.Category"%>
<%@page import="resources.Brand"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Type"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%
            String DATA="458" ;
            if(request.getParameter("q") != null && ! request.getParameter("q").equals("") ){
                 DATA=request.getParameter("q");
                 if(request.getParameter("i") != null && ! request.getParameter("i").equals("") ){
                     response.sendRedirect("itemrol.jsp?q="+request.getParameter("i"));
                 }
            }
            
            if (request.getSession().getAttribute("administrator") == null) {
                response.sendRedirect("login.jsp");
            }


        %>
        <%            
            Session sesDetails = connection.getConnection.getSessionFactory().openSession();
            Settings st = null;
            String Name;
            String Address;
            String Image;
            String Fax;
            String Contact;
            String Emial;

            Criteria crDetails = sesDetails.createCriteria(Settings.class);
            List<Settings> set = crDetails.list();

            if (set.size() > 0) {
                for (Settings ST : set) {
                    if (ST.getIdsettings() == 1) {
                        st = ST;

                    }
                }
            }

            if (st != null) {
                Name = st.getName();
                Address = st.getAddress();
                Image = st.getImage();
                Fax = st.getFax();
                Contact = st.getMobile();
                Emial = st.getEmail();
            } else {
                Name = "";
                Address = "";
                Image = "";
                Fax = "";
                Contact = "";
                Emial = "";
            }
            sesDetails.close();
        %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="icon" href="src/image/favicon.ico">
        <title><%= Name%></title>

        <!-- Bootstrap core CSS -->
        <link href="src/boostrap/bootstrap-4.1.3/css/bootstrap.min.css" rel="stylesheet">
        
        
  
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
        <!-- Data Tables CDN -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/css/select2.min.css" rel="stylesheet" />  
        
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
            .select2-selection__rendered {
              line-height: 37px !important;
              border-radius: 0px !important;
            }

            .select2-selection {
              height: 37px !important;
              border-radius: 0px !important;
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
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Create new item</li>
                    </ol>
                </nav>
            </div>

            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <form action="saveItemServlet" method="post" enctype="multipart/form-data" >
                            <div class="row">
                                <div class="col-sm-6">

                                    <div class="col-sm-12">
                                        <input type="hidden" id="oct" name="oct"/>
                                        <input type="hidden" id="sct" name="sct"/>
                                        <label for="inputPassword3" class="col-sm-6 control-label mt-3">Supplier:</label>
                                        <div class="form-inline ">


                                            <div class="col-sm-12">
                                                <select type="number" class="form-control sp"  style="width:315px;"  name="sp" id="sp" required="">
                                                    <% 
                                                        Session ses = connection.getConnection.getSessionFactory().openSession();
                                                        
                                                        Criteria cr4 = ses.createCriteria(Account.class);
                                                        cr4.add(Restrictions.eq("supplier", 1));
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
                                                    <option  value='0' >ADD SUPPLIER FIRST</option>
                                                    <%
                                                        }

                                                        

                                                    %>
                                                </select>

                                                <a href="account.jsp" type="button"  class="btn btn-warning ">ADD NEW</a>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputEmail3" class="col-sm-6 control-label">Name:</label>

                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="inputEmail3" placeholder="Item name" name="name" id="name" required="">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputPassword3" class="col-sm-6 control-label">Barcode ID:</label>

                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="inputPassword3" placeholder="Barcode ID" name="bi" id="bi" required="">
                                            </div>
                                        </div>
                                        <label for="inputPassword3" class="col-sm-6 control-label">Measuring  Type :</label>
                                        <div class="form-inline">


                                            <div class="col">
                                                <select  class="form-control" id="inputPassword3"  name="ty" id="ty" style="width:315px;" required="">
                                                    <%
                                                        Criteria cr3 = ses.createCriteria(Type.class);
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
                                                    <option>ADD TYPE FIRST</option>
                                                    <%
                                                        }

                                                    %>
                                                </select>

                                                <a  href="type.jsp" type="button"  class="btn btn-warning ">ADD NEW</a>

                                            </div>
                                        </div>

                                        <label for="inputPassword3" class="col-sm-6 control-label mt-3">Brand:</label>
                                        <div class="form-inline col-sm-12">


                                            <div class="">
                                                <select type="" class="form-control"  style="width:315px;"  placeholder="" name="br" id="br" required="">
                                                    <%                                                    
                                                        Criteria cr = ses.createCriteria(Brand.class);
                                                        cr.add(Restrictions.eq("status", 1));
                                                        List<Brand> b = cr.list();
                                                        if (b.size() > 0) {
                                                            for (Brand B : b) {
                                                    %>
                                                    <option value="<%=B.getIdbrand()%>"><%=B.getName()%></option>
                                                    <%

                                                        }

                                                    } else {
                                                    %>
                                                    <option>ADD BRAND FIRST</option>
                                                    <%
                                                        }

                                                    %>

                                                </select>

                                                <a type="button" href="brand.jsp"  class="btn btn-warning ">ADD NEW</a>

                                            </div>
                                        </div>

                                        <label for="inputPassword3" class="col-sm-6 control-label mt-3">Category :</label>
                                        <div class="form-inline">


                                            <div class="col">
                                                <select type="number" class="form-control"   style="width:315px;" name="ct" id="ct" required="">
                                                    <%                                                    
                                                        Criteria cr2 = ses.createCriteria(Category.class);
                                                        cr2.add(Restrictions.eq("status", 1));
                                                        List<Category> c = cr2.list();
                                                        if (c.size() > 0) {
                                                            %>
                                                    <option>PLEASE SELECT CATEGORY</option>
                                                    <%
                                                            for (Category B : c) {
                                                    %>
                                                    <option value="<%=B.getIdcategory()%>"><%=B.getName()%></option>
                                                    <%

                                                        }

                                                    } else {
                                                    %>
                                                    <option>ADD CATEGORY FIRST</option>
                                                    <%
                                                        }

                                                    %>
                                                </select>

                                                <a href="category.jsp" type="button"  class="btn btn-warning ">ADD NEW</a>

                                            </div>
                                        </div>
                                        <label for="inputPassword3" class="col-sm-6 control-label mt-3">Sub Category :</label>
                                        <div class="form-inline">


                                            <div class="col">
                                                <select class="form-control" multiple="multiple"   style="width:315px;" name="sct_t" id="sct_t" required="">
                                                    
                                                    <option value="0">SELECT CATEGORY FIRST</option>
                                                    
                                                </select>

                                                
                                            </div>
                                        </div>

                                        <label for="inputPassword3" class="col-sm-6 control-label mt-3">Other Category:</label>
                                        <div class="form-inline">


                                            <div class="col">
                                                <select  class="form-control"  multiple="multiple"  style="width:315px;" name="oct_t" id="oct_t" required="">
                                                    
                                                    <option  value='0' >SELECT SUB CATEGORY FIRST</option>
                                                    
                                                </select>

                                                
                                            </div>
                                        </div>

                                        




                                    </div>


                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-6 control-label mt-3">Width(Inch) :</label>

                                        <div class="col-sm-10">
                                            <input type="number" class="form-control" id="inputEmail3" value="00"  placeholder="width (if have)" name="w" id="w" required="">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-6 control-label ">Height(Inch) :</label>

                                        <div class="col-sm-10">
                                            <input type="number" class="form-control" id="inputEmail3" value="00"  placeholder="Height (if have)" name="h" id="h" required="">
                                        </div>
                                    </div>
                                    <div class="form-group ">

                                        <label for="inputEmail3" class="col-sm-6 control-label ">Image :</label>
                                        <div class="col-sm-10">
                                            <div class="custom-file">
                                                <input type="file" required="" class="custom-file-input" name="file" id="profile-img" aria-describedby="inputGroupFileAddon01">
                                                <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
                                            </div>
                                        </div>     
                                    </div>
                                    <div class="form-group ">
                                        <div class="col-sm-10">
                                             <img src="" id="profile-img-tag" width="200px" />
                                        </div>
                                       
                                    </div>
                                    
                                    
                                    
                                    <button  type="submit"  class="btn btn-info save_dev mt-2">SAVE</button>
                                    <button  type="button"  class="btn btn-danger  mt-2" onclick="RE()">CLEAR</button>

                                </div>
                            </div>
                                                
                        </form>

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
        <script src="src/boostrap/bootstrap-4.1.3/js/bootstrap.bundle.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>
        <script>
            $(window).load(function(){
                $('.loader').fadeOut();
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function() {
                $('.sp').select2();
            });
            function RE(){
                location.reload();
                
            }
            $("select[name='oct_t']").change(function() {
                    var arr = $("select[name='oct_t']").val(); //automatically creates an array of selected values
                    var foo = arr.join(","); //creates a comma delimited string (i.e:'ring,necklace')
                    $( "#oct" ).val(foo); //update hidden field value
                   
            });
            $("select[name='sct_t']").change(function() {
                    var arr = $("select[name='sct_t']").val(); //automatically creates an array of selected values
                    var foo = arr.join(","); //creates a comma delimited string (i.e:'ring,necklace')
                    
                    $( "#sct" ).val(foo); //update hidden field value
                    
            });
            $('#oct_t').selectpicker();
            $('#sct_t').selectpicker();
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#profile-img-tag').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
            $("#profile-img").change(function () {
                readURL(this);
            });
        </script>
        <script type="text/javascript">
            
            $("#ct").change(function () {
               var cat=$('#ct').find(":selected").val();
               var dataString = 'p2=' + cat;
               
                
                    $.ajax({
                        url: 'getSubCatListServlet',
                        dataType: "json",
                        data: dataString,
                        cache: false,
                        success: function (player) {
                            let dropdown = $('#sct_t');
                            dropdown.empty();
                            if (player.length === 0) {
                                
                                $("#sct_t").append("<option value='0'>SELECT CATEGORY FIRST</option>");
                            } else {
                                //$("#sct").append("<option>PLEASE SELECT SUBCATEGORY</option>");
                                $.each(player, function (key, value) {
                                $("#sct_t").append("<option value=" + value.id + " >" + value.name + "</option>");
                                });
                        }
                                $("#sct_t").selectpicker("refresh");
                                var a = new Array();
                                $("#sct_t").children("option").each(function(x){
                                    test = false;
                                    b = a[x] = $(this).val();
                                    if(b==0){
                                        $(this).remove();
                                    }
                                    for (i=0;i<a.length-1;i++){
                                        if (b ==a[i]) test =true;
                                    }
                                    if (test) $(this).remove();
                                });
                                $("#sct_t").selectpicker("refresh");
                        }
                    });

            });
            $("#sct_t").change(function () {
               var cat=$('#sct_t').find(":selected").val();
               var dataString = 'p2=' + cat;
               
                
                    $.ajax({
                        url: 'getOthreCatListServlet',
                        dataType: "json",
                        data: dataString,
                        cache: false,
                        success: function (player) {
                            let dropdown = $('#oct');
                            dropdown.empty();
                            if (player.length === 0) {
                                
                                $("#oct_t").append("<option  value='0'>SELECT CATEGORY FIRST</option>");
                            } else {
                                //$("#oct").append("<option>PLEASE SELECT OTHERCATEGORY</option>");
                                $.each(player, function (key, value) {
                                $("#oct_t").append("<option value=" + value.id + " >" + value.name + "</option>");
                                });
                            }
                                $("#oct_t").selectpicker("refresh");
                                var a = new Array();
                                $("#oct_t").children("option").each(function(x){
                                    test = false;
                                    b = a[x] = $(this).val();
                                    if(b==0){
                                        $(this).remove();
                                    }
                                    for (i=0;i<a.length-1;i++){
                                        if (b ==a[i]) test =true;
                                    }
                                    if (test) $(this).remove();
                                });
                                $("#oct_t").selectpicker("refresh");
                        }
                    });

            });
            
            
            $('input[name="name"]').val("");
            $('input[name="bi"]').val("");
            $('input[name="ty"]').val("");
            $('input[name="br"]').val("");
            $('input[name="ct"]').val("");
            $('input[name="sp"]').val("");
            $('input[name="cost"]').val("");
            $('input[name="name"]').focus();
            var data = ""+<%= DATA %>;


            if (data === "1") {

                swal({
                    title: "Good job!",
                    text: "you saved new item to list !",
                    icon: "success",
                    button: "OK"
                });





            } else if (data === "0") {
                swal({
                    title: "Empty Field Data !",
                    text: "Can't let any field empty.",
                    icon: "error",
                    button: "OK"
                });

            } else if (data === "3") {
                swal({
                    title: "Access denied !",
                    text: "You can't do this action without permision.",
                    icon: "error",
                    button: "OK"
                });

            } else if (data === "4") {
                swal({
                    title: "Barcode ID Alredy In Use !",
                    text: "You can't add same barcode id again.",
                    icon: "error",
                    button: "OK"
                });

            } else if(data === "94"){
                swal({
                    title: "Something Went Wrong !",
                    text: "something wrong in saving data please retry.",
                    icon: "error",
                    button: "OK"
                });

            }

        </script>


    </body>

</html>