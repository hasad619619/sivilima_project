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
            String Date="";
            String Date2="";
            String BranchN="ALL";
            String AccountN="ALL";
            
            int branch=0;
            int account=0;
            int ty=0;
            
            double total_released= 0.0;
            double total_paid= 0.0;
            double total_od= 0.0;
            double total_returned= 0.0;
            double total_deleted= 0.0;
           
            if (request.getParameter("q") != null && !request.getParameter("q").equals("") 
                    && request.getParameter("q2") != null && !request.getParameter("q2").equals("") 
                    && request.getParameter("b") != null && !request.getParameter("b").equals("") 
                    && request.getParameter("a") != null && !request.getParameter("a").equals("") 
                    &&  request.getParameter("ty") != null && !request.getParameter("ty").equals("") ) {
                Date=request.getParameter("q");
                Date2=request.getParameter("q2");
                branch=Integer.parseInt(request.getParameter("b"));
                account=Integer.parseInt(request.getParameter("a"));
                ty=Integer.parseInt(request.getParameter("ty"));
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
                        <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Issued Cheque Proccesign Reports</li>
                    </ol>
                </nav>
            </div>
            
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="issuedchequereportsdate.jsp" >
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">ST: DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q" id="q" value="<%=Date %>">
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">END DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q2" id="q2" value="<%=Date2 %>">
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
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">ACCOUNT</span>
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

                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:100px;" id="inputGroup-sizing-default">STATUS</span>
                                        </div>
                                        <select class="form-control" name="ty" id="ty"  >
                                           <option value="100">ALL</option>
                                           <option value="0">RETURNED</option>
                                           <option value="1">RELEASED</option>
                                           <option value="3">PAID BY BANK</option>
                                           <option value="94">DELETED</option>
                                           <option value="2">OD</option>
                                           
                                                 
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
                                            <%
                if ( Date != "" && Date2 != "") {
            %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-6">
                                <h6 id="EA">Account Name: <%= AccountN %></h6>    
                                <h6 id="EB">Branch Name: <%= BranchN %></h6>    
                                <h6 id="SD">Start Date: <%= Date %></h6>    
                                <h6 id="ED">End Date: <%= Date2 %></h6>    
                                 


                            </div>
                            <div class="col-md-6">
                                <h6 id="A">Total Released RS: </h6>    
                                <h6 id="B">Total Paid From Bank RS: </h6>       
                                <h6 id="C">Total OD RS: </h6>       
                                <h6 id="D">Total Returned RS: </h6>       
                                <h6 id="E">Total Deleted RS: </h6>       

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
                                    
                                    
                                    Criteria cr = ses.createCriteria(PurchusInvoiceRecipt.class);
                                     cr.add(Restrictions.between("cheDate", Date, Date2));
                                    if(ty == 94){
                                        cr.add(Restrictions.eq("status", 0)); 
                                    }else{
                                        cr.add(Restrictions.eq("status", 1));    
                                    }
                                    
                                    List<PurchusInvoiceRecipt> de = cr.list();

                                    if (de.size() > 0) {
                                        for (PurchusInvoiceRecipt DE : de) {
                                            if (DE.getPaymentType().getIdpaymentType() == 3) {
                                                
                                                if(ty == 100){
                                                    if(branch > 0 && account ==0){
                                                 if(branch==DE.getBranch().getIdbranch()){
                                                    switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                                     %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName() %></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier() .getIdaccount() %>">
                                                             <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                                 }
                                           }else if(account > 0 && branch==0){
                                               if(account==DE.getAccountBySupplier().getIdaccount()){
                                                    switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                                   %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName()%></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_id" id="i_amount" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                 <input name="i_amount" id="i_id" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier().getIdaccount() %>">
                                                             <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                               }
                                           }else if(account == 0 && branch == 0){
                                                switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                               %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName()%></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier().getIdaccount() %>">
                                                             <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                           }else if(account > 0 && branch >  0){
                                              if(account==DE.getAccountBySupplier().getIdaccount() && branch==DE.getBranch().getIdbranch() ){
                                                switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                                  %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName()%></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                 <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier().getIdaccount() %>">
                                                             
                                                                <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                              }     
                                                    
                                           }
                                                }else if(ty == 94){
                                                    if(branch > 0 && account ==0){
                                                 if(branch==DE.getBranch().getIdbranch()){
                                                    switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                                     %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName() %></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier() .getIdaccount() %>">
                                                             <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                                 }
                                           }else if(account > 0 && branch==0){
                                               if(account==DE.getAccountBySupplier().getIdaccount()){
                                                    switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                                   %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName()%></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_id" id="i_amount" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                 <input name="i_amount" id="i_id" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier().getIdaccount() %>">
                                                             <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                               }
                                           }else if(account == 0 && branch == 0){
                                                switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                               %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName()%></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier().getIdaccount() %>">
                                                             <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                           }else if(account > 0 && branch >  0){
                                              if(account==DE.getAccountBySupplier().getIdaccount() && branch==DE.getBranch().getIdbranch() ){
                                                switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                                  %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName()%></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                 <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier().getIdaccount() %>">
                                                             
                                                                <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                              }     
                                                    
                                           }
                                                }else{
                                                    if(ty == DE.getCheStatus()){
                                                        if(branch > 0 && account ==0){
                                                 if(branch==DE.getBranch().getIdbranch()){
                                                    switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                                     %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName() %></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier() .getIdaccount() %>">
                                                             <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                                 }
                                           }else if(account > 0 && branch==0){
                                               if(account==DE.getAccountBySupplier().getIdaccount()){
                                                    switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                                   %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName()%></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_id" id="i_amount" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                 <input name="i_amount" id="i_id" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier().getIdaccount() %>">
                                                             <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                               }
                                           }else if(account == 0 && branch == 0){
                                                switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                               %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName()%></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier().getIdaccount() %>">
                                                             <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                           }else if(account > 0 && branch >  0){
                                              if(account==DE.getAccountBySupplier().getIdaccount() && branch==DE.getBranch().getIdbranch() ){
                                                switch(ty){
                                                        case 100 :
                                                        if(DE.getStatus() == 0){
                                                            total_deleted = total_deleted + DE.getAmount(); 
                                                        }else{
                                                            if(DE.getCheStatus() == 0 ){
                                                                total_returned = total_returned + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 1 ){
                                                                total_released = total_released + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 2 ){
                                                                total_od = total_od + DE.getAmount(); 
                                                            }
                                                            if(DE.getCheStatus() == 3 ){
                                                                total_paid = total_paid + DE.getAmount(); 
                                                            }
                                                        
                                                        }    
                                                        break;
                                                        case 94 :
                                                            total_deleted = total_deleted + DE.getAmount();
                                                        break;
                                                        case 0 :
                                                            total_returned = total_returned + DE.getAmount();
                                                        break;
                                                        case 1 :
                                                             total_released = total_released + DE.getAmount();
                                                        break;
                                                        case 2 :
                                                             total_od = total_od + DE.getAmount(); 
                                                        break;
                                                        case 3 :
                                                            total_paid = total_paid + DE.getAmount(); 
                                                        break;
                                                    
                                                    }
                                                  %>
                                                        <tr>
                                                            <td><%=DE.getIdinvoiceRecipt()%></td>
                                                            <td><%=DE.getAccountBySupplier().getName()%></td>
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
                                                            <td>RELEASED</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 2) {
                                                            %>
                                                            <td>OD</td>
                                                            <%
                                                                }
                                                            %>
                                                            <%
                                                                if (DE.getCheStatus() == 3) {
                                                            %>
                                                            <td>PAID FROM BANK</td>
                                                            <%
                                                                }
                                                            %>

                                                            <td><%=DE.getChequeBranch()%></td>
                                                            <td><%=DE.getBranch().getName()%></td>



                                                            <td>
                                                                 <input name="i_amount" id="i_amount" type="hidden" value="<%=DE.getAmount() %>">
                                                                <input name="i_id" id="i_id" type="hidden" value="<%=DE.getIdinvoiceRecipt()%>">
                                                                <input name="i_name" id="i_name" type="hidden" value="<%= DE.getAccountBySupplier().getName() %>">
                                                                <input name="i_date" id="i_date" type="hidden" value="<%= DE.getDate() %>">
                                                                <input name="i_cdate" id="i_cdate" type="hidden" value="<%=DE.getCheDate() %>">
                                                                <input name="i_cnum" id="i_cnum" type="hidden" value="<%=DE.getCheNumber() %>">
                                                                <input name="i_cstat" id="i_cstat" type="hidden" value="<%=DE.getCheStatus() %>">
                                                                <input name="i_cbran" id="i_cbran" type="hidden" value="<%=DE.getChequeBranch() %>">
                                                                <input name="i_branch" id="i_branch" type="hidden" value="<%=DE.getBranch().getName() %>">
                                                                <input name="i_user" id="i_user" type="hidden" value="<%=DE.getUser().getName() %>">
                                                                <input name="i_cbank" id="i_cbank" type="hidden" value="<%=DE.getAccountByBank().getName() %>">
                                                                <input name="i_acc_id" id="i_acc_id" type="hidden" value="<%=DE.getAccountBySupplier().getIdaccount() %>">
                                                             
                                                                <button  class="btn btn-outline-dark btn-sm view_dev"  value='<%=DE.getIdinvoiceRecipt()%>' value="">view</button>

                                                            </td>
                                                        </tr>

                                                    <%
                                              }     
                                                    
                                           }
                                                    
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
                  <h5 class="modal-title">Issued Cheque Details</h5>
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
                            <p>Bank: <span id="col_7"></span></p>
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

            var A=<%=total_released %>;
            var B=<%=total_paid %>;
            var C=<%=total_od %>;
            var D=<%=total_returned %>;
            var E=<%=total_deleted %>;
            if(A=== ''){
                A='0.00';
                
            }
            if(B=== ''){
                B='0.00';
                
            }
            if(C=== ''){
                C='0.00';
                
            }
            if(D=== ''){
                D='0.00';
                
            }
            if(E=== ''){
                E='0.00';
                
            }
            $('#A').html("Total Released RS:"+A);
            $('#B').html("Total Paid From Bank RS:"+B);
            $('#C').html("Total OD RS:"+C);
            $('#D').html("Total Returned RS:"+D);
            $('#E').html("Total Deleted RS:"+E);
            
            $('#b').val(<%=branch %>);
            $('#a').val(<%=account %>);
            $('#ty').val(<%=ty %>);
            
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
                
               
                
                if(i_cstat === '0'){
                    curr_stat="Returned";
                   
                }else if(i_cstat === '2'){
                    
                    curr_stat="OD";
                }else if(i_cstat === '3'){
                    curr_stat="Paid From Bank";
                   
                }else if(i_cstat === '1'){
                    
                    curr_stat="Released";
                    
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
                            },
                customize: function(win) {
                    $(win.document.body).append('<h5>-------------------------------------------</h5>'); //after the table
                    $(win.document.body).append('<h5>Total Released RS:'+A+'</h5>'); //after the table
                    $(win.document.body).append('<h5>Total Paid From Bank RS:'+B+'</h5>'); //after the table
                    $(win.document.body).append('<h5>Total OD RS:'+C+'</h5>'); //after the table
                    $(win.document.body).append('<h5>Total Returned RS:'+D+'</h5>'); //after the table
                    $(win.document.body).append('<h5>Total Deleted RS:'+E+'</h5>'); //after the table
                    $(win.document.body).append('<h5>-------------------------------------------</h5>'); //after the table
                    
                }
                        },
                        'colvis'




                    ]

                });
            });




        </script>


    </body>
</html>