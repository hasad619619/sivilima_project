<%@page import="dataclass.userHolder"%>
<%@page import="resources.User"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="resources.Settings"%>
<%@page import="org.hibernate.Session"%>
<%
    try{
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
    userHolder USER = null;
    if (request.getSession().getAttribute("administrator") == null) {
        response.sendRedirect("login.jsp");
    } else {
        USER = (userHolder) request.getSession().getAttribute("userHolder");
    }
    
    if(USER != null){
%>
<header>
    <style>
        .dropdown-item:hover, .dropdown-item:focus {
  color: #fff !important;
  text-decoration: none;
  background-color: #27ae60 !important;
}
    </style>
    <!-- Fixed navbar  #7f8c8d bg-dark navbar-expand-md navbar-dark-->
    <nav class="navbar  navbar-expand-sm  fixed-top " style="background-color: #636e72  !important; height: 60px !important;"> 
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item dropdown  ml-2" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);background: #ecf0f1;">
                    <a class="nav-link "  href="index.jsp" role="button" aria-haspopup="true" aria-expanded="false" style="color: #2c3e50;">
                        <img  src="src/image/home.png">
                        Home
                    </a>

                </li>

                <li class="nav-item dropdown ml-2" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);background: #ecf0f1;">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: #2c3e50;">
                        <img  src="src/image/file.png">
                        Create
                    </a>
                    <div class="dropdown-menu" style="background-color: #ecf0f1;">
                        <%if(USER.getAccount().contains("A") || USER.getAccount().contains("B") || USER.getAccount().contains("C") || USER.getAccount().contains("D")){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="account.jsp"><span class="fa fa-user mr-2"></span>Create accounts</a>
                        <% } %>
                        <%if(USER.getAccount().contains("E") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="expenceaccount.jsp"><span class="fa fa-angle-double-up mr-2"></span>Create Expenses account</a>
                        <% } %>
                        <%if(USER.getAccount().contains("F") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="employeeaccount.jsp"><span class="fa fa-angle-double-up mr-2"></span>Create Employee account</a>
                        <% } %>
                        <div class="dropdown-divider"></div>
                        <%if(USER.getCreate().contains("A") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="inventory.jsp"><span class="fa fa-cart-plus mr-2"></span>Create new item</a>
                        <% } %>
                        <%if(USER.getCreate().contains("B") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="category.jsp"><span class="fa fa-bars mr-2"></span>Item category</a>
                        <% } %>
                        <%if(USER.getCreate().contains("C") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="subcategory.jsp"><span class="fa fa-bars mr-2"></span>Item sub category</a>
                        <% } %>
                        <%if(USER.getCreate().contains("D") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="thirdcategory.jsp"><span class="fa fa-bars mr-2"></span>Item other category</a>
                        <% } %>
                        <%if(USER.getCreate().contains("E") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="brand.jsp"><span class="fa fa-bars mr-2"></span>Item Brand</a>
                        <% } %>
                        <%if(USER.getAdministrator().contains("A") || USER.getAdministrator().contains("B") || USER.getAdministrator().contains("C") || USER.getAdministrator().contains("D") || USER.getAdministrator().contains("E")){ %>
                        <div style="color: #2c3e50;" class="dropdown-divider"></div>
                        <a style="color: #2c3e50;" class="dropdown-item" href="settings.jsp"><span class="fa fa-cogs mr-2"></span>System setup</a>
                        <% } %>
                        <div class="dropdown-divider"></div>
                        <a style="color: #2c3e50;" class="dropdown-item" href="logOutServlet"><span class="fa fa-sign-out-alt mr-2"></span>Logout</a>
                    </div>
                </li>
                <li class="nav-item dropdown ml-2" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);background: #ecf0f1;">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: #2c3e50;">
                        <img  src="src/image/stock.png">
                        Invoicing
                    </a>
                    <div class="dropdown-menu" style="background-color: #ecf0f1;">
                        <%if(USER.getInvoicing().contains("A") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="itemlist.jsp"><span class="fa fa-shopping-bag mr-2"></span>Item list</a>
                        <div class="dropdown-divider"></div>
                        <% } %>
                        <%if(USER.getInvoicing().contains("B") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="quatation.jsp"><span class="fa fa-sticky-note mr-2"></span>Quotation</a>
                        <% } %>
                        <%if(USER.getInvoicing().contains("C") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="quotationlist.jsp"><span class="fa fa-edit mr-2"></span>Quotation list</a>
                        <% } %>
                        <div class="dropdown-divider"></div>
                        <%if(USER.getInvoicing().contains("D") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="damagestock.jsp"><span class="fa fa-industry mr-2"></span>Add Damage Stocks</a>
                        <% } %>
                        <%if(USER.getStocks().contains("F") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="stock.jsp"><span class="fa fa-database mr-2"></span>Stocks</a>
                        <div class="dropdown-divider"></div>
                        <% } %>
                        <%if(USER.getInvoicing().contains("E") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="puchaseorder.jsp"><span class="fa fa-phone mr-2"></span>Purchase Order</a>
                        <% } %>
                        <%if(USER.getInvoicing().contains("F") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="posearch.jsp"><span class="fa fa-book mr-2"></span>Purchase Order List</a>
                        <% } %>
                        <%if(USER.getInvoicing().contains("H") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="purchase.jsp"><span class="fa fa-truck mr-2"></span>Purchase</a>
                        <% } %>
                        <%if(USER.getInvoicing().contains("I") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="stockreturn.jsp"><span class="fa fa-arrow-right mr-2"></span>Goods Return To Suppler</a>
                        <% } %>
                        <%if(USER.getInvoicing().contains("J") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="listreturn.jsp"><span class="fa fa-list-alt mr-2"></span>List - Goods Return</a>
                        <% } %>
                        <div class="dropdown-divider"></div>
                        <%if(USER.getInvoicing().contains("K") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="sales.jsp"><span class="fa fa-plus  mr-2"></span>Invoice</a>
                        <a style="color: #2c3e50;" class="dropdown-item" href="hold.jsp"><span class="fa fa-retweet  mr-2"></span>Hold Invoice</a>
                        <% } %>
                        <%if(USER.getInvoicing().contains("L") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="returninvoice.jsp"><span class="fa fa-share mr-2"></span>Return Invoice</a>
                        <% } %>
                        <%if(USER.getInvoicing().contains("N") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="deliveryreturn.jsp"><span class="fa fa-train mr-2"></span>Delivery Return</a>
                        <% } %>
                        <%if(USER.getInvoicing().contains("M") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="do.jsp"><span class="fa fa-plane mr-2"></span>Delivery</a>
                        <% } %>
                        <div class="dropdown-divider"></div>   
                        <%if(USER.getStocks().contains("A") || USER.getStocks().contains("B") || USER.getStocks().contains("C") || USER.getStocks().contains("D") || USER.getStocks().contains("E")  ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="stocktransfer.jsp"><span class="fa fa-gift mr-2"></span>Stock Transfer</a>
                        <% } %>

                    </div>
                </li>

                <li class="nav-item dropdown ml-2" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);background: #ecf0f1;">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: #2c3e50;">
                        <img  src="src/image/account.png">
                        Accounting</a>
                    <div class="dropdown-menu" style="background-color: #ecf0f1;">
                        <%if(USER.getAccounting().contains("A") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="accountcashcredit.jsp"><span class="fa fa-credit-card  mr-2"></span>Account Cash / Credit</a>
                        <div class="dropdown-divider"></div>
                        <% } %>
                        <%if(USER.getAccounting().contains("B") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="salesrecipt.jsp"><span class="fa fa-arrow-left mr-2"></span>Receive Payment</a>
                        <% } %>
                        <%if(USER.getAccounting().contains("C") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="purchaserecipts.jsp"><span class="fa fa-arrow-right mr-2"></span>Release Payment</a>
                        <% } %>
                        <%if(USER.getAccounting().contains("D") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="payexpenses.jsp"><span class="fa fa-arrow-down mr-2"></span>Add Expenses</a>
                        <% } %>
                        <%if(USER.getAccounting().contains("E") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="payemployee.jsp"><span class="fa fa-arrow-down mr-2"></span>Release Employee Payment</a>
                        <% } %>
                        <%if(USER.getAccounting().contains("F") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="salerecieptlist.jsp"><span class="fa fa-arrow-circle-left mr-2"></span>List - Receive Payment</a>
                        <% } %>
                        <%if(USER.getAccounting().contains("G") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="purchaserecieptslist.jsp"><span class="fa fa-arrow-circle-right mr-2"></span>List - Release Payment</a>
                        <% } %>
                        <%if(USER.getAccounting().contains("H") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="cashbook.jsp"><span class="fa fa-balance-scale mr-2"></span>Daily Cash Balance</a>
                        <% } %>
                        <%if(USER.getAccounting().contains("I") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="profit.jsp"><span class="fa fa-gift mr-2"></span>Profit</a>
                        <% } %>
                        <div class="dropdown-divider"></div>
                        <%if(USER.getAccounting().contains("J") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="ledger.jsp"><span class="fa fa-book mr-2"></span>Ledger Account</a>
                        <% } %>
                        <%if(USER.getAccounting().contains("K") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="trialbalance.jsp"><span class="fa fa-bookmark mr-2"></span>Trial Balance</a>
                        <% } %>
                        <%if(USER.getAccounting().contains("L") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="virtualchequebalance.jsp"><span class="fa fa-list-alt mr-2"></span>Virtual Bank Balance-(Cheque)</a>
                        <% } %>    
                    </div>
                </li>
                <li class="nav-item dropdown ml-2" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);background: #ecf0f1;">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: #2c3e50;">
                        <img  src="src/image/check.png">
                        Cheque</a>
                    <div class="dropdown-menu" style="background-color: #ecf0f1;">
                        <%if(USER.getCheque().contains("A") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="recievedcheques.jsp"><span class="fa fa-arrow-circle-right mr-2"></span>Received Cheque Processing</a>
                        <% } %>
                        <%if(USER.getCheque().contains("B") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="receivedchequereports.jsp"><span class="fa fa-list mr-2"></span>Received Cheque List</a>
                        <div class="dropdown-divider"></div>
                        <% } %>
                        <%if(USER.getCheque().contains("C") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="issuedcheques.jsp"><span class="fa fa-arrow-circle-left mr-2"></span>Issued Cheque Processing</a>
                        <% } %>
                        <%if(USER.getCheque().contains("D") ){ %>
                        <a style="color: #2c3e50;" class="dropdown-item" href="issuedchequereports.jsp"><span class="fa fa-list mr-2"></span>Issued Cheque List</a>
                       <div class="dropdown-divider"></div>
                       <% } %>
                       <%if(USER.getCheque().contains("E") ){ %>
                       <a style="color: #2c3e50;" class="dropdown-item" href="chequebook.jsp"><span class="fa fa-list-alt mr-2"></span>Cheque Book</a>
                       <% } %>
                    </div>
                </li>
                <li class="nav-item dropdown ml-2" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);background: #ecf0f1; ">
                    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="color: #2c3e50;">
                        <img  src="src/image/report.png">
                        Reports 
                    </a>
                    <div class="dropdown-menu" style="height: auto;max-height: 400px;overflow-x: hidden; background-color: #ecf0f1;">
                        <a style="color: #2c3e50;" class="dropdown-item" href="stock.jsp"><span class="fa fa-hourglass mr-2"></span>Stock Details</a>
                        <div class="dropdown-divider"></div>
                        <a style="color: #2c3e50;" class="dropdown-item" href="salesanalyse.jsp"><span class="fa fa-anchor mr-2"></span>Invoice Details</a>
                        <a style="color: #2c3e50;" class="dropdown-item" href="salesanalysebi.jsp"><span class="fa fa-anchor mr-2"></span>Invoice Details (Branch & Item)</a>
                        <a style="color: #2c3e50;" class="dropdown-item" href="salesanalysebyc.jsp"><span class="fa fa-anchor mr-2"></span>Invoice Details (Customer)</a>
                        <div class="dropdown-divider"></div>
                        <a style="color: #2c3e50;" class="dropdown-item" href="holdinvoicedate.jsp"><span class="fa fa-anchor mr-2"></span>Hold Invoice Details</a>
                        <a style="color: #2c3e50;" class="dropdown-item" href="salesanalysebi.jsp"><span class="fa fa-anchor mr-2"></span>Hold Invoice Details (Branch & Item)</a>
                        <a style="color: #2c3e50;" class="dropdown-item" href="salesanalysebyc.jsp"><span class="fa fa-anchor mr-2"></span>Hold Invoice Details (Customer)</a>
                        <div class="dropdown-divider"></div>
                        <a style="color: #2c3e50;" class="dropdown-item " href="posearch.jsp"><span class="fa fa-anchor mr-2"></span>Purchase Order Details</a>
                        <a style="color: #2c3e50;" class="dropdown-item" href="invoicereturnbi.jsp"><span class="fa fa-anchor mr-2"></span>Purchase Order Analysis</a>
                        <div class="dropdown-divider"></div>
                        <a style="color: #2c3e50;" class="dropdown-item" href="puechaseanalyse.jsp"><span class="fa fa-anchor mr-2"></span>Purchase Details</a>
                        <a style="color: #2c3e50;" class="dropdown-item" href="purchaseanalysebi.jsp"><span class="fa fa-anchor mr-2"></span>Purchase Details (Branch & Item)</a>
                        <a style="color: #2c3e50;" class="dropdown-item" href="purchaseanalysebc.jsp"><span class="fa fa-anchor mr-2"></span>Purchase Details (Supplier)</a>
                        <div class="dropdown-divider"></div>
                        <a style="color: #2c3e50;" class="dropdown-item" href="damagestockanalys.jsp"><span class="fa fa-anchor mr-2"></span>Damage Stock Details (Supplier)</a>
                        <a style="color: #2c3e50;" class="dropdown-item" href="damagestockbyitem.jsp"><span class="fa fa-anchor mr-2"></span>Damage Stock Details (Item)</a>
                        <div class="dropdown-divider"></div>
                        <a style="color: #2c3e50;" class="dropdown-item" href="stockreturnanalyse.jsp"><span class="fa fa-anchor mr-2"></span>Goods Return Details</a>
                        <a style="color: #2c3e50;" class="dropdown-item" href="stockreturnbyi.jsp"><span class="fa fa-anchor mr-2"></span>Goods Return Details (Branch & Item)</a>
                        <div class="dropdown-divider"></div>
                        <a style="color: #2c3e50;" class="dropdown-item " href="invoicereturn.jsp"><span class="fa fa-anchor mr-2"></span>Sales Return Details</a>
                        <a style="color: #2c3e50;" class="dropdown-item" href="invoicereturnbi.jsp"><span class="fa fa-anchor mr-2"></span>Sales Return Details (Branch & Item)</a>



                    </div>
                </li>
                




            </ul>

        </div>
    </nav>
</header>

<% }else{
    response.sendRedirect("login.jsp");
} 
}catch(Exception e){
    response.sendRedirect("login.jsp");
}
%>

