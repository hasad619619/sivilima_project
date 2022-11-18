<%@page import="dataclass.userHolder"%>
<%@page import="java.util.Set"%>
<%@page import="resources.User"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Shortcut"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="resources.Settings"%>
<%@page import="org.hibernate.Session"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%
            userHolder USER = null;
            if (request.getSession().getAttribute("administrator") == null) {
                response.sendRedirect("login.jsp");
            }else{
                if (request.getSession().getAttribute("userHolder") != null) {
                USER=(userHolder) request.getSession().getAttribute("userHolder");
                }
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
        <title><%=Name%></title>

        <!-- Bootstrap core CSS -->
     
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">

        
        <!-- Propeller card (CSS for helping component example file)-->
        <link href="http://propeller.in/components/card/css/card.css" type="text/css" rel="stylesheet" />

        <!-- Example docs (CSS for helping component example file)-->
        <link href="http://propeller.in/docs/css/example-docs.css" type="text/css" rel="stylesheet" />

        <!-- Propeller typography -->
        <link href="http://propeller.in/components/typography/css/typography.css" type="text/css" rel="stylesheet" />

        <!-- Google Icon Font -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--<link href="../components/icons/css/google-icons.css" type="text/css" rel="stylesheet" /> -->

        <!-- Propeller Button -->
        <link href="http://propeller.in/components/button/css/button.css" type="text/css" rel="stylesheet" />

        <!-- Propeller Accordion -->
        <link href="http://propeller.in/components/floating-action-button/css/floating-action-button.css" type="text/css" rel="stylesheet" /> 
        <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet"> 
        
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
        <link href="src/boostrap/bootstrap-4.1.3/css/bootstrap.min.css" rel="stylesheet">
        
        
        
  
        <style>

            body { 
                background: url('<%=Image%>') no-repeat center center fixed; 
                -webkit-background-size: cover;
                -moz-background-size: cover;
                -o-background-size: cover;
                background-size: cover;
                font-family: 'Lato', sans-serif;

            }
            
        </style>


    </head>

    <body>

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->


           
        <main role="main" class="container">
            <div class="row ">
                <div class="col-sm-4 ">
                    <div class="card" style="background-color: white; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); margin-top: 50px;">

                        <div class="card-body">
                              
                            <h3><%=Name %></h3>
                            <% if(USER != null){ %>
                            <h5 class="card-title"><%=USER.getName() %></h5>
                            <h6 class="card-title"><%=USER.getBranch() %></h6>
                            <%} %>
                            
                        </div>
                        <div class="card-footer">
                            <a href="logOutServlet" class="btn btn-warning">LOG OUT</a>
                        </div>
                    </div>
                </div>
            </div> 

            <div class="row mt-5">
                <%
                    Session ses=connection.getConnection.getSessionFactory().openSession();
                    Criteria cr=ses.createCriteria(Shortcut.class);
                    List<Shortcut> sc = cr.list();
                    for (Shortcut SC : sc) {
                      if(SC.getStatus() == 1 && SC.getUser().getIduser() == USER.getId()) {  
                    
                %>
                <div class="col-sm-2 mt-2" >
                    <div class="card" style="height:10rem;">

                        <div class="card-body">
                            <button type="button" class="close" aria-label="Close" value="<%=SC.getIdshortcut()%>">
                                <span aria-hidden="true" class="mb-0">&times;</span>
                            </button>
                               
                            <h5 class="card-title" style="font-size:20px;"><%=SC.getName()%></h5>
                            
                        </div>
                        <div class="card-footer">
                            <a href="<%=SC.getUrl()%>" class="btn btn-primary">GO</a>
                        </div>
                    </div>
                </div>

                <% }
                    
                }  
                ses.close();
                %>

            </div>


        </main>
        <div class="menu pmd-floating-action" role="navigation"> 


            <a href="javascript:void(0);" id="email" class="pmd-floating-action-btn btn btn-sm pmd-btn-fab pmd-btn-raised pmd-ripple-effect btn-default" data-title="SEND EMAIL"> 
                <i class="material-icons">email</i> 
            </a> 
            <a href="javascript:void(0);" id="short" class="pmd-floating-action-btn btn btn-sm pmd-btn-fab pmd-btn-raised pmd-ripple-effect btn-default" data-title="CREATE SHORTCUT"> 
                <i class="material-icons">add_location</i> 
            </a> 
            <a href="javascript:void(0);" class="pmd-floating-action-btn btn pmd-btn-fab pmd-btn-raised pmd-ripple-effect btn-primary" data-title="OPTIONS"> 
                <i class="material-icons pmd-sm">add</i> 
            </a> 
        </div>

        <!-- Modal view-->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle" style="font-size:20px;">create new shortcut for home page</h5>
                        
                    </div>
                    <div class="modal-body ">

                        <div class="row " >
                            <div class="col-sm-12 mt-1">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">NAME</span>
                                    </div>
                                    <input type="text" class="form-control"   name="name_s" id="name_s" max="20" >


                                </div>

                                <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" style="width:130px;" id="inputGroup-sizing-default">URL</span>
                                    </div>
                                    <input type="text" class="form-control"   name="url_s" id="url_s"  >


                                </div>

                            </div>
                            <div class="col-sm-12 mt-2">
                                <button class="btn btn-info" id="c_shortcut">CREATE SHORTCUT</button>
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
        <div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="modal-title" id="exampleModalLongTitle" style="font-size:20px;">Compose Email</h2>
                        
                    </div>
                    <div class="modal-body ">

                        <div class="row">
                            <div class="col-md-12 col-md-offset-3">
                                
                                <form role="form" method="post" id="reused_form">
                                    
                                    <div class="row">
                                        <div class="col-sm-12 form-group">
                                            <label for="comments">
                                                Message:</label>
                                            <textarea class="form-control" type="textarea" name="comments" id="e_comments" placeholder="Your Message" maxlength="6000" rows="7"></textarea>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 form-group">
                                            <label for="name">
                                                Subject:</label>
                                            <input type="text" class="form-control" id="e_name" name="name" required>
                                        </div>
                                        <div class="col-sm-6 form-group">
                                            <label for="email">
                                                Email:</label>
                                            <input type="email" class="form-control" id="e_email" name="email" required>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12 form-group">
                                            <button type="button" id="e_send" class="btn btn-lg btn-primary btn-block" >Send ?</button>
                                        </div>
                                    </div>

                                </form>
                                
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
            $("#short").click(function () {

                $("#myModal2").modal();

            });
            $("#email").click(function () {

                $("#myModal3").modal();

            });
            $("#e_send").click(function () {
                
                $.ajax({
                    url: 'sendEmailServlet',
                    data: {
                        mes: $("#e_comments").val(),
                        to: $("#e_email").val(),
                        from: '<%=Emial %>',
                        sub: $("#e_name").val()


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        alert(data);
                        if (data === "1") {
                            reload();
                        } else if (data === "0") {

                            swal("PLEASE ENTER DATA FIRST !");

                        }



                    },
                    error: function () {

                    }
                });

            });
            $(".close").click(function () {
                
                $.ajax({
                    url: 'deleteShortcutServlet',
                    data: {
                        id: $(".close").val()


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {

                        if (data === "1") {
                            reload();
                        } else if (data === "0") {

                            swal("PLEASE ENTER DATA FIRST !");

                        }



                    },
                    error: function () {

                    }
                });

            });
            $("#c_shortcut").click(function () {
                var name = $('input[name="name_s"]').val();
                var url = $('input[name="url_s"]').val();
                if (url === '' || name === '') {
                    
                        swal("CAN'T LET ANY FIELD EMPTY !");

                } else {
                    if (name.length <= 20) {
                        $.ajax({
                            url: 'saveShortcutServlet',
                            data: {
                                name: name,
                                url: url

                            },
                            type: 'post',
                            cache: false,
                            success: function (data) {
                                
                                if (data === "1") {
                                    reload();
                                } else if (data === "0") {

                                    swal("PLEASE ENTER DATA FIRST !");

                                }



                            },
                            error: function () {
                                swal("TRY AGAIN !");
                            }
                        });

                    } else {
                        swal("NAME MUST BE SMALLER THAN 20 CHARACTERS !");

                    }

                }


            });

            function reload() {

                location.reload();

            }
        </script>

    </body>
</html>