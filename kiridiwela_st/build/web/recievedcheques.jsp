<%@page import="dataclass.helper"%>
<%@page import="resources.Branch"%>
<%@page import="resources.PurchusInvoiceRecipt"%>
<%@page import="resources.PurchusInvoice"%>
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
    </head>

    <body>

        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->
        <%
            Session ses=connection.getConnection.getSessionFactory().openSession(); 
            helper help=new helper();
            String Date=help.getDate();
            String Date2=help.getDate();
            String BranchN="ALL";
            String AccountN="ALL";
            
            int branch=0;
            int account=0;
            
            
           
            if (request.getParameter("q") != null && !request.getParameter("q").equals("") 
                    && request.getParameter("q2") != null && !request.getParameter("q2").equals("") 
                    && request.getParameter("b") != null && !request.getParameter("b").equals("") 
                    && request.getParameter("a") != null && !request.getParameter("a").equals("") ) {
                Date=request.getParameter("q");
                Date2=request.getParameter("q2");
                branch=Integer.parseInt(request.getParameter("b"));
                account=Integer.parseInt(request.getParameter("a"));
                if(! request.getParameter("b").equals("0")){
                 Branch B=(Branch) ses.load(Branch.class, branch);
                 BranchN=B.getName();
                }
                if(! request.getParameter("a").equals("0")){
                Account A=(Account) ses.load(Account.class, account);
                AccountN=A.getName();
                }
                 
                
            }

        %>


        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" style="font-size: 16px;" aria-current="page">Received Cheques</li>
                    </ol>
                </nav>
            </div>
            
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="recievedcheques.jsp" >
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:120px;" id="inputGroup-sizing-default">START DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q" id="q" value="<%=Date %>">
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:120px;" id="inputGroup-sizing-default">END DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q2" id="q2" value="<%=Date2 %>">
                                    </div>


                                </div>
                                    <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:120px;" id="inputGroup-sizing-default">BRANCH</span>
                                        </div>
                                       <select class="form-control" name="b" id="b"  >
                                           <option value="0">ALL</option>
                                        <%
                                           
                                            Criteria crb=ses.createCriteria(Branch.class);
                                            crb.add(Restrictions.eq("status", 1));
                                            List<Branch> br=crb.list();
                                            for(Branch BR:br){
                                            
                                            %>
                                                <option value="<%= BR.getIdbranch() %>"><%= BR.getName() %></option>
                                        <%
                                            }
                                            
                                            %>
                                                
                                    </select>
                                    </div>


                                </div>
                                    <div class="col-md-8">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:120px;" id="inputGroup-sizing-default">ACCOUNT</span>
                                        </div>
                                        <select class="form-control" name="a" id="a"  >
                                           <option value="0">ALL</option>
                                        <%
                                           
                                            Criteria cra=ses.createCriteria(Account.class);
                                            cra.add(Restrictions.eq("status", 1));
                                            List<Account> bra=cra.list();
                                            for(Account BR:bra){
                                            
                                            %>
                                                <option value="<%= BR.getIdaccount() %>"><%= BR.getName() %></option>
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
                        <table class="table table-light" id="tbl1">
                            <thead>
                                <tr>
                                    <th id="dev_id" class="dev_id" > id</th>
                                    <th>Account</th>
                                    <th>Date</th>
                                    <th>Cheque date</th>
                                    <th>number</th>
                                    <th>amount</th>
                                    <th>Status</th>
                                    <th>Cheque Branch</th>
                                    <th>Branch</th>
                                    <th>option</th>





                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(Date != "" && Date2 != ""){
                                    
                                    
                                    Criteria cr = ses.createCriteria(InvoiceRecipt.class);
                                    cr.add(Restrictions.eq("status", 1)); 
                                    cr.add(Restrictions.between("cheDate", Date, Date2));
                                    List<InvoiceRecipt> de = cr.list();

                                    if (de.size() > 0) {
                                        for (InvoiceRecipt DE : de) {
                                            if (DE.getPaymentType().getIdpaymentType() == 3) {
                                                
                                            
                                           if(branch > 0 && account ==0){
                                                 if(branch==DE.getBranch().getIdbranch()){
                                                     %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountByCustomer().getName()%></td>
                                                            <td><%=DE.getDate()%></td>
                                                            <td><%=DE.getCheDate()%></td>
                                                            <td><%=DE.getCheNumber()%></td>
                                                            <td>RS <%=DE.getAmount() %></td>
                                                            <%
                                                                if (DE.getCheStatus() == 0) {
                                                            %>
                                                            <td>RETURNED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 1) {
                                                            %>
                                                            <td>PD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>DEPOSITED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID TO THIRD PARTY</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch() %></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountByCustomer().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <%if(DE.getCheStatus() == 2){
                                                                    %>
                                                                    <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getBank() %>">
                                                                    <%
                                                                }else{
                                                                    %>
                                                                    <input name="i_cbank" id="i_cbank" type="hidden" value="<%="NOT DEPOSITED YET" %>">
                                                                    <% } %>
                                                                
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountByCustomer().getIdaccount() %>">
                                                             <button  class="btn btn-info btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">status</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                                 }
                                           }else if(account > 0 && branch==0){
                                               if(account==DE.getAccountByCustomer().getIdaccount()){
                                                   %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountByCustomer().getName()%></td>
                                                            <td><%=DE.getDate()%></td>
                                                            <td><%=DE.getCheDate()%></td>
                                                            <td><%=DE.getCheNumber()%></td>
                                                            <td>RS <%=DE.getAmount() %></td>
                                                            <%
                                                                if (DE.getCheStatus() == 0) {
                                                            %>
                                                            <td>RETURNED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 1) {
                                                            %>
                                                            <td>PD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>DEPOSITED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID TO THIRD PARTY</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_id" id="i_amount" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                 <input name="i_amount" id="i_id" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountByCustomer().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <%if(DE.getCheStatus() == 2){
                                                                    %>
                                                                    <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getBank() %>">
                                                                    <%
                                                                }else{
                                                                    %>
                                                                    <input name="i_cbank" id="i_cbank" type="hidden" value="<%="NOT DEPOSITED YET" %>">
                                                                    <% } %>
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountByCustomer().getIdaccount() %>">
                                                             <button  class="btn btn-info btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">status</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                               }
                                           }else if(account == 0 && branch == 0){
                                               %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountByCustomer().getName()%></td>
                                                            <td><%=DE.getDate()%></td>
                                                            <td><%=DE.getCheDate()%></td>
                                                            <td><%=DE.getCheNumber()%></td>
                                                            <td>RS <%=DE.getAmount() %></td>
                                                            <%
                                                                if (DE.getCheStatus() == 0) {
                                                            %>
                                                            <td>RETURNED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 1) {
                                                            %>
                                                            <td>PD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>DEPOSITED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID TO THIRD PARTY</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountByCustomer().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                               <%if(DE.getCheStatus() == 2){
                                                                    %>
                                                                    <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getBank() %>">
                                                                    <%
                                                                }else{
                                                                    %>
                                                                    <input name="i_cbank" id="i_cbank" type="hidden" value="<%="NOT DEPOSITED YET" %>">
                                                                    <% } %>
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountByCustomer().getIdaccount() %>">
                                                             <button  class="btn btn-info btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">status</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                           }else if(account > 0 && branch >  0){
                                              if(account==DE.getAccountByCustomer().getIdaccount() && branch==DE.getBranch().getIdbranch() ){
                                                  %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountByCustomer().getName()%></td>
                                                            <td><%=DE.getDate()%></td>
                                                            <td><%=DE.getCheDate()%></td>
                                                            <td><%=DE.getCheNumber()%></td>
                                                            <td>RS <%=DE.getAmount() %></td>
                                                            <%
                                                                if (DE.getCheStatus() == 0) {
                                                            %>
                                                            <td>RETURNED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 1) {
                                                            %>
                                                            <td>PD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>DEPOSITED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID TO THIRD PARTY</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                 <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountByCustomer().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                              <%if(DE.getCheStatus() == 2){
                                                                    %>
                                                                    <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByCustomer().getName() %>">
                                                                    <%
                                                                }else{
                                                                    %>
                                                                    <input name="i_cbank" id="i_cbank" type="hidden" value="<%="NOT DEPOSITED YET" %>">
                                                                    <% } %>
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountByCustomer().getIdaccount() %>">
                                                             
                                                                <button  class="btn btn-info btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">status</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                              }     
                                                    
                                           }

                                            }
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

        <div class="modal fade" tabindex="-1" role="dialog" id="myModal">
            <div class="modal-dialog modal-lg" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Received Cheque Processing</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                  <div class="modal-body" style="padding-left: 25px;padding-right: 25px;">
                    <div class="row" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); padding: 15px 15px 15px 15px;">
                        <div class="col-md-6">
                            <p>Receipt Number: <span id="col_1"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p>Cheque Amount:RS <span id="col_11"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p>Account: <span id="col_2"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p>Received Date: <span id="col_3"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p>Received User: <span id="col_4"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p>Cheque Number: <span id="col_5"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p>Cheque Date: <span id="col_6"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p>Deposited To Bank: <span id="col_7"></span></p>
                        </div>
                        <div class="col-md-6">
                            <p>Bank Branch: <span id="col_8"></span></p>
                        </div> 
                        <div class="col-md-6">
                            <p>Currant Status: <span id="col_10"></span></p>
                        </div> 
                        <input type="hidden" name="ii_d" id="ii_d">
                    </div>
                </div>
                <div class="modal-footer">
                  <div class="col-md-11">
                       <div class="btn-group mb-3" role="group" aria-label="Basic example">
                           
                           <button  class="btn btn-dark btn_return" id="btn_return" ><span class="fa fa-book mr-2"></span>RETURN</button>
                           <button  class="btn btn-success btn_deposit" id="btn_deposit" ><span class="fa fa-book mr-2"></span>DEPOSIT</button>
                           <button  class="btn btn-dark btn_delete" id="btn_delete" ><span class="fa fa-book mr-2"></span>DELETE</button>
                           <button  class="btn btn-success btn_paytothird" id="btn_paytothird" ><span class="fa fa-book mr-2"></span>PAY TO THIRD PARTY</button>
                                        


                       </div>


                 </div>
                  
                </div>
              </div>
            </div>
        </div>
        
        <div class="modal fade" tabindex="-1" role="dialog" id="myModal6">
            <div class="modal-dialog " role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">choose Bank to Deposit cheque</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                  <div class="modal-body" style="padding-left: 25px;padding-right: 25px;">
                    <div class="row" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); padding: 15px 15px 15px 15px;">
                        <div class="col-md-12">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">BANK</span>
                                        </div>
                                        <select class="form-control" name="acc_bank" id="acc_bank"  >
                                           <option value="0">CHOOSE ACCOUNT TO PAY</option>
                                        <%
                                            Session ss=connection.getConnection.getSessionFactory().openSession();
                                            Criteria cracs=ss.createCriteria(Account.class);
                                            cracs.add(Restrictions.eq("status", 1));
                                            cracs.add(Restrictions.eq("bank", 1));
                                            List<Account> bracs=cracs.list();
                                            for(Account BR:bracs){
                                            
                                            %>
                                                <option value="<%= BR.getIdaccount() %>"><%= BR.getName() %></option>
                                        <%
                                            }
                                            ss.close();
                                            %>
                                                
                                    </select>
                                    </div>


                                </div>
                       
                    </div>
                </div>
                <div class="modal-footer">
                  <div class="col-md-11">
                       <div class="btn-group mb-3" role="group" aria-label="Basic example">
                           
                           <button  class="btn btn-dark btn_pay_b" id="btn_pay_b" ><span class="fa fa-book mr-2"></span>PAY NOW</button>
                                       


                       </div>


                 </div>
                  
                </div>
              </div>
            </div>
        </div>
        
        <div class="modal fade" tabindex="-1" role="dialog" id="myModal2">
            <div class="modal-dialog " role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">choose account to pay cheque</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                  <div class="modal-body" style="padding-left: 25px;padding-right: 25px;">
                    <div class="row" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); padding: 15px 15px 15px 15px;">
                        <div class="col-md-12">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">ACCOUNT</span>
                                        </div>
                                        <select class="form-control" name="acc" id="acc"  >
                                           <option value="0">CHOOSE ACCOUNT TO PAY</option>
                                        <%
                                            Session s=connection.getConnection.getSessionFactory().openSession();
                                            Criteria crac=s.createCriteria(Account.class);
                                            crac.add(Restrictions.eq("status", 1));
                                            crac.add(Restrictions.eq("supplier", 1));
                                            List<Account> brac=crac.list();
                                            for(Account BR:brac){
                                            
                                            %>
                                                <option value="<%= BR.getIdaccount() %>"><%= BR.getName() %></option>
                                        <%
                                            }
                                            s.close();
                                            %>
                                                
                                    </select>
                                    </div>


                                </div>
                       
                    </div>
                </div>
                <div class="modal-footer">
                  <div class="col-md-11">
                       <div class="btn-group mb-3" role="group" aria-label="Basic example">
                           
                           <button  class="btn btn-dark btn_pay" id="btn_pay" ><span class="fa fa-book mr-2"></span>PAY NOW</button>
                                       


                       </div>


                 </div>
                  
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
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.colVis.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.print.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script type="text/javascript">

            $('#b').val(<%=branch %>);
            $('#a').val(<%=account %>);
            
            var ReciptID=0;
            var AccID=0;
            var T=0;
            
           $('.view_dev').click(function (){
                ReciptID=$(this).closest('tr').find('input[name="i_id"]').val();
                
                var i_id=$(this).closest('tr').find('input[name="i_id"]').val();
                var i_name=$(this).closest('tr').find('input[name="i_name"]').val();
                var i_date=$(this).closest('tr').find('input[name="i_date"]').val();
                var i_cdate=$(this).closest('tr').find('input[name="i_cdate"]').val();
                var i_cnum=$(this).closest('tr').find('input[name="i_cnum"]').val();
                var i_bran=$(this).closest('tr').find('input[name="i_cbran"]').val();
                var i_acc_id=$(this).closest('tr').find('input[name="i_acc_id"]').val();
                var i_user=$(this).closest('tr').find('input[name="i_user"]').val();
                var i_bank=$(this).closest('tr').find('input[name="i_cbank"]').val();
                var i_cstat=$(this).closest('tr').find('input[name="i_cstat"]').val();
                var i_amount=$(this).closest('tr').find('input[name="i_amount"]').val();
                
                AccID=i_acc_id;
                
                var curr_stat="";
                
               
                $('#btn_delete').hide();
                $('#btn_return').hide();
                $('#btn_paytothird').hide();
                $('#btn_deposit').hide();
                 
                if(i_cstat === '0'){
                    curr_stat="Returned";
                   
                }else if(i_cstat === '2'){
                    curr_stat="Deposited To Bank";
                    $('#btn_return').show();
                    
                }else if(i_cstat === '3'){
                    curr_stat="Paid To Third Party";
                    //$('#btn_return').show();
                    
                }else if(i_cstat === '1'){
                    curr_stat="PD";
                    $('#btn_delete').show();
                    $('#btn_return').show();
                    $('#btn_paytothird').show();
                    $('#btn_deposit').show();
                }
                
                $('#col_1').html(""+i_id);
                $('#col_2').html(""+i_name);
                $('#col_3').html(""+i_date);
                $('#col_4').html(""+i_user);
                $('#col_5').html(""+i_cnum);
                $('#col_6').html(""+i_cdate);
                $('#col_7').html(""+i_bank);
                $('#col_8').html(""+i_bran);
                $('#col_10').html(""+curr_stat);
                $('#col_11').html(""+i_amount);
                $('#ii_d').html(""+i_acc_id);
                
                $('#myModal').modal('show');
           });
           
           $('#btn_return').click(function (){
               changeStatus(0,AccID,ReciptID,T);
           });
           $('#btn_deposit').click(function (){
              $('#myModal').modal('hide');
               $('#myModal6').modal('show');
           });
           $('#btn_delete').click(function (){
              changeStatus(94,AccID,ReciptID,T);
           });
           
           $('#btn_paytothird').click(function (){
               $('#myModal').modal('hide');
               $('#myModal2').modal('show');
           });
           $('#btn_pay').click(function (){
               T=$('#acc').val();
               if(T === '0'){
                   swal("Please Select Account !");
               }else{
                   changeStatus(3,AccID,ReciptID,T);
                   
               }
               $('#myModal2').modal('hide');
           });
           
           $('#btn_pay_b').click(function (){
               T=$('#acc_bank').val();
               if(T === '0'){
                   swal("Please Select Bank Account !");
               }else{
                   changeStatus(2,AccID,ReciptID,T);
                   
               }
               $('#myModal2').modal('hide');
           });

           function changeStatus(stat,acc_id,receptid,t){
               if(acc_id === 0 || receptid === 0){
                   
                   swal("empty data please retry !");
                   
               }else{
                                $.ajax({
                                 url: 'changeChequeStatServlet',
                                 data: {
                                         stat: stat,
                                         acc: acc_id,
                                         t: t,
                                         id: receptid


                                 },
                                 type: 'post',
                                 cache: false,
                                 success: function (data) {
                                 if (data === "1") {

                                 swal({
                                 title: "Good job!",
                                         text: "you updated Cheque Details !",
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
                                 }else if (data === "3") {
                                 swal({
                                 title: "Access Denide ! !",
                                         text: "please log using admin account.",
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
               
               
           }

            $(document).ready(function () {
                $('#tbl1').DataTable({
                    dom: 'Blfrtip',
                    buttons: [
                        {
                            extend: 'copyHtml5',
                            exportOptions: {
                                columns: [0, 1, 2, 3, 4, 5, 6]
                            }
                        },
                        {
                            extend: 'excelHtml5',
                            exportOptions: {
                                columns: [0, 1, 2, 3, 4, 5, 6]
                            }
                        },
                        {
                            extend: 'pdfHtml5',
                            exportOptions: {
                                columns: [0, 1, 2, 3, 4, 5, 6]
                            }
                        },
                        {
                            extend: 'print',
                            exportOptions: {
                                columns: [0, 1, 2, 3, 4, 5, 6]
                            }
                        },
                        'colvis'




                    ]

                });
            });




        </script>


    </body>
</html>