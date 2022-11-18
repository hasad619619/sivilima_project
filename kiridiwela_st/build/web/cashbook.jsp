<%@page import="resources.PayEmployee"%>
<%@page import="resources.PayExpencess"%>
<%@page import="resources.DoItem"%>
<%@page import="resources.Deo"%>
<%@page import="resources.SalesReturn"%>
<%@page import="resources.PurchusInvoice"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="resources.HoldInvoice"%>
<%@page import="resources.HoldRecipt"%>
<%@page import="resources.OtherTrans"%>
<%@page import="dataclass.helper"%>
<%@page import="resources.Branch"%>
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
        <title><%= Name%></title>

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
        <div class="loader"></div>
        <!-- include header-->
        <jsp:include page="includes/header.jsp" />
        <!-- include header-->
        <%
            DecimalFormat df = new DecimalFormat("##########0.00");
            Session ses = connection.getConnection.getSessionFactory().openSession();
            helper help = new helper();
            String Date = help.getDate();
            String Date2 = help.getDate();
            String BranchN = "ALL";

            int branch = 0;

            if (request.getParameter("q") != null && !request.getParameter("q").equals("")
                    && request.getParameter("q2") != null && !request.getParameter("q2").equals("")
                    && request.getParameter("b") != null && !request.getParameter("b").equals("")) {
                Date = request.getParameter("q");
                Date2 = request.getParameter("q2");
                
                branch = Integer.parseInt(request.getParameter("b"));

                if (!request.getParameter("b").equals("0")) {
                    Branch B = (Branch) ses.load(Branch.class, branch);
                    BranchN = B.getName();
                }

            }

            double total_cheque_received = 0.0;
            double total_cheque_relesaed = 0.0;
            double total_cheque_returned = 0.0;
            double total_cheque_deposited_to_bank = 0.0;
            double total_cash_received = 0.0;
            double total_cash_relesaed = 0.0;
            double total_cash_relesaed_emp = 0.0;
            double total_cash_returned = 0.0;
            double total_cash_deposited_to_bank = 0.0;
            double total_credit_sales = 0.0;
            double total_credit_purchase = 0.0;
            double total_expencess = 0.0;

            double total_invoice_return = 0.0;
            double total_item_deleverd = 0.0;

            /* 1 - CREDIT
               2 - CASH
               3 - CHEQUE
               4 - BANK DEPOSIT */
            Session s = connection.getConnection.getSessionFactory().openSession();

            
            Criteria pe = s.createCriteria(PayExpencess.class);
            pe.add(Restrictions.eq("status", 1));
            pe.add(Restrictions.between("addedDate", Date, Date2));
            List<PayExpencess> pl = pe.list();
            if(branch > 0){
                for (PayExpencess de : pl) {
                    if(de.getExpencessAccount().getBranch().getIdbranch() == branch){
                        total_expencess = total_expencess + de.getAmount();
                    }
                }
            }else{
                for (PayExpencess de : pl) {
                    total_expencess = total_expencess + de.getAmount();
                }
            }
            
            Criteria che = s.createCriteria(PayEmployee.class);
            che.add(Restrictions.eq("status", 1));
            che.add(Restrictions.between("addedDate", Date, Date2));
            List<PayEmployee> l_che = che.list();

            if (branch > 0) {
                for (PayEmployee p : l_che) {
                    if (p.getEmployeeAccount().getBranch().getIdbranch() == branch) {
                        total_cash_relesaed_emp = total_cash_relesaed_emp + p.getAmount();
                    }
                }
            } else {
                for (PayEmployee p : l_che) {
                    total_cash_relesaed_emp = total_cash_relesaed_emp + p.getAmount();
                }

            }
            
            
            Criteria deo = s.createCriteria(Deo.class);
            deo.add(Restrictions.eq("status", 1));
            deo.add(Restrictions.between("date", Date, Date2));
            List<Deo> d = deo.list();
            for (Deo de : d) {
                Set<DoItem> di = de.getDoItems();
                for (DoItem h : di) {

                }
            }

            Criteria cpur = s.createCriteria(PurchusInvoiceRecipt.class);
            cpur.add(Restrictions.eq("status", 1));
            cpur.add(Restrictions.between("date", Date, Date2));
            
            if (branch > 0) {
                cpur.createAlias("branch", "A");
                cpur.add(Restrictions.eq("A.idbranch", branch));
            }
            List<PurchusInvoiceRecipt> l_cpur = cpur.list();
            for (PurchusInvoiceRecipt L : l_cpur) {
                if (L.getPurchusInvoice() == null) {
                    if (L.getPaymentType().getIdpaymentType() == 1) {

                    } else if (L.getPaymentType().getIdpaymentType() == 2) {
                        
                        if (L.getAccountBySupplier().getEmployee() == 1) {
                            
                        }
                        if (L.getAccountBySupplier().getSupplier() == 1 || L.getAccountBySupplier().getCustomer() == 1) {
                            total_cash_relesaed = total_cash_relesaed + L.getAmount();
                        }

                    } else if (L.getPaymentType().getIdpaymentType() == 3) {

                        
                        if (L.getAccountBySupplier().getEmployee() == 1) {
                            
                        }
                        if (L.getAccountBySupplier().getSupplier() == 1 || L.getAccountBySupplier().getCustomer() == 1) {
                            total_cheque_relesaed = total_cheque_relesaed + L.getAmount();
                        }
                    }

                }
            }

            Criteria cinvr = s.createCriteria(SalesReturn.class);
            cinvr.add(Restrictions.eq("status", 1));
            cinvr.add(Restrictions.between("date", Date, Date2));
            
            List<SalesReturn> l_cinvr = cinvr.list();
            for (SalesReturn L : l_cinvr) {
                total_invoice_return = total_invoice_return + L.getAmount();
            }

            Criteria cinv = s.createCriteria(InvoiceRecipt.class);
            cinv.add(Restrictions.eq("status", 1));
            cinv.add(Restrictions.between("date", Date, Date2));
            
            if (branch > 0) {
                cinv.createAlias("branch", "A");
                cinv.add(Restrictions.eq("A.idbranch", branch));
            }
            List<InvoiceRecipt> l_cinv = cinv.list();
            for (InvoiceRecipt L : l_cinv) {
                if (L.getSaleInvoice() == null) {
                    if (L.getAccountByCustomer().getSupplier() == 1 || L.getAccountByCustomer().getCustomer() == 1) {
                        if (L.getPaymentType().getIdpaymentType() == 1) {
                            total_credit_sales = total_credit_sales + L.getAmount();
                        } else if (L.getPaymentType().getIdpaymentType() == 2) {
                            total_cash_received = total_cash_received + L.getAmount();
                        } else if (L.getPaymentType().getIdpaymentType() == 3) {
                            total_cheque_received = total_cheque_received + L.getAmount();
                        } else if (L.getPaymentType().getIdpaymentType() == 4) {
                            total_cash_deposited_to_bank = total_cash_deposited_to_bank + L.getAmount();

                        }
                    }

                }
            }

            Criteria cot = s.createCriteria(OtherTrans.class);
            cot.add(Restrictions.eq("status", 1));
            cot.add(Restrictions.between("date", Date, Date2));
            
            if (branch > 0) {
                cot.createAlias("branch", "A");
                cot.add(Restrictions.eq("A.idbranch", branch));
            }
            List<OtherTrans> l_cot = cot.list();
            for (OtherTrans L : l_cot) {

                if (L.getPaymentType().getIdpaymentType() == 2) {
                    if (L.getDebit() == 1) {

                    }
                    if (L.getCredit() == 1) {

                    }
                } else if (L.getPaymentType().getIdpaymentType() == 3) {
                    if (L.getDebit() == 1) {

                    }
                    if (L.getCredit() == 1) {

                    }

                }
            }

            Criteria cpu = s.createCriteria(PurchusInvoice.class);
            cpu.add(Restrictions.between("date", Date, Date2));
            
            if (branch > 0) {
                cpu.createAlias("branch", "A");
                cpu.add(Restrictions.eq("A.idbranch", branch));
            }
            List<PurchusInvoice> l_cpu = cpu.list();
            for (PurchusInvoice L : l_cpu) {
                if (L.getPaymentType().getIdpaymentType() == 1) {
                    total_credit_purchase = total_credit_purchase + L.getTotal();
                } else {
                    Set<PurchusInvoiceRecipt> pr = L.getPurchusInvoiceRecipts();
                    for (PurchusInvoiceRecipt h : pr) {
                        if (h.getStatus() == 1 && h.getPaymentType().getIdpaymentType() == 2) {
                            total_cash_relesaed = total_cash_relesaed + h.getAmount();
                        }
                        if (h.getStatus() == 1 && h.getPaymentType().getIdpaymentType() == 3) {
                            total_cheque_relesaed = total_cheque_relesaed + h.getAmount();

                        }
                    }

                }

            }

            Criteria cin = s.createCriteria(SaleInvoice.class);
            cin.add(Restrictions.between("date", Date, Date2));
            
            if (branch > 0) {
                cin.createAlias("branch", "A");
                cin.add(Restrictions.eq("A.idbranch", branch));
            }
            List<SaleInvoice> l_cin = cin.list();
            for (SaleInvoice L : l_cin) {
                if (L.getPaymentType().getIdpaymentType() == 1) {
                    total_credit_sales = total_credit_sales + L.getTotal();
                } else {
                    Set<InvoiceRecipt> hr = L.getInvoiceRecipts();
                    for (InvoiceRecipt h : hr) {
                        if (h.getStatus() == 1 && h.getPaymentType().getIdpaymentType() == 2) {
                            total_cash_received = total_cash_received + h.getAmount();
                        }
                        if (h.getStatus() == 1 && h.getPaymentType().getIdpaymentType() == 3) {

                            if (h.getCheStatus() == 0) {
                                total_cheque_returned = total_cheque_returned + h.getAmount();
                            } else if (h.getCheStatus() == 1) {
                                total_cheque_received = total_cheque_received + h.getAmount();
                            } else if (h.getCheStatus() == 2) {
                                total_cheque_deposited_to_bank = total_cheque_deposited_to_bank + h.getAmount();
                            }
                        }
                    }

                }

            }

            Criteria chr = s.createCriteria(HoldInvoice.class);
            chr.add(Restrictions.eq("status", 1));
            chr.add(Restrictions.between("date", Date, Date2));
            
            if (branch > 0) {
                chr.createAlias("branch", "A");
                chr.add(Restrictions.eq("A.idbranch", branch));
            }
            List<HoldInvoice> l_chr = chr.list();
            for (HoldInvoice L : l_chr) {
                if (L.getPaymentType().getIdpaymentType() == 1) {
                    total_credit_sales = total_credit_sales + L.getTotal();
                } else {
                    Set<HoldRecipt> hr = L.getHoldRecipts();
                    for (HoldRecipt h : hr) {

                        if (h.getStatus() == 1 && h.getPaymentType().getIdpaymentType() == 2) {
                            total_cash_received = total_cash_received + h.getAmount();
                        }
                        if (h.getStatus() == 1 && h.getPaymentType().getIdpaymentType() == 3) {

                            if (h.getCheStatus() == 0) {
                                total_cheque_returned = total_cheque_returned + h.getAmount();
                            } else if (h.getCheStatus() == 1) {
                                total_cheque_received = total_cheque_received + h.getAmount();
                            } else if (h.getCheStatus() == 2) {
                                total_cheque_deposited_to_bank = total_cheque_deposited_to_bank + h.getAmount();
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
                        <li class="breadcrumb-item" style="font-size: 16px;"><span class="fa fa-balance-scale"></span>&nbsp;&nbsp;&nbsp;CASH BALANCE</li>

                    </ol>
                </nav>
            </div>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">
                        <form method="get" action="cashbook.jsp" >
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:80px;" id="inputGroup-sizing-default">ST DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q" id="q" value="<%=Date%>">
                                    </div>


                                </div>
                                <div class="col-md-3">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:80px;" id="inputGroup-sizing-default">EN DATE</span>
                                        </div>
                                        <input type="date" class="form-control" name="q2" id="q2" value="<%=Date2%>">
                                    </div>


                                </div>
                               
                                <div class="col-md-6">
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text" style="width:80px;" id="inputGroup-sizing-default">BRANCH</span>
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

                                <div class="col-md-2">

                                    <div class="btn-group mb-3" role="group" aria-label="Basic example">
                                        <button type="submit" class="btn btn-success" id="save"><span class="fa fa-search mr-2"></span>FIND</button>

                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <%                if (Date != "" && Date2 != "") {
            %>
            <div class="row mt-2">
                <div class="card col-md-12" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-12">
                                <table class="table table-bordered table-sm">
                                    <tr>
                                        <th style="background-color: #4b6584 !important; color: white !important; ">DETAILS</th>
                                        <th style="background-color: #4b6584 !important; color: white !important; ">AMOUNT</th>
                                        <th style="background-color: #4b6584 !important; color: white !important; "></th>
                                    </tr>

                                    <tr>
                                        <th>TOTAL CHEQUE RELEASED</th>
                                        <th><%=df.format(total_cheque_relesaed)%></th>
                                        <th><a class="btn btn-sm" style="background-color: #40739e !important; color: white !important; "   href="more_release_cheque.jsp?q=<%=Date%>&q2=<%=Date2%>&b=<%=branch%>&a=0">MORE</a></th>

                                    </tr>    


                                    <tr>
                                        <th>TOTAL CHEQUE RECEIVED</th>
                                        <th><%=df.format(total_cheque_received + total_cheque_deposited_to_bank)%></th>
                                        <th><a class="btn btn-sm" style="background-color: #40739e !important; color: white !important; " href="more_recive_cheque.jsp?q=<%=Date%>&q2=<%=Date2%>&b=<%=branch%>&a=0">MORE</a></th>

                                    </tr>
                                    <tr>
                                        <th>TOTAL CASH RECEIVED</th>
                                        <th><%=df.format(total_cash_received)%></th>
                                        <th><a class="btn btn-sm" style="background-color: #40739e !important; color: white !important; " href="more_recive_cash.jsp?q=<%=Date%>&q2=<%=Date2%>&b=<%=branch%>&a=0">MORE</a></th>

                                    </tr>
                                    <tr>
                                        <th>TOTAL CASH DEPOSITED TO BANK</th>
                                        <th><%=df.format(total_cash_deposited_to_bank)%></th>
                                        <th><a class="btn btn-sm" style="background-color: #40739e !important; color: white !important; " href="more_bank_deposit.jsp?q=<%=Date%>&q2=<%=Date2%>&b=<%=branch%>&a=0">MORE</a></th>

                                    </tr>
                                    <tr class="d-none">
                                        <th>TOTAL ITEM DELIVERED</th>
                                        <th><%=df.format(total_invoice_return)%></th>
                                        <th></th>

                                    </tr>
                                    <tr>
                                        <th>TOTAL INVOICE RETURNED</th>
                                        <th><%=df.format(total_invoice_return)%></th>
                                        <th><a class="btn btn-sm" style="background-color: #40739e !important; color: white !important; " href="more_return_invoice.jsp?q=<%=Date%>&q2=<%=Date2%>&b=<%=branch%>&a=0">MORE</a></th>

                                    </tr>
                                    <tr>
                                        <th>TOTAL CASH RELEASED</th>
                                        <th><%=df.format(total_cash_relesaed)%></th>
                                        <th><a class="btn btn-sm" style="background-color: #40739e !important; color: white !important; " href="more_release_cash.jsp?q=<%=Date%>&q2=<%=Date2%>&b=<%=branch%>&a=0">MORE</a></th>

                                    </tr>
                                    <tr>
                                        <th>TOTAL EXPENSES</th>
                                        <th><%=df.format(total_expencess)%></th>
                                        <th><a class="btn btn-sm" style="background-color: #40739e !important; color: white !important; " href="more_expence.jsp?q=<%=Date%>&q2=<%=Date2%>&b=<%=branch%>&a=0">MORE</a></th>

                                    </tr>
                                    <tr>
                                        <th>TOTAL CASH RELEASE EMPLOYEE</th>
                                        <th><%=df.format(total_cash_relesaed_emp)%></th>
                                        <th><a class="btn btn-sm" style="background-color: #40739e !important; color: white !important; " href="more_emp.jsp?q=<%=Date%>&q2=<%=Date2%>&b=<%=branch%>&a=0">MORE</a></th>

                                    </tr>
                                    <tr>

                                    <tr>
                                        <th>TOTAL CREDIT SALES</th>
                                        <th><%=df.format(total_credit_sales)%></th>
                                        <th><a class="btn btn-sm" style="background-color: #40739e !important; color: white !important; " href="more_credit_sales.jsp?q=<%=Date%>&q2=<%=Date2%>&b=<%=branch%>&a=0">MORE</a></th>
                                    </tr>
                                    <tr>
                                        <th>TOTAL CREDIT PURCHASE</th>
                                        <th><%=df.format(total_credit_purchase)%></th>
                                        <th><a class="btn btn-sm" style="background-color: #40739e !important; color: white !important; " href="more_purchase_credit.jsp?q=<%=Date%>&q2=<%=Date2%>&b=<%=branch%>&a=0">MORE</a></th>
                                    </tr>
                                    <tr >
                                        <th style="background-color: #27ae60 !important; color: white !important; ">CASH BALANCE ON DRAWER</th>
                                        <th style="background-color: #27ae60 !important; color: white !important; "><%=df.format(total_cash_received - total_cash_relesaed)%></th>
                                        <th style="background-color: #27ae60 !important; color: white !important; "></th>
                                    </tr>

                                </table>





                            </div>
                            <div class="col-md-6">



                            </div>
                        </div>


                    </div>
                </div>
            </div>


            <%
                }
            %>


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

        <script type="text/javascript">

            $(window).load(function () {
                $('.loader').fadeOut();
            });

            $('#b').val(<%=branch%>);

            var sDate = $('#SD').html();
            var eDate = $('#ED').html();
            var eBranch = $('#EB').html();
            var eAccount = $('#EA').html();
            var tIn = $('#A').html();
            var tOut = $('#B').html();
            var tBal = $('#C').html();




            $(document).ready(function () {
                $('#tbl1').DataTable({
                    dom: 'Blfrtip',
                    buttons: [
                        {
                            extend: 'copyHtml5',
                            exportOptions: {
                                columns: [0, 1, 2]
                            }
                        },
                        {
                            extend: 'excelHtml5',
                            exportOptions: {
                                columns: [0, 1, 2]
                            }
                        },
                        {
                            extend: 'pdfHtml5',
                            exportOptions: {
                                columns: [0, 1, 2]
                            }
                        },
                        {
                            extend: 'print',
                            exportOptions: {
                                columns: [0, 1, 2]
                            },
                            customize: function (win) {
                                $(win.document.body).append('<h5>-------------------------------------------</h5>'); //after the table
                                $(win.document.body).append('<h5>Start Date:' + sDate + '</h5>'); //after the table
                                $(win.document.body).append('<h5>End Date:' + eDate + '</h5>'); //after the table
                                $(win.document.body).append('<h5>Branch:' + eBranch + '</h5>'); //after the table
                                $(win.document.body).append('<h5>Account:' + eAccount + '</h5>'); //after the table
                                $(win.document.body).append('<h5>Cash In:' + tIn + '</h5>'); //after the table
                                $(win.document.body).append('<h5>Cash Out:' + tOut + '</h5>'); //after the table
                                $(win.document.body).append('<h5>Balance:' + tBal + '</h5>'); //after the table
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