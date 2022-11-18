<%@page import="resources.HoldInvoice"%>
<%@page import="dataclass.helper"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="resources.OtherTrans"%>
<%@page import="resources.PurchusInvoice"%>
<%@page import="resources.SaleInvoice"%>
<%@page import="resources.PurchusInvoiceRecipt"%>
<%@page import="resources.InvoiceRecipt"%>
<%@page import="java.util.Set"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="resources.Settings"%>
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
            DecimalFormat df = new DecimalFormat("##########0.00");
        %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link rel="icon" href="https://getbootstrap.com/favicon.ico">
        <title><%= Name%></title>

        <!-- Bootstrap core CSS -->
        <link href="src/boostrap/bootstrap-4.1.3/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
        <!-- Data Tables CDN -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.2/css/buttons.dataTables.min.css">
        <link href="src/css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/css/select2.min.css" rel="stylesheet" /> 
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
            .select2-selection__rendered {
              line-height: 37px !important;
              border-radius: 0px !important;
            }

            .select2-selection {
              height: 37px !important;
              border-radius: 0px !important;
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
            
            Session ses = connection.getConnection.getSessionFactory().openSession();
            Account Account = null;
            int account=0; 
            String Date="";
            String Date2="";
            double tot_credit=0.0;
            double tot_debit=0.0;
            double now_debit=0.0;
            double now_credit=0.0;
            helper help= new helper();
            Date = help.getDate();
            Date2 = help.getDate();
                                    
            if (request.getParameter("q") != null && !request.getParameter("q").equals("") 
                   && request.getParameter("q1") != null && !request.getParameter("q1").equals("")  && request.getParameter("q2") != null && !request.getParameter("q2").equals("") ) {

                if(Integer.parseInt(request.getParameter("q").toString()) > 0){
                 Account = (Account) ses.load(Account.class, Integer.parseInt(request.getParameter("q").toString()));
                 account = Account.getIdaccount();
                }
               
                
                Date=request.getParameter("q1");
                Date2=request.getParameter("q2");
                
            }
            
            

        %>

        <div class="loader"></div>
        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-book"></span>&nbsp;&nbsp;&nbsp;LEDGER ACCOUNT</li>

                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="ledger.jsp" >
                            <div class="row">
                                <div class="col-md-5">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:110px;" id="inputGroup-sizing-default">START DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q1" id="q1" value="<%=Date %>">
                                    </div>


                                </div>
                                <div class="col-md-6">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:110px;" id="inputGroup-sizing-default">END DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q2" id="q2" value="<%=Date2 %>">
                                    </div>


                                </div>
                                <div class="col-md-5">
                                    <div class="input-group mb-4">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:110px !important;" id="inputGroup-sizing-default">ACCOUNT</span>
                                        </div>
                                        <select style="width:318px !important;" class="form-control sp" name="q" id="q" >
                                            <option value="0">PLEASE SELECT ACCOUNT</option>
                                            <%                                           
                                                
                                                Criteria cust = ses.createCriteria(Account.class);
                                                cust.add(Restrictions.eq("status", 1));
                                                
                                                List<Account> customerList = cust.list();
                                                for (Account CL : customerList) {
                                                    if(CL.getBank() == 1 || CL.getCustomer() == 1 || CL.getSupplier() == 1){ 
                                            %>
                                            <option value="<%=CL.getIdaccount()%>"><%=CL.getName()%></option>
                                            
                                            <%
                                                }
                                                }
                                            %>
                                        </select>
                                    </div>


                                </div>
                                <div class="col-md-6">

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
                
                if (account > 0 && Date != "" && Date2 != "") {
            %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body m-2" style="border: #2d3436 solid 1px !important;">
                      
                        <div class="row">
                            <div class="col-md-6">
                                <h6>Name:<span id="F"><%= Account.getName() %></span></h6>    
                                <h6>Address: <%= Account.getAddress() %></h6>    
                                <h6>Contact: <%= Account.getContact() %></h6>    
                                <h6>Email: <%= Account.getEmail() %></h6>    
                                <h6>Remarks: <%= Account.getRemarks() %></h6>    
                                   


                            </div>
                            <div class="col-md-6">
                                 <h6>Start Date: <span id="D" ><%= Date %></span></h6>    
                                 <h6>End Date: <span id="E" ><%= Date2 %></span> </h6>    
                                 <h6 class="d-none">Receivable Amount RS: <span id="H" class="d-none" ><%= Account.getCreditBalance() %></span></h6>    
                                 <h6 class="d-none">Payable Amount RS: <span id="G" class="d-none" ><%= Account.getDebitBalance() %></span></h6>    
                                 <h6 class="d-none">Account Balance RS: <span id="I" class="d-none" ><%= Account.getBalance() %></span></h6>
                                 <%
                                     double AccountBAL=Account.getCreditBalance()-(Account.getDebitBalance()+Account.getBalance());
                                     if(AccountBAL >=0){
                                     %>
                                 <h6 style="color: #ff3f34 !important;">Balance RS: <span id="I" >(RECEIVABLE AMOUNT)<%= AccountBAL %></span></h6>
                                    <%
                                        }else if(AccountBAL <0 ){
                                        %>
                                    <h6 style="color: #ff3f34 !important;">Balance RS: <span id="I"  >(PAYABLE AMOUNT)<%= (AccountBAL*-1) %></span></h6>
                                    <%
                                     }else{
                                     %>
                                    <h6 style="color: #ff3f34 !important;">Balance RS: <span id="I" class="" ><%= AccountBAL %></span></h6>
                                    <%
                                       } 
                                        %>

                            </div>
                        </div>


                    </div>
                </div>
            </div>


            <%
                }
            %>
            <%
                
                if (account > 0 && Date != "" && Date2 != "") {
            %>
            <div class="row mt-2 ">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <table class="table table-bordered table-active table-sm" id="tbl1">
                            <thead>
                                <tr>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">DATE | TIME</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">DETAILS</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">DEBIT</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; ">CREDIT</td>
                                    <td style="background-color: #10ac84 !important; color: white !important; "></td>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    String dateToIncr = Date2; 
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd"); 
                                    Calendar c = Calendar.getInstance(); 
                                    try { c.setTime(sdf.parse(dateToIncr));
                                     } 
                                    catch (ParseException e) 
                                    { // TODO Auto-generated catch block e.printStackTrace();
                                     } 
                                    
                                    String dateToIncr2 = Date; 
                                    SimpleDateFormat sdf2 = new SimpleDateFormat("yyy-MM-dd"); 
                                    Calendar c2 = Calendar.getInstance(); 
                                    try { c2.setTime(sdf2.parse(dateToIncr2));
                                     } 
                                    catch (ParseException e) 
                                    { // TODO Auto-generated catch block e.printStackTrace();
                                     } 
                                    
                                    
                                    if(account > 0  && Date != "" && Date2 != ""){
                                    
                                    Criteria cr=ses.createCriteria(InvoiceRecipt.class);
                                    cr.add(Restrictions.between("date", Date, Date2));
                                    List<InvoiceRecipt> IR=cr.list();
                                    
                                    for (InvoiceRecipt ir : IR) {
                                       
                                    if(ir.getAccountByCustomer().getIdaccount() == Account.getIdaccount()){
                                     System.out.print("A");
                                     
                                     
                                     if(ir.getStatus() == 1){
                                          now_credit=now_credit+ir.getAmount();
                                          System.out.print("A2");
                                %>
                                <tr>
                                    <td><%=ir.getDate() +" "+ir.getTime() %></td>
                                    <% if(ir.getSaleInvoice() != null){ %>
                                    <td>RECEIPT ( ID:<%=ir.getIdinvoiceRecipt() %> ) FOR <%= ir.getRemarks().toUpperCase() %> ( ID:<%=ir.getSaleInvoice().getIdsaleInvoice() %> )</td>
                                    <%}else{ %>
                                    <td><%= ir.getRemarks().toUpperCase() %> (RECEIPT ID:<%=ir.getIdinvoiceRecipt() %> )</td>
                                    <%}%>
                                        <%
                                        if(ir.getPaymentType().getIdpaymentType() == 3){
                                        %>
                                        <td></td>
                                        <td><%=df.format(ir.getAmount() ) %> (CHQ NO:)<%= ir.getCheNumber() %></td>
                                       
                                       
                                        <%
                                        }else{
                                        %>
                                        <td></td>
                                        <td><%=df.format(ir.getAmount() ) %></td>
                                      
                                        
                                        
                                        <%
                                        }
                                        %>
                                   
                                    
                                    <td></td>
                                    
                                </tr>
                                <% }}
                                    }
                                    }
                                   
                                %>
                                <%
                                    if(account > 0 && Date != "" && Date2 != ""){
                                        
                                    Criteria cr=ses.createCriteria(PurchusInvoiceRecipt.class);
                                    cr.add(Restrictions.between("date", Date, Date2));
                                    List<PurchusInvoiceRecipt> IR=cr.list();
                                    
                                    for (PurchusInvoiceRecipt ir : IR) {
                                        
                                        if(ir.getAccountBySupplier().getIdaccount() == Account.getIdaccount() ){
                                         System.out.print("B");
                                        if(ir.getStatus() == 1){
                                             now_debit=now_debit+ir.getAmount();
                                             System.out.print("B2");
                                %>
                                <tr>
                                    <td><%=ir.getDate() +" "+ir.getTime() %></td>
                                    <% if(ir.getPurchusInvoice() != null){ %>
                                    <td>RECEIPT ( ID:<%=ir.getIdinvoiceRecipt() %> ) FOR <%= ir.getRemarks().toUpperCase() %> ( ID:<%=ir.getPurchusInvoice().getIdpurchusInvoice() %> )</td>
                                    <%}else{ %>
                                    <td><%= ir.getRemarks().toUpperCase() %> (RECEIPT ID:<%=ir.getIdinvoiceRecipt() %> )</td>
                                    <%}%>
                                    
                                   <%
                                        if(ir.getPaymentType().getIdpaymentType() == 3){
                                        %>
                                        
                                         <td><%=df.format(ir.getAmount() ) %> (CHQ NO:)<%= ir.getCheNumber() %></td>
                                         <td></td>
                                        <%
                                        }else{
                                        %>
                                       
                                        <td><%=df.format(ir.getAmount() ) %></td>
                                        <td></td>
                                        
                                        <%
                                        }
                                        %>
                                    
                                    <td></td>
                                    
                                </tr>
                                <% }
}
                                    }
                                    }
                                   
                                %>
                                
                                <%
                                    if(account > 0 && Date != "" && Date2 != ""){
                                        
                                    Criteria cr=ses.createCriteria(SaleInvoice.class);
                                    cr.add(Restrictions.between("date", Date, Date2));
                                    
                                    List<SaleInvoice> IR=cr.list();
                                   
                                    for (SaleInvoice ir : IR) {
                                        
                                    if(ir.getAccount().getIdaccount() == Account.getIdaccount()){
                                         if(true){
                                              now_debit=now_debit+ir.getTotal();
                                              System.out.print("C");
                                              
                                %>
                                <tr>
                                    <td><%=ir.getDate() +" "+ir.getTime() %></td>
                                    
                                    <td><%="INVOICE" %> ( ID:<%= ir.getIdsaleInvoice() %> )</td>
                                    
                                   
                                        
                                    <td><%=df.format(ir.getTotal()) %></td>
                                    <td></td>
                                   
                                        
                                        
                                   
                                    <td>
                                        <a type="submit" class="btn btn-success btn-sm" href="invoiceeprint.jsp?pid=<%=ir.getIdsaleInvoice() %>&n=1" >VIEW</a>
                                    </td>
                                    
                                </tr>
                                <%
                                    }
                                }
                                    }
                                    }
                                    
                                %>
                                <%
                                    if(account > 0 && Date != "" && Date2 != ""){
                                        
                                    Criteria cr=ses.createCriteria(HoldInvoice.class);
                                    cr.add(Restrictions.between("date", Date, Date2));
                                    
                                    List<HoldInvoice> IR=cr.list();
                                   
                                    for (HoldInvoice ir : IR) {
                                        
                                    if(ir.getAccount().getIdaccount() == Account.getIdaccount()){
                                         if(true){
                                              now_debit=now_debit+ir.getTotal();
                                              
                                              
                                %>
                                <tr>
                                    <td><%=ir.getDate() +" "+ir.getTime() %></td>
                                    
                                    <td><%="HOLD INVOICE" %> ( ID:<%= ir.getIdholdInvoice()%> )</td>
                                    
                                   
                                        
                                    <td><%=df.format(ir.getTotal()) %></td>
                                    <td></td>
                                   
                                        
                                        
                                   
                                    <td>
                                        <a type="submit" class="btn btn-success btn-sm" href="invoiceeprint.jsp?pid=<%=ir.getIdholdInvoice()%>&n=1" >VIEW</a>
                                    </td>
                                    
                                </tr>
                                <%
                                    }
                                }
                                    }
                                    }
                                    
                                %>
                                <%
                                    if(account > 0 && Date != "" && Date2 != ""){
                                        
                                    
                                    Criteria cr=ses.createCriteria(PurchusInvoice.class);
                                    cr.add(Restrictions.between("date", Date, Date2));
                                    
                                    List<PurchusInvoice> IR=cr.list();

                                    for (PurchusInvoice ir : IR) {
                                    if(ir.getAccount().getIdaccount() == Account.getIdaccount()){
                                     if(true){
                                         now_credit=now_credit+ir.getTotal();
                                          System.out.print("D");
                                         
                                %>
                                <tr>
                                    <td><%=ir.getDate() +" "+ir.getTime() %></td>
                                    
                                    <td><%= "PURCHASE" %> ( ID:<%= ir.getIdpurchusInvoice() %> )</td>
                                    
                                    <td></td>
                                    <td><%=df.format(ir.getTotal()) %></td>    
                                    
                                    
                                        
                                        
                                   
                                    <td>
                                        <a type="submit" class="btn btn-success btn-sm" href="purchaseprint.jsp?pid=<%=ir.getIdpurchusInvoice() %>&n=1" >VIEW</a>
                                    </td>
                                    
                                </tr>
                                <% }
                                    }
}
                                    }
                                   
                                %>
                                
                                <%
                                    if(account > 0 && Date != "" && Date2 != ""){
                                        
                                    
                                    Criteria cr=ses.createCriteria(OtherTrans.class);
                                    cr.add(Restrictions.between("date", Date, Date2));
                                    
                                    List<OtherTrans> IR=cr.list();

                                    for (OtherTrans ir : IR) {
                                        
                                        
                                   if(ir.getAccountBySupplier().getIdaccount() == Account.getIdaccount()){
                                         System.out.print("E");
                                        if(ir.getStatus() == 1){
                                             System.out.print("E2");
                                %>
                                <tr>
                                    <td><%=ir.getDate() +" "+ir.getTime() %></td>
                                    
                                    <td><%= ir.getRemarks().toUpperCase() %>(RECEIPT ID: <%=ir.getIdotherTrans() %> )</td>
                                    
                                   <%
                                        if(ir.getPaymentType().getIdpaymentType() == 3){
                                           if(ir.getCredit()==1){
                                               now_credit=now_credit+ir.getAmount();
                                            %>
                                        
                                         <td></td>
                                         <td><%=df.format(ir.getAmount()) %> (CHQ NO:)<%= ir.getCheNumber() %></td>
                                        <%
                                        }else{
                                            now_debit=now_debit+ir.getAmount();
                                            %>
                                            <td><%=df.format(ir.getAmount()) %> (CHQ NO:)<%= ir.getCheNumber() %></td>
                                            <td></td>
                                        <%
                                        } 


                                        
                                        }else{

                                        if(ir.getCredit()==1){
                                            now_credit=now_credit+ir.getAmount();
                                            %>
                                       
                                            
                                            <td></td>
                                            <td><%=df.format(ir.getAmount()) %></td>
                                        
                                            <%
                                        }else{
                                            now_debit=now_debit+ir.getAmount();
                                            %>
                                       
                                            
                                            
                                            <td><%=df.format(ir.getAmount()) %></td>
                                            <td></td>
                                        
                                            <%
                                        }
                                        
                                        }
                                        %>
                                    
                                    <td></td>
                                    
                                </tr>
                                <% }
}
                                    }
                                    }


                                    Criteria cr=ses.createCriteria(InvoiceRecipt.class);
                                    cr.add(Restrictions.eq("status", 1));
                                    List<InvoiceRecipt> IR=cr.list();
                                    
                                    for (InvoiceRecipt ir : IR) {
                                       
                                        if(ir.getAccountByCustomer().getIdaccount() == Account.getIdaccount()){
                                            tot_credit=tot_credit+ir.getAmount();
                                        }
                                    }

                                    Criteria cr2=ses.createCriteria(PurchusInvoiceRecipt.class);
                                    cr2.add(Restrictions.eq("status", 1));
                                    List<PurchusInvoiceRecipt> IR2=cr2.list();
                                    
                                    for (PurchusInvoiceRecipt ir : IR2) {
                                       
                                        if(ir.getAccountBySupplier().getIdaccount() == Account.getIdaccount()){
                                            tot_debit=tot_debit+ir.getAmount();
                                        }
                                    }
                                    
                                    Criteria cr3=ses.createCriteria(SaleInvoice.class);
                                    //cr3.add(Restrictions.eq("status", 1 ));
                                    List<SaleInvoice> IR3=cr3.list();
                                    
                                    for (SaleInvoice ir : IR3) {
                                       
                                        if(ir.getAccount().getIdaccount() == Account.getIdaccount()){
                                           tot_debit=tot_debit+ir.getTotal();
                                        }
                                    }

                                    Criteria cr4=ses.createCriteria(PurchusInvoice.class);
                                    //cr4.add(Restrictions.eq("status", 1 ));
                                    List<PurchusInvoice> IR4=cr4.list();
                                    
                                    for (PurchusInvoice ir : IR4) {
                                       
                                        if(ir.getAccount().getIdaccount() == Account.getIdaccount()){
                                            tot_credit=tot_credit+ir.getTotal();
                                        }
                                    }

                                    Criteria cr5=ses.createCriteria(OtherTrans.class);
                                    cr5.add(Restrictions.eq("status", 1 ));
                                    List<OtherTrans> IR5=cr5.list();
                                    
                                    for (OtherTrans ir : IR5) {
                                       
                                        if(ir.getAccountBySupplier().getIdaccount() == Account.getIdaccount()){
                                            if(ir.getCredit()==1){
                                               tot_credit=tot_credit+ir.getAmount();
                                            
                                        }else{
                                            tot_debit=tot_debit+ir.getAmount();
                                            
                                        }
                                        }
                                    }
                                    

                                    
                                   double ALDebit= tot_debit;
                                   double ALCredit= tot_credit;
                                   if(Account != null ){
                                         //ALDebit= Account.getCreditBalance();
                                         //ALCredit= Account.getDebitBalance()+Account.getBalance();
                                    }
                                   double BFdebit=0.0;
                                   double BFcredit=0.0;
                                    if(ALDebit >= now_debit ){
                                        BFdebit=ALDebit - now_debit;
                                    }else{
                                        BFdebit=0.0;
                                    }

                                    if(ALCredit >= now_credit ){
                                        BFcredit=ALCredit - now_credit;
                                    }else{
                                        BFcredit=0.0;
                                    }
                                    
                                    double NetDebit=BFdebit+now_debit;
                                    double NetCredit=BFcredit +now_credit;
                                    
                                    double DebitBalance=0.0;
                                    double CreditBalance=0.0;

                                    double VAL=NetDebit-NetCredit;
                                    if(VAL >= 0){
                                        DebitBalance=VAL;
                                        

                                    }else{
                                        CreditBalance=(VAL*-1);                
                                    }
                                    
                                   
                                %>
                                <tr>
                                    <td></td>
                                    <td class="font-weight-bold">NOW TOTAL</td>
                                    <td></td>
                                    <td class="font-weight-bold">RS <%= df.format(now_debit) %></td>
                                    <td class="font-weight-bold">RS <%= df.format(now_credit) %></td>
                                    
                                </tr>
                                <tr>
                                    <td></td>
                                    <td class="font-weight-bold">BF BALANCE</td>
                                    <td></td>
                                    <td class="font-weight-bold">RS <%= df.format(BFdebit) %></td>
                                    <td class="font-weight-bold">RS <%= df.format(BFcredit) %></td>
                                  
                                </tr>
                                <tr>
                                    <td></td>
                                    <td class="font-weight-bold">NET TOTAL</td>
                                    <td></td>
                                    <td class="font-weight-bold">RS <%= df.format(NetDebit) %></td>
                                    <td class="font-weight-bold">RS <%= df.format(NetCredit) %></td>
                                   
                                </tr>
                                <tr class="">
                                    <td></td>
                                    <td class="font-weight-bold"  style="color: red !important;">BALANCE</td>
                                    <td></td>
                                    <td class="font-weight-bold" style="color: red !important;">RS <%= df.format(DebitBalance)  %></td>
                                    <td class="font-weight-bold" style="color: red !important;">RS <%= df.format(CreditBalance)  %></td>
                                    
                                </tr> 
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <% }  %>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>

        <script type="text/javascript">
            $(window).load(function(){
                $('.loader').fadeOut();
            });
            $(document).ready(function() {
                $('.sp').select2();
            });
            $('#q').val(<%=account %>);
            var sDate=$('#D').html();
            var eDate=$('#E').html();
            var eAccount=$('#F').html();
            var c=$('#G').html();
            var d=$('#H').html();
            var b=$('#I').html();
            
            $(document).ready(function () {
                $('#tbl1').DataTable( {
                    "order": [[ 0, "desc" ]]
                });
            });





        </script>


    </body>
</html>