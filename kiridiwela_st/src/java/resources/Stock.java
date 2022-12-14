package resources;
// Generated Jan 31, 2020 10:35:24 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Stock generated by hbm2java
 */
public class Stock  implements java.io.Serializable {


     private Integer stockId;
     private Branch branch;
     private Items items;
     private double qty;
     private int status;
     private String date;
     private Double cost;
     private Double price;
     private String time;
     private Set saleInvoiceItems = new HashSet(0);
     private Set holdInvoiceItems = new HashSet(0);
     private Set returnItems = new HashSet(0);
     private Set quotationInvoiceItems = new HashSet(0);
     private Set stockTransfers = new HashSet(0);
     private Set stockDamages = new HashSet(0);
     private Set stockPrices = new HashSet(0);

    public Stock() {
    }

	
    public Stock(Branch branch, Items items, double qty, int status) {
        this.branch = branch;
        this.items = items;
        this.qty = qty;
        this.status = status;
    }
    public Stock(Branch branch, Items items, double qty, int status, String date, Double cost, Double price, String time, Set saleInvoiceItems, Set holdInvoiceItems, Set returnItems, Set quotationInvoiceItems, Set stockTransfers, Set stockDamages, Set stockPrices) {
       this.branch = branch;
       this.items = items;
       this.qty = qty;
       this.status = status;
       this.date = date;
       this.cost = cost;
       this.price = price;
       this.time = time;
       this.saleInvoiceItems = saleInvoiceItems;
       this.holdInvoiceItems = holdInvoiceItems;
       this.returnItems = returnItems;
       this.quotationInvoiceItems = quotationInvoiceItems;
       this.stockTransfers = stockTransfers;
       this.stockDamages = stockDamages;
       this.stockPrices = stockPrices;
    }
   
    public Integer getStockId() {
        return this.stockId;
    }
    
    public void setStockId(Integer stockId) {
        this.stockId = stockId;
    }
    public Branch getBranch() {
        return this.branch;
    }
    
    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    public Items getItems() {
        return this.items;
    }
    
    public void setItems(Items items) {
        this.items = items;
    }
    public double getQty() {
        return this.qty;
    }
    
    public void setQty(double qty) {
        this.qty = qty;
    }
    public int getStatus() {
        return this.status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public Double getCost() {
        return this.cost;
    }
    
    public void setCost(Double cost) {
        this.cost = cost;
    }
    public Double getPrice() {
        return this.price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
    public String getTime() {
        return this.time;
    }
    
    public void setTime(String time) {
        this.time = time;
    }
    public Set getSaleInvoiceItems() {
        return this.saleInvoiceItems;
    }
    
    public void setSaleInvoiceItems(Set saleInvoiceItems) {
        this.saleInvoiceItems = saleInvoiceItems;
    }
    public Set getHoldInvoiceItems() {
        return this.holdInvoiceItems;
    }
    
    public void setHoldInvoiceItems(Set holdInvoiceItems) {
        this.holdInvoiceItems = holdInvoiceItems;
    }
    public Set getReturnItems() {
        return this.returnItems;
    }
    
    public void setReturnItems(Set returnItems) {
        this.returnItems = returnItems;
    }
    public Set getQuotationInvoiceItems() {
        return this.quotationInvoiceItems;
    }
    
    public void setQuotationInvoiceItems(Set quotationInvoiceItems) {
        this.quotationInvoiceItems = quotationInvoiceItems;
    }
    public Set getStockTransfers() {
        return this.stockTransfers;
    }
    
    public void setStockTransfers(Set stockTransfers) {
        this.stockTransfers = stockTransfers;
    }
    public Set getStockDamages() {
        return this.stockDamages;
    }
    
    public void setStockDamages(Set stockDamages) {
        this.stockDamages = stockDamages;
    }
    public Set getStockPrices() {
        return this.stockPrices;
    }
    
    public void setStockPrices(Set stockPrices) {
        this.stockPrices = stockPrices;
    }




}


