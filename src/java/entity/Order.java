/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Timestamp;

/**
 *
 * @author Nhat Anh
 */
public class Order {
   
                
    private int OrderID;
    private int AccountID;
    private Timestamp OrderDate;
    private float TotalAmount;
    private int SeatQuantity;
    private int ComboQuantity;
    private int PromotionID;
    private String Status;
    

    public Order(int OrderID, int AccountID, Timestamp OrderDate, float TotalAmount, int SeatQuantity, int ComboQuantity, int PromotionID, String Status) {

        this.OrderID = OrderID;
        this.AccountID = AccountID;
        this.OrderDate = OrderDate;
        this.TotalAmount = TotalAmount;
        this.SeatQuantity = SeatQuantity;
        this.ComboQuantity = ComboQuantity;
        this.PromotionID = PromotionID;
        this.Status = Status;
    }


    public Order(int AccountID, Timestamp OrderDate, float TotalAmount, int SeatQuantity, String Status) {

        this.AccountID = AccountID;
        this.OrderDate = OrderDate;
        this.TotalAmount = TotalAmount;
        this.SeatQuantity = SeatQuantity;
        this.Status = Status;
    }

    public Order() {
       
    }

    public int getOrderID() {
        return OrderID;
    }

    public int getAccountID() {
        return AccountID;
    }

    public Timestamp getOrderDate() {
        return OrderDate;
    }

    public float getTotalAmount() {
        return TotalAmount;
    }

    public int getSeatQuantity() {
        return SeatQuantity;
    }

    public int getComboQuantity() {
        return ComboQuantity;
    }

    public int getPromotionID() {
        return PromotionID;
    }


    public String getStatus() {
        return Status;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }

    public void setOrderDate(Timestamp OrderDate) {
        this.OrderDate = OrderDate;
    }

    public void setTotalAmount(float TotalAmount) {
        this.TotalAmount = TotalAmount;
    }

    public void setSeatQuantity(int SeatQuantity) {
        this.SeatQuantity = SeatQuantity;
    }

    public void setComboQuantity(int ComboQuantity) {
        this.ComboQuantity = ComboQuantity;
    }

    public void setPromotionID(int PromotionID) {
        this.PromotionID = PromotionID;
    }


    public void setStatus(String Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Order{" + "OrderID=" + OrderID + ", AccountID=" + AccountID + ", OrderDate=" + OrderDate + ", TotalAmount=" + TotalAmount + ", SeatQuantity=" + SeatQuantity + ", ComboQuantity=" + ComboQuantity + ", PromotionID=" + PromotionID + ", Status=" + Status + '}';
    }
            

    
                
}
