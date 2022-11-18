/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataclass;

/**
 *
 * @author Mayura Lakshan
 */
public class stockPriceModel {

    public int getCustomerTypeid() {
        return customerTypeid;
    }

    public void setCustomerTypeid(int customerTypeid) {
        this.customerTypeid = customerTypeid;
    }

    public int getStockId() {
        return stockId;
    }

    public void setStockId(int stockId) {
        this.stockId = stockId;
    }

    public String getCustomerType() {
        return CustomerType;
    }

    public void setCustomerType(String CustomerType) {
        this.CustomerType = CustomerType;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    int customerTypeid,stockId;
    String CustomerType;
    double price;
    
    
    
}
