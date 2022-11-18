<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="resources.Settings"%>
<%@page import="java.util.List"%>
<!--A Design by W3layouts
   Author: W3layout
   Author URL: http://w3layouts.com
   License: Creative Commons Attribution 3.0 Unported
   License URL: http://creativecommons.org/licenses/by/3.0/
   -->
<!DOCTYPE html>
<html lang="en">

<head>
    
    <!-- Meta tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Allied Login Form Responsive Widget, Audio and Video players, Login Form Web Template, Flat Pricing Tables, Flat Drop-Downs, Sign-Up Web Templates, Flat Web Templates, Login Sign-up Responsive Web Template, Smartphone Compatible Web Template, Free Web Designs for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design"
    />
    <script>
        addEventListener("load", function () { setTimeout(hideURLbar, 0); }, false); function hideURLbar() { window.scrollTo(0, 1); }
    </script>
    <!-- Meta tags -->
    <!-- font-awesome icons -->
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <!-- //font-awesome icons -->
    <!--stylesheets-->
    <link href="css/style.css" rel='stylesheet' type='text/css' media="all">
    <!--//style sheet end here-->
    <link href="//fonts.googleapis.com/css?family=Montserrat:300,400,500,600" rel="stylesheet">
    <link href="//fonts.googleapis.com/css?family=Open+Sans:400,600,700" rel="stylesheet">
</head>

<body style="padding-top: 30px;">
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
        <title><%=Name %></title>
    <div class="w3layouts-two-grids"  >
        <div class="mid-class">
            <div class="txt-left-side">
                <h2> Login Here </h2>
                <p>please enter username , password and then click login now button or hit enter.</p>
                
                    <div class="form-left-to-w3l">
                        <span class="fa fa-envelope-o" aria-hidden="true"></span>
                        <input type="text" name="un" id="un" placeholder="Username" required="">

                        <div class="clear"></div>
                    </div>
                    <div class="form-left-to-w3l ">

                        <span class="fa fa-lock" aria-hidden="true"></span>
                        <input type="password" name="pw" id="pw" placeholder="Password" required="">
                        <div class="clear"></div>
                    </div>
                    <div class="main-two-w3ls">
                        
                    </div>
                    <div class="btnn">
                        <button type="button" id="login" style="background-color:  #27ae60;" >Login </button>
                    </div>
                
                <div class="w3layouts_more-buttn">
                    
                </div>

            </div>
            <div class="img-right-side">
                
                <img src="images/splash.png" class="img-fluid" alt="">
            </div>
        </div>
    </div>
    <footer class="copyrigh-wthree">
        <p>
            © 2019 All Rights Reserved V 2.8 Beta
        </p>
    </footer>
<script src="src/jquery/jquery-1.11.1.min.js" ></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
            $('#un').focus();
            

            $('#un').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    $('#pw').focus();
                }
            });
            $('#pw').keypress(function (e) {
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    getLogin();
                }
            });

            $("#login").click(function () {
                getLogin();

            }
            );

            function getLogin() {
                $.ajax({
                    url: 'getLoginServlet',
                    data: {
                        email: $('input[name="un"]').val(),
                        password: $('input[name="pw"]').val()


                    },
                    type: 'post',
                    cache: false,
                    success: function (data) {
                        if (data === "1") {

                            window.location.replace("index.jsp");


                        } else if (data === "0") {
                            swal({
                                title: "Empty field data !",
                                text: "Can't let any field empty.",
                                icon: "error",
                                button: "OK"
                            });


                        } else if (data === "2") {
                            swal({
                                title: "incorect username or password !",
                                text: "username or password you enterd, is wrong.",
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
                }
                );
            }

        </script>
    
</body>
    

</html>