<%@page import="dataclass.userHolder"%>
<%@page import="resources.StockTransfer"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.ItemThird"%>
<%@page import="resources.ItemSub"%>
<%@page import="java.util.ArrayList"%>
<%@page import="resources.ThirdCategory"%>
<%@page import="resources.SubCategory"%>
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
            userHolder USER = null;
    if (request.getSession().getAttribute("administrator") == null) {
        response.sendRedirect("login.jsp");
    } else {
        USER = (userHolder) request.getSession().getAttribute("userHolder");
    }
    
    if(USER != null){
        try{
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
        <%
            DecimalFormat df = new DecimalFormat("##########0.00");
            Session ses = connection.getConnection.getSessionFactory().openSession();
            String CategoryN = "ALL";
            String AccountN = "ALL";
            String BranchN = "ALL";
            String SubN = "ALL";
            String OtherN = "ALL";

            int category = 0;
            int account = 0;
            int branch = 0;
            int sub = 0;
            int other = 0;
            int showEmpty = 3;

            double total_amount = 0.0;
            double t_amount = 0.0;

            if (request.getParameter("b") != null && !request.getParameter("b").equals("")
                    && request.getParameter("a") != null && !request.getParameter("a").equals("")
                    && request.getParameter("c") != null && !request.getParameter("c").equals("")
                    && request.getParameter("s") != null && !request.getParameter("s").equals("")
                    && request.getParameter("o") != null && !request.getParameter("o").equals("")) {

                category = Integer.parseInt(request.getParameter("b"));
                account = Integer.parseInt(request.getParameter("a"));
                branch = Integer.parseInt(request.getParameter("c"));
                sub = Integer.parseInt(request.getParameter("s"));
                other = Integer.parseInt(request.getParameter("o"));

                if (!request.getParameter("b").equals("0")) {
                    Category B = (Category) ses.load(Category.class, category);
                    CategoryN = B.getName();
                }
                if (!request.getParameter("a").equals("0")) {
                    Account A = (Account) ses.load(Account.class, account);
                    AccountN = A.getName();
                }
                if (!request.getParameter("c").equals("0")) {
                    Branch A = (Branch) ses.load(Branch.class, branch);
                    BranchN = A.getName();
                }
                if (!request.getParameter("s").equals("0")) {
                    SubCategory A = (SubCategory) ses.load(SubCategory.class, sub);
                    SubN = A.getName();
                }
                if (!request.getParameter("o").equals("0")) {
                    ThirdCategory A = (ThirdCategory) ses.load(ThirdCategory.class, other);
                    OtherN = A.getName();
                }
                if (!request.getParameter("emp").equals("0")) {
                    showEmpty = Integer.parseInt(request.getParameter("emp"));
                }

            }

        %>


        <main role="main" class="container">

            <div class="row mt-5">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-home"></span>&nbsp;<a href="index.jsp">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page" style="font-size: 16px;">Stock details</li>
                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="stock.jsp" >
                            <div class="row">

                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:110px;" id="inputGroup-sizing-default">CATEGORY</span>
                                        </div>
                                        <select class="form-control" name="b" id="b"  >
                                            <option value="0">ALL</option>
                                            <%                                                
                                                Criteria crb = ses.createCriteria(Category.class);
                                                crb.add(Restrictions.eq("status", 1));
                                                List<Category> br = crb.list();
                                                for (Category BR : br) {

                                            %>
                                            <option value="<%= BR.getIdcategory()%>"><%= BR.getName()%></option>
                                            <%
                                                }

                                            %>

                                        </select>
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-4">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:160px;" id="inputGroup-sizing-default">SUB CATEGORY</span>
                                        </div>
                                        <select class="form-control" name="s" id="s"  >
                                            <option value="0">ALL</option>
                                            <%                                                
                                                Criteria crc = ses.createCriteria(SubCategory.class);
                                                crc.add(Restrictions.eq("status", 1));
                                                List<SubCategory> brc = crc.list();
                                                for (SubCategory BR : brc) {

                                            %>
                                            <option value="<%= BR.getSubcategoryId()%>"><%= BR.getName()%></option>
                                            <%
                                                }

                                            %>

                                        </select>
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-4">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:170px;" id="inputGroup-sizing-default">OTHER CATEGORY</span>
                                        </div>
                                        <select class="form-control" name="o" id="o"  >
                                            <option value="0">ALL</option>
                                            <%                                                
                                                Criteria crd = ses.createCriteria(ThirdCategory.class);
                                                crd.add(Restrictions.eq("status", 1));
                                                List<ThirdCategory> brd = crd.list();
                                                for (ThirdCategory BR : brd) {

                                            %>
                                            <option value="<%= BR.getThirdcategoryId()%>"><%= BR.getName()%></option>
                                            <%
                                                }

                                            %>

                                        </select>
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:110px;" id="inputGroup-sizing-default">BRANCH</span>
                                        </div>
                                        <select class="form-control" name="c" id="c"  >
                                            <option value="0">ALL</option>
                                            <%                                                
                                                Criteria crb2 = ses.createCriteria(Branch.class);
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


                                </div>
                                <div class="col-md-8">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text " style="width:110px;" id="inputGroup-sizing-default">SUPPLIER</span>
                                        </div>
                                        <select class="form-control s2" name="a" id="a"  >
                                            <option value="0">ALL</option>
                                            <%                                                
                                                Criteria cra = ses.createCriteria(Account.class);
                                                cra.add(Restrictions.eq("status", 1));
                                                cra.add(Restrictions.eq("supplier", 1));
                                                List<Account> bra = cra.list();
                                                for (Account BR : bra) {

                                            %>
                                            <option value="<%= BR.getIdaccount()%>"><%= BR.getName()%></option>
                                            <%
                                                }

                                            %>

                                        </select>
                                    </div>


                                </div>
                                <div class="col-md-4">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:110px;" id="inputGroup-sizing-default">STATUS</span>
                                        </div>
                                        <select class="form-control" name="emp" id="emp"  >
                                            <option value="1">Available Only</option>
                                            <option value="2">Empty Only</option>
                                            <option value="3">ALL</option>


                                        </select>
                                    </div>


                                </div>            
                                <div class="col-md-4">

                                    <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                        <button type="submit" class="btn btn-success " id="save"><span class="fa fa-search mr-2"></span>FIND</button>

                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <%                if (account >= 0 && category >= 0 && branch >= 0) {
            %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-12">
                                <table class="col-md-6 table table-sm table-bordered" >
                                    <tr>
                                        <td style="border: #2d3436 solid 1px !important;">CATEGORY</td>
                                        <td style="border: #2d3436 solid 1px !important;"><%=CategoryN%></td>
                                        <td style="border: #2d3436 solid 1px !important;">SUB CATEGORY</td>
                                        <td style="border: #2d3436 solid 1px !important;"><%=SubN%></td>
                                    </tr>

                                    <tr>
                                        <td style="border: #2d3436 solid 1px !important;">OTHER CATEGORY</td>
                                        <td style="border: #2d3436 solid 1px !important;"><%=OtherN%></td>
                                        <td style="border: #2d3436 solid 1px !important;">BRANCH</td>
                                        <td style="border: #2d3436 solid 1px !important;"><%=BranchN%></td>
                                    </tr>
                                    <% if(USER.getAdministrator().contains("F")){ %>
                                    <tr>
                                        <td style="border: #2d3436 solid 1px !important;">SUPPLIER</td>
                                        <td style="border: #2d3436 solid 1px !important;"><%=AccountN%></td>
                                        <td style="border: #2d3436 solid 1px !important; background-color:#ff9f43 !important; color: white !important; ">TOTAL COST</td>
                                        <td style="border: #2d3436 solid 1px !important; background-color:#ff9f43 !important; color: white !important;"> <span id="k"></span></td>
                                    </tr>
                                    <tr>
                                        <td style="border: white solid 1px !important;"></td>
                                        <td style="border: white solid 1px !important;"></td>
                                        <td style="border: #2d3436 solid 1px !important; background-color:#b33939 !important; color: white !important;"><strong>EMPTY</strong> </td>
                                        <td style="border: #2d3436 solid 1px !important; background-color:#227093 !important; color: white !important;"><strong>AVAILABLE</strong></td>
                                    </tr>
                                    <% }%>
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
                                    <th style="background-color: #10ac84 !important; color: white !important; ">ITEM ID</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">NAME</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">TOTAL QTY</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">COST</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">HOLD</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">PENDING TRANSFER</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">RECEIVABLE PO</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; ">AVAILABLE</th>
                                    <th style="background-color: #10ac84 !important; color: white !important; "></th>


                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Criteria cr = ses.createCriteria(Items.class);
                                    cr.add(Restrictions.eq("status", 1));
                                    if (account > 0) {
                                        cr.createAlias("account", "A");
                                        cr.add(Restrictions.eq("A.idaccount", account));
                                    }
                                    if (category > 0) {
                                        cr.createAlias("category", "C");
                                        cr.add(Restrictions.eq("C.idcategory", category));
                                    }
                                    
                                    List<Items> IT=cr.list();
                                    List<Items> de = new ArrayList();
                                    
                                    for(Items it:IT){
                                        if(sub == 0 && other == 0){
                                            de.add(it);
                                        }else if(sub > 0 && other == 0){
                                            int i =0;
                                            Set<ItemSub> SL=it.getItemSubs();
                                            for(ItemSub SS :SL){
                                                if(SS.getSubCategory().getSubcategoryId() == sub ){
                                                    i=1;
                                                }
                                            }
                                            if(i == 1){
                                                 de.add(it);
                                            }
                                        }else if(sub == 0 && other > 0){
                                            int i =0;
                                            Set<ItemThird> ST=it.getItemThirds();
                                            for(ItemThird STT :ST){
                                                if(STT.getThirdCategory().getThirdcategoryId()== other ){
                                                    i=1;
                                                }
                                            }
                                            if(i == 1){
                                                 de.add(it);
                                            }
                                        }else if(sub > 0 && other > 0){
                                            int i =0;
                                            Set<ItemSub> SL=it.getItemSubs();
                                            for(ItemSub SS :SL){
                                                if(SS.getSubCategory().getSubcategoryId() == sub ){
                                                    i=1;
                                                }
                                            }
                                            
                                            int j =0;
                                            Set<ItemThird> ST=it.getItemThirds();
                                            for(ItemThird STT :ST){
                                                if(STT.getThirdCategory().getThirdcategoryId()== other ){
                                                    j=1;
                                                }
                                            }
                                            if(j == 1 && i == 1 ){
                                                 de.add(it);
                                            }
                                        }
                                        
                                    }
                                    if (de.size() > 0) {
                                        for (Items DE : de) {

                                            double total_qty = 0.0;
                                            double received = 0.0;
                                            double received_cost = 0.0;
                                            double st_received = 0.0;
                                            double available = 0.0;
                                            double receivable_po = 0.0;
                                            t_amount = 0.0;

                                            if (branch > 0) {
                                                Set<Stock> ST = DE.getStocks();
                                                if (!ST.isEmpty()) {
                                                    for (Stock S : ST) {
                                                        if (branch == S.getBranch().getIdbranch()) {
                                                            total_qty = total_qty + S.getQty();
                                                            t_amount= t_amount + (S.getQty() * S.getCost()) ;
                                                            
                                                        }

                                                    }
                                                }

                                                Set<StockTransfer> STI = DE.getStockTransfers();
                                                if (!STI.isEmpty()) {
                                                    for (StockTransfer H : STI) {
                                                        if (branch == H.getBranchByToBranch().getIdbranch() ) {
                                                            if (H.getStatus() == 1) {
                                                                st_received = st_received +( H.getRequestQty() - H.getSendQty());
                                                            }
                                                        }

                                                    }
                                                }
                                                Set<HoldInvoiceItem> HI = DE.getHoldInvoiceItems();
                                                if (!HI.isEmpty()) {
                                                    for (HoldInvoiceItem H : HI) {
                                                        if (branch == H.getHoldInvoice().getBranch().getIdbranch()) {
                                                            if (0 < (H.getQtt() - H.getQtySended())) {
                                                                received = received + (H.getQtt() - H.getQtySended());
                                                                received_cost = received_cost + (H.getStock().getCost() *(H.getQtt() - H.getQtySended())); 
                                                            }
                                                        }

                                                    }
                                                }
                                                Set<PoOrderItems> PO = DE.getPoOrderItemses();
                                                if (!PO.isEmpty()) {
                                                    for (PoOrderItems P : PO) {
                                                        if (branch == P.getPurchaseInvoiceOrder().getBranch().getIdbranch()) {
                                                            if (0 < (P.getQty() - P.getQtyRecived())) {
                                                                receivable_po = receivable_po + (P.getQty() - P.getQtyRecived());
                                                            }
                                                        }

                                                    }
                                                }
                                            }else {

                                                Set<Stock> ST = DE.getStocks();
                                                if (!ST.isEmpty()) {
                                                    for (Stock S : ST) {
                                                        total_qty = total_qty + S.getQty();
                                                        t_amount= t_amount + (S.getQty() * S.getCost()) ;
                                                    }
                                                }
                                                Set<HoldInvoiceItem> HI = DE.getHoldInvoiceItems();
                                                if (!HI.isEmpty()) {
                                                    for (HoldInvoiceItem H : HI) {

                                                        if (0 < (H.getQtt() - H.getQtySended())) {
                                                            received = received + (H.getQtt() - H.getQtySended());
                                                            received_cost = received_cost + (H.getStock().getCost() *(H.getQtt() - H.getQtySended())); 
                                                        }

                                                    }
                                                }
                                                
                                                Set<PoOrderItems> PO = DE.getPoOrderItemses();
                                                if (!PO.isEmpty()) {
                                                    for (PoOrderItems P : PO) {
                                                        
                                                            if (0 < (P.getQty() - P.getQtyRecived())) {
                                                                receivable_po = receivable_po + (P.getQty() - P.getQtyRecived());
                                                            }
                                                        

                                                    }
                                                }

                                            }
                                            available = total_qty - received;
                                            total_amount = total_amount + t_amount;
                                            total_amount = Math.round(total_amount * 100.0) / 100.0 ;  
                                            

                                if(showEmpty > 0 ){
                                                if(showEmpty == 1){
                                                    if(total_qty > 0 ){
                                %>
                                <tr>
                                    <td><%=DE.getItemId() %></td>
                                    <td><%=DE.getName().toUpperCase() %></td>
                                    <td><%=df.format((double) Math.round(total_qty * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td><%= "Rs."+df.format( Math.round(t_amount * 100.0) / 100.0)  %></td>
                                    <td><%=df.format((double) Math.round(received * 100) / 100 )+" "+ DE.getType().getName()+ "   Rs."+df.format(received_cost)+" " %></td>
                                    <td><%=df.format((double) Math.round(st_received * 100) / 100 ) + "  " + DE.getType().getName()%></td>
                                    <td><%=df.format((double) Math.round(receivable_po * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td><%=df.format((double) Math.round((available) * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td>
                                        <a style="width: 100px !important;" type="submit" class="btn btn-success btn-sm" href="stocks.jsp?a=<%=DE.getItemId()%>&b=0" >VIEW</a>
                                        <a style="width: 100px !important;" type="submit" class="btn btn-warning btn-sm" href="stockhistory.jsp?a=<%=DE.getItemId()%>&b=0" >HISTORY</a>

                                    </td>

                                </tr>
                                <%
                                                    }
                                                }else if(showEmpty == 2){
                                                    if(total_qty == 0){
                                                        %>
                                                        
                                                        
                                 <tr>
                                    <td><%=DE.getItemId() %></td>
                                    <td><%=DE.getName().toUpperCase() %></td>
                                    <td><%=df.format((double) Math.round(total_qty * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td><%= "Rs."+df.format( Math.round(t_amount * 100.0) / 100.0)  %></td>
                                    <td><%=df.format((double) Math.round(received * 100) / 100 )+" "+ DE.getType().getName()+ "   Rs."+df.format(received_cost)+" " %></td>
                                    <td><%=df.format((double) Math.round(st_received * 100) / 100 ) + "  " + DE.getType().getName()%></td>
                                    <td><%=df.format((double) Math.round(receivable_po * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td><%=df.format((double) Math.round((available) * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td>
                                        <a style="width: 100px !important;" type="submit" class="btn btn-success btn-sm" href="stocks.jsp?a=<%=DE.getItemId()%>&b=0" >VIEW</a>
                                        <a style="width: 100px !important;" type="submit" class="btn btn-warning btn-sm" href="stockhistory.jsp?a=<%=DE.getItemId()%>&b=0" >HISTORY</a>

                                    </td>

                                </tr>
                                <%
                                                    }
                                                }else if(showEmpty == 3){
                                                    %>
                                
                                <%if(total_qty > 0){ %>
                                <tr style="background-color: #227093 !important; color: white !important; ">
                                <%} else if(total_qty == 0){ %>
                                <tr style="background-color: #b33939 !important; color: white !important; ">
                                <% } %>
                                    <td><%=DE.getItemId() %></td>
                                    <td><%=DE.getName().toUpperCase() %></td>
                                    <td><%=df.format((double) Math.round(total_qty * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td><%= "Rs."+df.format( Math.round(t_amount * 100.0) / 100.0)  %></td>
                                    <td><%=df.format((double) Math.round(received * 100) / 100 )+" "+ DE.getType().getName()+ "   Rs."+df.format(received_cost)+" " %></td>
                                    <td><%=df.format((double) Math.round(st_received * 100) / 100 ) + "  " + DE.getType().getName()%></td>
                                    <td><%=df.format((double) Math.round(receivable_po * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td><%=df.format((double) Math.round((available) * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td>
                                        <a style="width: 100px !important;" type="submit" class="btn btn-success btn-sm" href="stocks.jsp?a=<%=DE.getItemId()%>&b=0" >VIEW</a>
                                        <a style="width: 100px !important;" type="submit" class="btn btn-warning btn-sm" href="stockhistory.jsp?a=<%=DE.getItemId()%>&b=0" >HISTORY</a>

                                    </td>

                                </tr>
                                <%
                                                }
                                            }else{
                                        %>
                                    <%if(total_qty > 0){ %>
                                <tr style="background-color: #227093 !important; color: white !important; ">
                                <%} else if(total_qty == 0){ %>
                                <tr style="background-color: #b33939 !important; color: white !important; ">
                                <% } %>
                                    <td><%=DE.getItemId() %></td>
                                    <td><%=DE.getName().toUpperCase() %></td>
                                    <td><%=df.format((double) Math.round(total_qty * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td><%= "Rs."+df.format( Math.round(t_amount * 100.0) / 100.0)  %></td>
                                    <td><%=df.format((double) Math.round(received * 100) / 100 )+" "+ DE.getType().getName()+ "   Rs."+df.format(received_cost)+" " %></td>
                                    <td><%=df.format((double) Math.round(st_received * 100) / 100 ) + "  " + DE.getType().getName()%></td>
                                    <td><%=df.format((double) Math.round(receivable_po * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td><%=df.format((double) Math.round((available) * 100) / 100) + "  " + DE.getType().getName()%></td>
                                    <td>
                                        <a style="width: 100px !important;" type="submit" class="btn btn-success btn-sm" href="stocks.jsp?a=<%=DE.getItemId()%>&b=0" >VIEW</a>
                                        <a style="width: 100px !important;" type="submit" class="btn btn-warning btn-sm" href="stockhistory.jsp?a=<%=DE.getItemId()%>&b=0" >HISTORY</a>

                                    </td>

                                </tr>
                                <% }
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>

        <script>
            $(window).load(function () {
                $('.loader').fadeOut();
            });
            $(document).ready(function () {
                $('.s2').select2();
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

            $('#c').val(<%=branch%>);
            $('#b').val(<%=category%>);
            $('#a').val(<%=account%>);
            $('#s').val(<%=sub%>);
            $('#o').val(<%=other%>);
            $('#k').html('Rs.' +<%=df.format(total_amount) %>);
            $('#emp').val(<%=showEmpty %>);
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
            
            $("#b").change(function () {
               var cat=$('#b').find(":selected").val();
               var dataString = 'p2=' + cat;
               
                
                    $.ajax({
                        url: 'getSubCatListServlet',
                        dataType: "json",
                        data: dataString,
                        cache: false,
                        success: function (player) {
                            let dropdown = $('#s');
                            dropdown.empty();
                            if (player.length === 0) {
                                
                                $("#s").append("<option value='0'>ALL</option>");
                            } else {
                                $("#s").append("<option value='0'>ALL</option>");
                                $.each(player, function (key, value) {
                                $("#s").append("<option value=" + value.id + " >" + value.name + "</option>");
                                });
                        }
                                $("#s").selectpicker("refresh");
                                var a = new Array();
                                $("#s").children("option").each(function(x){
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
                                $("#s").selectpicker("refresh");
                        }
                    });

            });
            $("#s").change(function () {
               var cat=$('#s').find(":selected").val();
               var dataString = 'p2=' + cat;
               
                
                    $.ajax({
                        url: 'getOthreCatListServlet',
                        dataType: "json",
                        data: dataString,
                        cache: false,
                        success: function (player) {
                            let dropdown = $('#o');
                            dropdown.empty();
                            if (player.length === 0) {
                                
                                $("#o").append("<option  value='0'>ALL</option>");
                            } else {
                                $("#o").append("<option  value='0'>ALL</option>");
                                $.each(player, function (key, value) {
                                $("#o").append("<option value=" + value.id + " >" + value.name + "</option>");
                                });
                            }
                                $("#o").selectpicker("refresh");
                                var a = new Array();
                                $("#o").children("option").each(function(x){
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
                                $("#o").selectpicker("refresh");
                        }
                    });

            });




        </script>


    </body>
    <%  }catch(Exception e){
            
        }} %>
</html>