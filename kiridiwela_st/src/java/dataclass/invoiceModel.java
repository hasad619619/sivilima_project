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
public class invoiceModel {

    public int getItemID() {
        return itemID;
    }

    public void setItemID(int itemID) {
        this.itemID = itemID;
    }

    double qty;
    double qty_original;
    int itemID;

    public double getQty_original() {
        return qty_original;
    }

    public void setQty_original(double qty_original) {
        this.qty_original = qty_original;
    }
    double price;

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }
    double cost;

    public double getDescount() {
        return descount;
    }

    public void setDescount(double descount) {
        this.descount = descount;
    }

    public double getTotal_descount() {
        return total_descount;
    }

    public void setTotal_descount(double total_descount) {
        this.total_descount = total_descount;
    }
    double total;
    double descount;
    double total_descount;
    int stockID;
    String ItemName, Type, Branch;

    public double getQty() {
        return qty;
    }

    public void setQty(double qty) {
        this.qty = qty;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public int getStockID() {
        return stockID;
    }

    public void setStockID(int stockID) {
        this.stockID = stockID;
    }

    public String getItemName() {
        return ItemName;
    }

    public void setItemName(String ItemName) {
        this.ItemName = ItemName;
    }

    public String getType() {
        return Type;
    }

    public void setType(String Type) {
        this.Type = Type;
    }

    public String getBranch() {
        return Branch;
    }

    public void setBranch(String Branch) {
        this.Branch = Branch;
    }

}
