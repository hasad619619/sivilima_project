/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

/**
 *
 * @author Mayura Lakshan
 */
public class invoiceReturnModel {
    int id,Item_ID,Type_ID,invoice_id,account_id,stock_id;
    double alredy_return;
    double descount_from_total,descount,item_desk;

    public double getItem_desk() {
        return item_desk;
    }

    public void setItem_desk(double item_desk) {
        this.item_desk = item_desk;
    }

    public double getDescount() {
        return descount;
    }

    public void setDescount(double descount) {
        this.descount = descount;
    }

    public double getDescount_from_total() {
        return descount_from_total;
    }

    public void setDescount_from_total(double descount_from_total) {
        this.descount_from_total = descount_from_total;
    }
    public int getStock_id() {
        return stock_id;
    }

    public double getAlredy_return() {
        return alredy_return;
    }

    public void setAlredy_return(double alredy_return) {
        this.alredy_return = alredy_return;
    }

    public void setStock_id(int stock_id) {
        this.stock_id = stock_id;
    }

    public int getId() {
        return id;
    }

    public int getInvoice_id() {
        return invoice_id;
    }

    public void setInvoice_id(int invoice_id) {
        this.invoice_id = invoice_id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getItem_ID() {
        return Item_ID;
    }

    public void setItem_ID(int Item_ID) {
        this.Item_ID = Item_ID;
    }

    public int getType_ID() {
        return Type_ID;
    }

    public void setType_ID(int Type_ID) {
        this.Type_ID = Type_ID;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public double getNet_total() {
        return net_total;
    }

    public void setNet_total(double net_total) {
        this.net_total = net_total;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getItem() {
        return Item;
    }

    public void setItem(String Item) {
        this.Item = Item;
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
    double total,net_total,price,qty;

    public double getQty() {
        return qty;
    }

    public void setQty(double qty) {
        this.qty = qty;
    }

    public String getNow_type() {
        return Now_type;
    }

    public void setNow_type(String Now_type) {
        this.Now_type = Now_type;
    }
    String Item,Type,Branch,Now_type;
            
}
