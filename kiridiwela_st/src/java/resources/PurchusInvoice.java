package resources;
// Generated Jan 31, 2020 10:35:24 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * PurchusInvoice generated by hbm2java
 */
public class PurchusInvoice  implements java.io.Serializable {


     private Integer idpurchusInvoice;
     private Account account;
     private Branch branch;
     private PaymentType paymentType;
     private PurchaseInvoiceOrder purchaseInvoiceOrder;
     private User user;
     private String date;
     private Double cash;
     private Double balance;
     private Double netTotal;
     private Double descount;
     private Double total;
     private Double paid;
     private Double paible;
     private Double returnAmount;
     private String time;
     private Set purchusInvoiceRecipts = new HashSet(0);
     private Set purchusInvoiceItems = new HashSet(0);

    public PurchusInvoice() {
    }

	
    public PurchusInvoice(Account account, Branch branch, PaymentType paymentType, PurchaseInvoiceOrder purchaseInvoiceOrder, User user) {
        this.account = account;
        this.branch = branch;
        this.paymentType = paymentType;
        this.purchaseInvoiceOrder = purchaseInvoiceOrder;
        this.user = user;
    }
    public PurchusInvoice(Account account, Branch branch, PaymentType paymentType, PurchaseInvoiceOrder purchaseInvoiceOrder, User user, String date, Double cash, Double balance, Double netTotal, Double descount, Double total, Double paid, Double paible, Double returnAmount, String time, Set purchusInvoiceRecipts, Set purchusInvoiceItems) {
       this.account = account;
       this.branch = branch;
       this.paymentType = paymentType;
       this.purchaseInvoiceOrder = purchaseInvoiceOrder;
       this.user = user;
       this.date = date;
       this.cash = cash;
       this.balance = balance;
       this.netTotal = netTotal;
       this.descount = descount;
       this.total = total;
       this.paid = paid;
       this.paible = paible;
       this.returnAmount = returnAmount;
       this.time = time;
       this.purchusInvoiceRecipts = purchusInvoiceRecipts;
       this.purchusInvoiceItems = purchusInvoiceItems;
    }
   
    public Integer getIdpurchusInvoice() {
        return this.idpurchusInvoice;
    }
    
    public void setIdpurchusInvoice(Integer idpurchusInvoice) {
        this.idpurchusInvoice = idpurchusInvoice;
    }
    public Account getAccount() {
        return this.account;
    }
    
    public void setAccount(Account account) {
        this.account = account;
    }
    public Branch getBranch() {
        return this.branch;
    }
    
    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    public PaymentType getPaymentType() {
        return this.paymentType;
    }
    
    public void setPaymentType(PaymentType paymentType) {
        this.paymentType = paymentType;
    }
    public PurchaseInvoiceOrder getPurchaseInvoiceOrder() {
        return this.purchaseInvoiceOrder;
    }
    
    public void setPurchaseInvoiceOrder(PurchaseInvoiceOrder purchaseInvoiceOrder) {
        this.purchaseInvoiceOrder = purchaseInvoiceOrder;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public Double getCash() {
        return this.cash;
    }
    
    public void setCash(Double cash) {
        this.cash = cash;
    }
    public Double getBalance() {
        return this.balance;
    }
    
    public void setBalance(Double balance) {
        this.balance = balance;
    }
    public Double getNetTotal() {
        return this.netTotal;
    }
    
    public void setNetTotal(Double netTotal) {
        this.netTotal = netTotal;
    }
    public Double getDescount() {
        return this.descount;
    }
    
    public void setDescount(Double descount) {
        this.descount = descount;
    }
    public Double getTotal() {
        return this.total;
    }
    
    public void setTotal(Double total) {
        this.total = total;
    }
    public Double getPaid() {
        return this.paid;
    }
    
    public void setPaid(Double paid) {
        this.paid = paid;
    }
    public Double getPaible() {
        return this.paible;
    }
    
    public void setPaible(Double paible) {
        this.paible = paible;
    }
    public Double getReturnAmount() {
        return this.returnAmount;
    }
    
    public void setReturnAmount(Double returnAmount) {
        this.returnAmount = returnAmount;
    }
    public String getTime() {
        return this.time;
    }
    
    public void setTime(String time) {
        this.time = time;
    }
    public Set getPurchusInvoiceRecipts() {
        return this.purchusInvoiceRecipts;
    }
    
    public void setPurchusInvoiceRecipts(Set purchusInvoiceRecipts) {
        this.purchusInvoiceRecipts = purchusInvoiceRecipts;
    }
    public Set getPurchusInvoiceItems() {
        return this.purchusInvoiceItems;
    }
    
    public void setPurchusInvoiceItems(Set purchusInvoiceItems) {
        this.purchusInvoiceItems = purchusInvoiceItems;
    }




}


