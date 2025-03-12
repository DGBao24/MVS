/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;



public class Cinema {
    private int cinemaID;
    private String cinemaName;
    private String address;

    public Cinema() {}

    public Cinema(int cinemaID, String cinemaName, String address) {
        this.cinemaID = cinemaID;
        this.cinemaName = cinemaName;
        this.address = address;
    }

    public Cinema(int cinemaID, String cinemaName) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public int getCinemaID() {
        return cinemaID;
    }

    public void setCinemaID(int cinemaID) {
        this.cinemaID = cinemaID;
    }

    public String getCinemaName() {
        return cinemaName;
    }

    public void setCinemaName(String cinemaName) {
        this.cinemaName = cinemaName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Cinema{" + "cinemaID=" + cinemaID + ", cinemaName=" + cinemaName + ", address=" + address + '}';
    }
}
