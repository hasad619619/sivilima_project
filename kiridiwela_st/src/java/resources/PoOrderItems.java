package resources;
// Generated Jan 31, 2020 10:35:24 PM by Hibernate Tools 4.3.1



/**
 * PoOrderItems generated by hbm2java
 */
public class PoOrderItems  implements java.io.Serializable {


     private Integer idpoOrderItems;
     private Items items;
     private PurchaseInvoiceOrder purchaseInvoiceOrder;
     private Double qty;
     private Double qtyRecived;
     private Integer status;
     private Double cost;
     private Double total;

    public PoOrderItems() {
    }

	
    public PoOrderItems(Items items, PurchaseInvoiceOrder purchaseInvoiceOrder) {
        this.items = items;
        this.purchaseInvoiceOrder = purchaseInvoiceOrder;
    }
    public PoOrderItems(Items items, PurchaseInvoiceOrder purchaseInvoiceOrder, Double qty, Double qtyRecived, Integer status, Double cost, Double total) {
       this.items = items;
       this.purchaseInvoiceOrder = purchaseInvoiceOrder;
       this.qty = qty;
       this.qtyRecived = qtyRecived;
       this.status = status;
       this.cost = cost;
       this.total = total;
    }
   
    public Integer getIdpoOrderItems() {
        return this.idpoOrderItems;
    }
    
    public void setIdpoOrderItems(Integer idpoOrderItems) {
        this.idpoOrderItems = idpoOrderItems;
    }
    public Items getItems() {
        return this.items;
    }
    
    public void setItems(Items items) {
        this.items = items;
    }
    public PurchaseInvoiceOrder getPurchaseInvoiceOrder() {
        return this.purchaseInvoiceOrder;
    }
    
    public void setPurchaseInvoiceOrder(PurchaseInvoiceOrder purchaseInvoiceOrder) {
        this.purchaseInvoiceOrder = purchaseInvoiceOrder;
    }
    public Double getQty() {
        return this.qty;
    }
    
    public void setQty(Double qty) {
        this.qty = qty;
    }
    public Double getQtyRecived() {
        return this.qtyRecived;
    }
    
    public void setQtyRecived(Double qtyRecived) {
        this.qtyRecived = qtyRecived;
    }
    public Integer getStatus() {
        return this.status;
    }
    
    public void setStatus(Integer status) {
        this.status = status;
    }
    public Double getCost() {
        return this.cost;
    }
    
    public void setCost(Double cost) {
        this.cost = cost;
    }
    public Double getTotal() {
        return this.total;
    }
    
    public void setTotal(Double total) {
        this.total = total;
    }




}


