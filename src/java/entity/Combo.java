/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author pdatt
 */
public class Combo {
    private int ComboID;
    private String ComboItem;
    private String Description;
    private float Price;
    private int Quantity;
    private boolean Status;

    public Combo() {
    }

    public Combo(String ComboItem, String Description, float Price, int Quantity, boolean Status) {
        this.ComboItem = ComboItem;
        this.Description = Description;
        this.Price = Price;
        this.Quantity = Quantity;
        this.Status = Status;
    }

    public Combo(int ComboID, boolean Status) {
        this.ComboID = ComboID;
        this.Status = Status;
    }
    
    

    public Combo(int ComboID, String ComboItem, String Description, float Price, int Quantity, boolean Status) {
        this.ComboID = ComboID;
        this.ComboItem = ComboItem;
        this.Description = Description;
        this.Price = Price;
        this.Quantity = Quantity;
        this.Status = Status;
    }

    public int getComboID() {
        return ComboID;
    }

    public void setComboID(int ComboID) {
        this.ComboID = ComboID;
    }

    public String getComboItem() {
        return ComboItem;
    }

    public void setComboItem(String ComboItem) {
        this.ComboItem = ComboItem;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public float getPrice() {
        return Price;
    }

    public void setPrice(float Price) {
        this.Price = Price;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public boolean isStatus() {
        return Status;
    }

    public void setStatus(boolean Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Combo{" + "ComboID=" + ComboID + ", ComboItem=" + ComboItem + ", Description=" + Description + ", Price=" + Price + ", Quantity=" + Quantity + ", Status=" + Status + '}';
    }
    
    
}