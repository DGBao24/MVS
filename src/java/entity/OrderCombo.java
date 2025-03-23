/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Nhat Anh
 */
public class OrderCombo {
    private int OrderComboID;
    private int OrderID;
    private int ComboID;
    private int Quantity;
    private float Price;

    public OrderCombo(int OrderComboID, int OrderID, int ComboID, int Quantity, float Price) {
        this.OrderComboID = OrderComboID;
        this.OrderID = OrderID;
        this.ComboID = ComboID;
        this.Quantity = Quantity;
        this.Price = Price;
    }

    public OrderCombo() {
    }

    public int getOrderComboID() {
        return OrderComboID;
    }

    public int getOrderID() {
        return OrderID;
    }

    public int getComboID() {
        return ComboID;
    }

    public int getQuantity() {
        return Quantity;
    }

    public float getPrice() {
        return Price;
    }

    public void setOrderComboID(int OrderComboID) {
        this.OrderComboID = OrderComboID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public void setComboID(int ComboID) {
        this.ComboID = ComboID;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public void setPrice(float Price) {
        this.Price = Price;
    }

    @Override
    public String toString() {
        return "OrderCombo{" + "OrderComboID=" + OrderComboID + ", OrderID=" + OrderID + ", ComboID=" + ComboID + ", Quantity=" + Quantity + ", Price=" + Price + '}';
    }
    
    
    
}
