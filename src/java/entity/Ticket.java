/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.security.Timestamp;

/**
 *
 * @author Nhat Anh
 */
public class Ticket {
    private int TicketID;
    private int SeatID;
    private int ShowTimeID;
    private int ComboID;
    private boolean Status;

    public Ticket() {
    }

    public Ticket(int SeatID, int ShowTimeID) {
        this.SeatID = SeatID;
        this.ShowTimeID = ShowTimeID;
    }

    public Ticket(int SeatID, int ShowTimeID, int ComboID) {
        this.SeatID = SeatID;
        this.ShowTimeID = ShowTimeID;
        this.ComboID = ComboID;
    }

    public Ticket(int TicketID, int SeatID, int ShowTimeID, int ComboID, boolean Status) {
        this.TicketID = TicketID;
        this.SeatID = SeatID;
        this.ShowTimeID = ShowTimeID;
        this.ComboID = ComboID;
        this.Status = Status;
    }

    public void setTicketID(int TicketID) {
        this.TicketID = TicketID;
    }

    public void setSeatID(int SeatID) {
        this.SeatID = SeatID;
    }

    public void setShowTimeID(int ShowTimeID) {
        this.ShowTimeID = ShowTimeID;
    }

    public void setComboID(int ComboID) {
        this.ComboID = ComboID;
    }

    public void setStatus(boolean Status) {
        this.Status = Status;
    }

    public int getTicketID() {
        return TicketID;
    }

    public int getSeatID() {
        return SeatID;
    }

    public int getShowTimeID() {
        return ShowTimeID;
    }

    public int getComboID() {
        return ComboID;
    }

    public boolean isStatus() {
        return Status;
    }

    @Override
    public String toString() {
        return "Ticket{" + "TicketID=" + TicketID + ", SeatID=" + SeatID + ", ShowTimeID=" + ShowTimeID + ", ComboID=" + ComboID + ", Status=" + Status + '}';
    }
    
    
    
    
    
}
