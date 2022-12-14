package resources;
// Generated Jan 31, 2020 10:35:24 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * DoItem generated by hbm2java
 */
public class DoItem  implements java.io.Serializable {


     private Integer iddoItem;
     private Deo deo;
     private HoldInvoice holdInvoice;
     private Double transport;
     private String sendDate;
     private String sendTime;
     private Integer customerRecieved;
     private Integer status;
     private Set doHoldItems = new HashSet(0);

    public DoItem() {
    }

	
    public DoItem(Deo deo, HoldInvoice holdInvoice) {
        this.deo = deo;
        this.holdInvoice = holdInvoice;
    }
    public DoItem(Deo deo, HoldInvoice holdInvoice, Double transport, String sendDate, String sendTime, Integer customerRecieved, Integer status, Set doHoldItems) {
       this.deo = deo;
       this.holdInvoice = holdInvoice;
       this.transport = transport;
       this.sendDate = sendDate;
       this.sendTime = sendTime;
       this.customerRecieved = customerRecieved;
       this.status = status;
       this.doHoldItems = doHoldItems;
    }
   
    public Integer getIddoItem() {
        return this.iddoItem;
    }
    
    public void setIddoItem(Integer iddoItem) {
        this.iddoItem = iddoItem;
    }
    public Deo getDeo() {
        return this.deo;
    }
    
    public void setDeo(Deo deo) {
        this.deo = deo;
    }
    public HoldInvoice getHoldInvoice() {
        return this.holdInvoice;
    }
    
    public void setHoldInvoice(HoldInvoice holdInvoice) {
        this.holdInvoice = holdInvoice;
    }
    public Double getTransport() {
        return this.transport;
    }
    
    public void setTransport(Double transport) {
        this.transport = transport;
    }
    public String getSendDate() {
        return this.sendDate;
    }
    
    public void setSendDate(String sendDate) {
        this.sendDate = sendDate;
    }
    public String getSendTime() {
        return this.sendTime;
    }
    
    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
    }
    public Integer getCustomerRecieved() {
        return this.customerRecieved;
    }
    
    public void setCustomerRecieved(Integer customerRecieved) {
        this.customerRecieved = customerRecieved;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Set getDoHoldItems() {
        return this.doHoldItems;
    }
    
    public void setDoHoldItems(Set doHoldItems) {
        this.doHoldItems = doHoldItems;
    }




}


