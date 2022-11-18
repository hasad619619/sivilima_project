package resources;
// Generated Jan 31, 2020 10:35:24 PM by Hibernate Tools 4.3.1



/**
 * ReturnItem generated by hbm2java
 */
public class ReturnItem  implements java.io.Serializable {


     private Integer idreturnItem;
     private Branch branch;
     private Stock stock;
     private StockReturn stockReturn;
     private Double qtt;
     private Double cost;
     private Double amount;
     private Integer status;

    public ReturnItem() {
    }

	
    public ReturnItem(Branch branch, Stock stock, StockReturn stockReturn) {
        this.branch = branch;
        this.stock = stock;
        this.stockReturn = stockReturn;
    }
    public ReturnItem(Branch branch, Stock stock, StockReturn stockReturn, Double qtt, Double cost, Double amount, Integer status) {
       this.branch = branch;
       this.stock = stock;
       this.stockReturn = stockReturn;
       this.qtt = qtt;
       this.cost = cost;
       this.amount = amount;
       this.status = status;
    }
   
    public Integer getIdreturnItem() {
        return this.idreturnItem;
    }
    
    public void setIdreturnItem(Integer idreturnItem) {
        this.idreturnItem = idreturnItem;
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
    public StockReturn getStockReturn() {
        return this.stockReturn;
    }
    
    public void setStockReturn(StockReturn stockReturn) {
        this.stockReturn = stockReturn;
    }
    public Double getQtt() {
        return this.qtt;
    }
    
    public void setQtt(Double qtt) {
        this.qtt = qtt;
    }
    public Double getCost() {
        return this.cost;
    }
    
    public void setCost(Double cost) {
        this.cost = cost;
    }
    public Double getAmount() {
        return this.amount;
    }
    
    public void setAmount(Double amount) {
        this.amount = amount;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }




}


