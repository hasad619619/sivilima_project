<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.PoOrderItems"%>
<%@page import="java.util.Set"%>
<%@page import="resources.HoldInvoiceItem"%>
<%@page import="resources.Branch"%>
<%@page import="resources.Settings"%>
<%@page import="resources.Stock"%>
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
        <%            Session sesDetails = connection.getConnection.getSessionFactory().openSession();
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
        <%
            DecimalFormat df = new DecimalFormat("##########0.00");

            Session ses = connection.getConnection.getSessionFactory().openSession();
            Items ITEM = null;
            int item = 0;

            int branch = 0;
            String BranchN = "ALL";

            if (request.getParameter("b") != null && !request.getParameter("b").equals("")
                    && request.getParameter("a") != null && !request.getParameter("a").equals("")) {

                branch = Integer.parseInt(request.getParameter("b"));
                item = Integer.parseInt(request.getParameter("a"));

                if (!request.getParameter("a").equals("0")) {
                    ITEM = (Items) ses.load(Items.class, item);

                }

                if (!request.getParameter("b").equals("0")) {
                    Branch A = (Branch) ses.load(Branch.class, branch);
                    BranchN = A.getName();
                }

            }

        %>
        <div class="loader"></div>

        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item" style="font-size: 16px;" ><span class="fa fa-arrow-left ml-2 mr-2"></span><a href="stock.jsp">Go Back</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">Stock details</li>
                   
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="stocks.jsp" >
                            <div class="row">

                                
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">BRANCH</span>
                                        </div>
                                        <select class="form-control" name="b" id="b"  >
                                            <option value="0">ALL</option>
                                            <%                                            Criteria crb2 = ses.createCriteria(Branch.class);
                                                crb2.add(Restrictions.eq("status", 1));
                                                List<Branch> br2 = crb2.list();
                                                for (Branch BR : br2) {

                                            %>
                                            <option value="<%= BR.getIdbranch()%>"><%= BR.getName()%></option>
                                            <%
                                                }

                                            %>

                                        </select>
                                    </div>
                                            <input type="hidden" name="a" id="a" value="<%=item %>">

                                </div>
                                

                                <div class="col-md-4">

                                    <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                        <button type="submit" class="btn btn-success" id="save"><span class="fa fa-save mr-2"></span>FIND</button>

                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <%                if (ITEM != null   && branch >= 0) {
            %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-12">
                                <table class="col-md-6 table table-sm table-bordered">
                                    <tr>
                                        <td>BRANCH</td>
                                        <td><%=BranchN%></td>
                                    </tr>
                                    <tr>
                                        <td>ITEM NAME</td>
                                        <td><%=ITEM.getName() %></td>
                                    </tr>
                                    
                                    <tr>
                                        <td>SUPPLIER</td>
                                        <td><%=ITEM.getAccount().getName() %></td>
                                    </tr>
                                    <tr>
                                        <td>CATEGORY</td>
                                        <td><%=ITEM.getCategory().getName() %></td>
                                    </tr>
                                </table>
                            </div>
                        </div>


                    </div>
                </div>
            </div>


            <%
                }
            %>
            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-light" id="tbl1">
                            <thead>
                                <tr>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">Stock ID</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">Branch</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">Stock Date</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">Available Quantity</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">Cost</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">Total</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">Options</th>


                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Criteria cr = ses.createCriteria(Stock.class);
                                    if (branch > 0) {
                                        cr.createAlias("branch", "B");
                                        cr.add(Restrictions.eq("B.idbranch", branch));
                                    }
                                    if (item > 0) {
                                        cr.createAlias("items", "I");
                                        cr.add(Restrictions.eq("I.itemId", item));
                                    }
                                    List<Stock> de = cr.list();

                                    if (de.size() > 0) {
                                        for (Stock DE : de) {

                                            double total=0.0;
                                            
                                            

                                %>
                                <tr>
                                    <td><%=DE.getStockId()%></td>
                                    <td><%=DE.getBranch().getName() %></td>
                                    <td><%=DE.getDate() %></td>
                                    <td><%=df.format((double) Math.round(DE.getQty() * 100) / 100) + "  " + DE.getItems().getType().getName()%></td>
                                    <td><%="Rs."+df.format((double) Math.round(DE.getCost() * 100) / 100) %></td>
                                    <td><%="Rs."+df.format((double) Math.round((DE.getQty() * DE.getCost() ) * 100) / 100)%></td>
                                    <td>
                                        <a type="submit" class="btn btn-info btn-sm" href="viewstock.jsp?q=<%=DE.getStockId()%>" >VIEW PRICE</a>

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
        <script src="https://cdn.datatables.net/plug-ins/1.10.19/api/sum().js"></script>
        <script>
            $(window).load(function(){
                 $('.loader').fadeOut();
            });
    </script>

        <script type="text/javascript">
            function addCommas(nStr)
            {
                nStr += '';
                x = nStr.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1)) {
                    x1 = x1.replace(rgx, '$1' + ',' + '$2');
                }
                return x1 + x2;
            }

            $('#b').val(<%=branch%>);
            

            $(document).ready(function () {
                var table = $('#tbl1').DataTable();

                // Simply get the sum of a column

                jQuery.fn.dataTable.Api.register('sum()', function () {
                    return this.flatten().reduce(function (a, b) {
                        return (a * 1) + (b * 1); // cast values in-case they are strings
                    });
                });



                $("#tbl1").on('search.dt', function () {


                });
                ;


            });





        </script>


    </body>
</html>