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
            String DATA = "458";
            if (request.getParameter("i") != null && !request.getParameter("i").equals("")) {
                DATA = request.getParameter("i");
            }
            if (request.getSession().getAttribute("administrator") == null) {
                response.sendRedirect("login.jsp");
            }


        %>
        <%            
            Session sesDetails = connection.getConnection.getSessionFactory().openSession();
            Branch st = null;
            String Name = "";
            String Address = "";
            String Image = "";
            String Fax = "";
            String Contact = "";
            String Emial = "";
            String ID = "";
            

            if (request.getParameter("q") != null && !request.getParameter("q").equals("")) {
                try {
                    st = (Branch) sesDetails.load(Branch.class, Integer.parseInt(request.getParameter("q")));
                } catch (Exception e) {
                    response.sendRedirect("branch.jsp");
                }
            }

            if (st != null) {
                Name = st.getName();
                Address = st.getAddress();
                Image = st.getImage();
                Fax = st.getFax();
                Contact = st.getContact();
                Emial = st.getEmail();
                ID = st.getIdbranch().toString();
                
            } else {
                response.sendRedirect("branch.jsp");
            }
            
        %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="icon" href="src/image/favicon.ico">
        <title><%=Name%></title>

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
                height: 40px;

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
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Branch Logo Setup</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <h4>Branch ID : <%=ID%></h4>
                                </div>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">

                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Quotation Background</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="1">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" type="submit" style="background-color: #EE5A24 ;color: white;">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Purchase Order Background</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="2">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #009432 ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Invoice Background</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="3">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #0652DD ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Credit Invoice Background</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="11">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #0652DD ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Hold Invoice Background</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="4">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #F79F1F ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Receive Slip Cash</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="5">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #006266 ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Receive Slip Cheque</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="12">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #006266 ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Receive Slip Bank Deposit</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="13">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #006266 ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Expenses Slip Header</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="16">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #0097e6 ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>


                            </div>
                            <div class="col-md-6">
                                <div class="input-group mb-3">
                                    <h4>Branch Name : <%=Name%></h4>
                                </div>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Release Slip Cash</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="6">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #FFC312 ;color: white;"  id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Release Slip Cheque</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="14">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #FFC312 ;color: white;"  id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Release Slip Bank Deposit</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="15">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #FFC312 ;color: white;"  id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Deliver Order header</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="7">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #C4E538 ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">GRN Header</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="8">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #12CBC4 ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Invoice Header</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="9">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #ED4C67 ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>
                                <form action="saveLogoServlet" method="post" enctype="multipart/form-data">
                                    <div class="input-group mb-1">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:200px;" id="inputGroup-sizing-default">Default Footer</span>
                                        </div>
                                        <input type="hidden" required="" class="form-control" name="branch" id="branch" value="<%=ID%>">
                                        <input type="hidden" required="" class="form-control" name="type" id="type" value="10">
                                        <input type="file" required="" class="form-control" name="image" id="image">
                                        <button class="btn" style="background-color: #6F1E51 ;color: white;" id="save">UPDATE</button>

                                    </div>
                                </form>


                            </div>

                        </div>
                        <% if(st != null){%>
                        <div class="row mt-3">
                            <div class="col-md-12"><h5>SELECTED FILE LIST</h5></div>
                            <div class="col-md-6">
                                <h6>Quotation Background : <%=st.getQuotation()  %></h6>
                                <h6>Purchase Order Background : <%=st.getPo()  %></h6>
                                <h6>Invoice Background : <%=st.getInvoice()  %></h6>
                                <h6>Credit Invoice Background : <%=st.getCreditInvoice()%></h6>
                                <h6>Hold Invoice Background : <%=st.getHoldinvoice()  %></h6>
                                <h6>Receive Slip Cash : <%=st.getReceiveCash()%></h6>
                                <h6>Receive Slip Cheque : <%=st.getReceiveChe() %></h6>
                                <h6>Receive Slip Bank Deposit : <%=st.getReceiveBank() %></h6>
                                <h6>Expenses Slip Header : <%=st.getExpensesHeader() %></h6>
                                
                            </div>
                            <div class="col-md-6">
                                <h6>Release Slip Cash : <%=st.getReleaseCash()%></h6>
                                <h6>Release Slip Cheque : <%=st.getReleaseChe() %></h6>
                                <h6>Release Slip Bank Deposit : <%=st.getReleaseBank() %></h6>
                                <h6>Deliver Order Header : <%=st.getDoHeader()  %></h6>
                                <h6>GRN Header : <%=st.getGoodrnHeader()  %></h6>
                                <h6>Invoice Header: <%=st.getInvoiceHeader()  %></h6>
                                <h6>Default Footer : <%=st.getFooter()  %></h6>
                               
                            </div>
                        </div>
                        <% }%>        
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
            var data = "" +<%=DATA%>;
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

            }
        </script>


    </body>
</html>