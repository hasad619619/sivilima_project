<%@page import="resources.StockTransfer"%>
<%@page import="dataclass.helper"%>
<%@page import="resources.Branch"%>
<%@page import="resources.InvoiceRecipt"%>
<%@page import="resources.SaleInvoice"%>
<%@page import="resources.Settings"%>
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
        <link href="src/css/bootstrap-datepicker.min.css" rel="stylesheet">
    </head>

    <body>

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->

        <%
            Session ses = connection.getConnection.getSessionFactory().openSession();
            helper help = new helper();
            String Date = help.getDate();
            String Date2 = help.getDate();
            int branch = 0;

            if (request.getParameter("q") != null && !request.getParameter("q").equals("")
                    && request.getParameter("q2") != null && !request.getParameter("q2").equals("")
                    && request.getParameter("b") != null && !request.getParameter("b").equals("")) {
                Date = request.getParameter("q");
                Date2 = request.getParameter("q2");
                branch = Integer.parseInt(request.getParameter("b"));

                if (!request.getParameter("b").equals("0")) {
                    Branch B = (Branch) ses.load(Branch.class, branch);

                }

            }

        %>



        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-arrow-left"></span>&nbsp;<a href="stocktransfer.jsp">Back</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Stock Transfer History</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="sthistory.jsp" >
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text " style="width:100px;" id="inputGroup-sizing-default">ST: DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q" id="q" value="<%=Date%>">
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text " style="width:100px;" id="inputGroup-sizing-default">END DATE</span>
                                        </div>
                                        <input type="date"  class="form-control" name="q2" id="q2" value="<%=Date2%>">
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">BRANCH</span>
                                        </div>
                                        <select class="form-control" name="b" id="b"  >
                                            <option value="0">ALL</option>
                                            <%

                                                Criteria crb = ses.createCriteria(Branch.class);
                                                crb.add(Restrictions.eq("status", 1));
                                                List<Branch> br = crb.list();
                                                for (Branch BR : br) {

                                            %>
                                            <option value="<%= BR.getIdbranch()%>"><%= BR.getName()%></option>
                                            <%
                                                }

                                            %>

                                        </select>
                                    </div>


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


            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-active " id="tbl1">
                            <thead>
                                <tr style="background-color: #10ac84 !important; color: white !important; ">
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Item</th>
                                    <th>Qty</th>
                                    <th>Branch</th>
                                    <th>Details</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                  if (Date != "" && Date2 != "") {
                                        Criteria cr = ses.createCriteria(StockTransfer.class);
                                        cr.add(Restrictions.between("date", Date, Date2));
                                        if (branch > 0) {
                                            cr.createAlias("branchByToBranch", "A");
                                            cr.add(Restrictions.eq("A.idbranch", branch));
                                        }
                                        List<StockTransfer> de = cr.list();

                                        if (de.size() > 0) {
                                            for (StockTransfer DE : de) {


                                %>
                                <tr>
                                    <td><%=DE.getDate()%></td>
                                    <td><%=DE.getTime()%></td>
                                    <td><%=DE.getItems().getName().toUpperCase()%></td>
                                    <td><%=DE.getRequestQty() + " " + DE.getItems().getType().getName().toUpperCase()%></td>
                                    <td><%=DE.getBranchByToBranch().getName().toUpperCase() + " TO " + DE.getBranchByFromBranch().getName().toUpperCase()%></td>
                                    <% if (DE.getStatus() == 1) { %> 
                                    <td style="background-color: #33d9b2 !important; color: white !important; ">PENDING TO APPROVE</td>
                                    <% } else if (DE.getStatus() == 0) { %>
                                    <td style="background-color: #ff5252 !important; color: white !important; ">REQUEST REJECTED</td>
                                    <% } else if (DE.getStatus() == 2) {%>
                                    <td style="background-color: #ffb142 !important; color: white !important; ">REQUEST ACCEPTED</td>
                                    <% } else if (DE.getStatus() == 3) {%>
                                    <td style="background-color: #ff793f !important; color: white !important; ">CANCEL FROM REQUESTER</td>
                                    <% } else if (DE.getStatus() == 4) {%>
                                    <td style="background-color: #34ace0 !important; color: white !important; ">REQUEST DELIVERED</td>
                                    <%}%>
                                </tr>







                                <%
                                            }
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
        <script src="src/datepicker/dist/bootstrap-datepicker.min.js"></script>
        <script>

        </script>
        <script type="text/javascript">

            $('#b').val(<%=branch%>);

            $(document).ready(function () {
                $('#tbl1').DataTable({
                    dom: 'Blfrtip',
                    buttons: [

                        {
                            extend: 'copyHtml5',
                            exportOptions: {
                                columns: [0, 1, 2, 3, 4, 5]
                            }
                        },
                        {
                            extend: 'excelHtml5',
                            exportOptions: {
                                columns: [0, 1, 2, 3, 4, 5]
                            }
                        },
                        {
                            extend: 'pdfHtml5',
                            exportOptions: {
                                columns: [0, 1, 2, 3, 4, 5]
                            }
                        },
                        {
                            extend: 'print',
                            exportOptions: {
                                columns: [0, 1, 2, 3, 4, 5]
                            },
                            customize: function (win) {


                            }
                        },

                        'colvis'




                    ]

                });
            });





        </script>


    </body>
</html>