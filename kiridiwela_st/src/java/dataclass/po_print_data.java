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
public class po_print_data {
    String Item;
    double Qty;
    int Item_Id;

    public int getItem_Id() {
        return Item_Id;
    }

    public void setItem_Id(int Item_Id) {
        this.Item_Id = Item_Id;
    }

    public String getItem() {
        return Item;
    }

    public void setItem(String Item) {
        this.Item = Item;
    }

    public double getQty() {
        return Qty;
    }

    public void setQty(double Qty) {
        this.Qty = Qty;
    }
    
}
