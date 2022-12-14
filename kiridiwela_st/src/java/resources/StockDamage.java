package resources;
// Generated Jan 31, 2020 10:35:24 PM by Hibernate Tools 4.3.1



/**
 * StockDamage generated by hbm2java
 */
public class StockDamage  implements java.io.Serializable {


     private Integer stockDamageId;
     private Branch branch;
     private Stock stock;
     private double qty;
     private String date;
     private String comment;
     private Integer status;

    public StockDamage() {
    }

	
    public StockDamage(Branch branch, Stock stock, double qty, String date, String comment) {
        this.branch = branch;
        this.stock = stock;
        this.qty = qty;
        this.date = date;
        this.comment = comment;
    }
    public StockDamage(Branch branch, Stock stock, double qty, String date, String comment, Integer status) {
       this.branch = branch;
       this.stock = stock;
       this.qty = qty;
       this.date = date;
       this.comment = comment;
       this.status = status;
    }
   
    public Integer getStockDamageId() {
        return this.stockDamageId;
    }
    
    public void setStockDamageId(Integer stockDamageId) {
        this.stockDamageId = stockDamageId;
    }
    public Branch getBranch() {
        return this.branch;
    }
    
    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    public Stock getStock() {
        return this.stock;
    }
    
    public void setStock(Stock stock) {
        this.stock = stock;
    }
    public double getQty() {
        return this.qty;
    }
    
    public void setQty(double qty) {
        this.qty = qty;
    }
    public String getDate() {
        return this.date;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public String getComment() {
        return this.comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }




}


