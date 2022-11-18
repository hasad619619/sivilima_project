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
public class do_data {

    public int getHold_Invoice_Number() {
        return Hold_Invoice_Number;
    }

    public void setHold_Invoice_Number(int Hold_Invoice_Number) {
        this.Hold_Invoice_Number = Hold_Invoice_Number;
    }

    public int getItem_ID() {
        return Item_ID;
    }

    public void setItem_ID(int Item_ID) {
        this.Item_ID = Item_ID;
    }

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

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getItem_Name() {
        return Item_Name;
    }

    public double getQty_sended() {
        return Qty_sended;
    }

    public void setQty_sended(double Qty_sended) {
        this.Qty_sended = Qty_sended;
    }

    public void setItem_Name(String Item_Name) {
        this.Item_Name = Item_Name;
    }

    public int getStock_id() {
        return stock_id;
    }

    public void setStock_id(int stock_id) {
        this.stock_id = stock_id;
    }
    int Hold_Invoice_Number,Item_ID,stock_id,hold_Id;

    public double getTransport() {
        return transport;
    }

    public void setTransport(double transport) {
        this.transport = transport;
    }

    public double getQty_send() {
        return qty_send;
    }

    public void setQty_send(double qty_send) {
        this.qty_send = qty_send;
    }

    public int getHold_Id() {
        return hold_Id;
    }

    public void setHold_Id(int hold_Id) {
        this.hold_Id = hold_Id;
    }
    double qty,price,discount,total,Qty_sended,transport,qty_send;
    String Item_Name;
    
}
