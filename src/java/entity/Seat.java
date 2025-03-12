package entity;

public class Seat {
    private int seatID;
    private String seatRow;
    private int seatNumber;
    private String seatType;
    private int roomID;
    private String status;

    public Seat() {
    }

    public Seat(int seatID, String seatType, String status) {
        this.seatID = seatID;
        this.seatType = seatType;
        this.status = status;
    }

    public Seat(String seatRow, int seatNumber, String seatType, int roomID, String status) {
        this.seatRow = seatRow;
        this.seatNumber = seatNumber;
        this.seatType = seatType;
        this.roomID = roomID;
        this.status = status;
    }

    public Seat(int seatID, String seatRow, int seatNumber, String seatType, int roomID, String status) {
        this.seatID = seatID;
        this.seatRow = seatRow;
        this.seatNumber = seatNumber;
        this.seatType = seatType;
        this.roomID = roomID;
        this.status = status;
    }

    public int getSeatID() {
        return seatID;
    }

    public void setSeatID(int seatID) {
        this.seatID = seatID;
    }

    public String getSeatRow() {
        return seatRow;
    }

    public void setSeatRow(String seatRow) {
        this.seatRow = seatRow;
    }

    public int getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(int seatNumber) {
        this.seatNumber = seatNumber;
    }

    public String getSeatType() {
        return seatType;
    }

    public void setSeatType(String seatType) {
        this.seatType = seatType;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Seat{" + "seatID=" + seatID + ", seatRow=" + seatRow + ", seatNumber=" + seatNumber + ", seatType=" + seatType + ", roomID=" + roomID + ", status=" + status + '}';
    }
    
}
