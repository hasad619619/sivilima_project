package resources;
// Generated Jan 31, 2020 10:35:24 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * StockReturn generated by hbm2java
 */
public class StockReturn  implements java.io.Serializable {


     private Integer idstockReturn;
     private Account account;
     private Branch branch;
     private User user;
     private String date;
     private Double amount;
     private Integer status;
     private Set returnItems = new HashSet(0);

    public StockReturn() {
    }

	
    public StockReturn(Account account, Branch branch, User user) {
        this.account = account;
        this.branch = branch;
        this.user = user;
    }
    public StockReturn(Account account, Branch branch, User user, String date, Double amount, Integer status, Set returnItems) {
       this.account = account;
       this.branch = branch;
       this.user = user;
       this.date = date;
       this.amount = amount;
       this.status = status;
       this.returnItems = returnItems;
    }
   
    public Integer getIdstockReturn() {
        return this.idstockReturn;
    }
    
    public void setIdstockReturn(Integer idstockReturn) {
        this.idstockReturn = idstockReturn;
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
    public Set getReturnItems() {
        return this.returnItems;
    }
    
    public void setReturnItems(Set returnItems) {
        this.returnItems = returnItems;
    }




}


