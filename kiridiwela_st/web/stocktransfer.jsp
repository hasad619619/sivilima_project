<%@page import="dataclass.userHolder"%>
<%@page import="resources.StockTransfer"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
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
            User admin = null;
            int branch_id= 0;
            userHolder USER = null;
            if (request.getSession().getAttribute("administrator") == null) {
                response.sendRedirect("login.jsp");
            }else{
               admin  = (User) request.getSession().getAttribute("administrator");
               branch_id = admin.getBranch().getIdbranch();
               USER =(userHolder) request.getSession().getAttribute("userHolder");
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
        <%if(USER != null){ %>
        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->


        <%
                                    
                                    double inbox = 0;
                                    double pending_aprove = 0;
                                    double pending_recive = 0;
                                    double reject = 0;
                                    
                                    Session ses = connection.getConnection.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(StockTransfer.class);
                                    List<StockTransfer> de = cr.list();
                                    
                                    
                                    if (de.size() > 0) {
                                        for ( StockTransfer DE : de) {
                                            if(branch_id == DE.getBranchByFromBranch().getIdbranch() ){
                                                if(DE.getStatus() == 1){
                                                    pending_aprove ++;
                                                }
                                                if(DE.getStatus() == 2){
                                                    pending_recive ++;
                                                }
                                                if(DE.getStatus() == 0){
                                                    reject ++;
                                                }
                                            }else{
                                                if(branch_id == DE.getBranchByToBranch().getIdbranch()){
                                                    if(DE.getStatus() == 1){
                                                        inbox ++;
                                                    }
                                                }
                                            }  
                                        }
                                    }

            %>
        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Stock Transfer</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <a class="btn mr-1" href="sthistory.jsp" style="color: white;background-color: #2f3640 !important;">REQUEST STOCKS HISTORY</a> 
                               
            </div>
            <div class="row mt-2">
                <div class="card col-sm-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        
                        <div class="row">
                            <div class="btn-group" role="group">
                                
                               <%if(USER.getStocks().contains("A") ){ %>
                               <a class="btn mr-1" href="requeststock.jsp" style="color: white;background-color: #f9ca24 !important;">REQUEST STOCKS</a> 
                               <% } %>
                               <%if(USER.getAccount().contains("B") ){ %>
                               <a class="btn mr-1" href="requestinbox.jsp" style="color: white;background-color: #686de0 !important;">REQUEST IN BOX (<%=inbox %>) </a>
                               <% } %>
                               <%if(USER.getAccount().contains("C") ){ %>
                               <a class="btn mr-1" href="requestedstocks.jsp" style="color: white;background-color: #6ab04c !important;">PENDING TO APPROVE (<%=pending_aprove %>)</a>
                               <% } %>
                               <%if(USER.getAccount().contains("D") ){ %>
                               <a class="btn mr-1" href="recievestocks.jsp" style="color: white;background-color: #badc58 !important;">PENDING TO RECEIVE (<%=pending_recive %>)</a>
                               <% } %>
                               <%if(USER.getAccount().contains("E") ){ %>
                               <a class="btn mr-1" href="rejectedrequest.jsp" style="color: white;background-color: #ff9f43 !important;">REJECTED REQUESTS (<%=reject %>)</a>
                               <% } %>
                               <%if(USER.getAccount().contains("F") ){ %>
                               <a class="btn mr-1" href="stock.jsp" style="color: white;background-color: #eb4d4b !important;">VIEW STOCKS BRANCH</a>
                               <% } %>
                               
                            </div>
                            
                            <div class="col ">
                                
                            </div>
                            <div class="col">
                               
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

        

    <%} else{ response.sendRedirect("login.jsp"); } %>       
    </body>
</html>