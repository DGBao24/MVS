package entity;

public class Room {
    private int RoomID;
    private int CinemaID;
    private String RoomName;
    private String RoomType;
    private boolean Status;

    public Room(int RoomID, boolean Status) {
        this.RoomID = RoomID;
        this.CinemaID = CinemaID;
        this.RoomName = RoomName;
        this.RoomType = RoomType;
        this.Status = Status;
    }
    
    public Room(int RoomID, int CinemaID, String RoomName, String RoomType, boolean Status) {
        this.RoomID = RoomID;
        this.CinemaID = CinemaID;
        this.RoomName = RoomName;
        this.RoomType = RoomType;
        this.Status = Status;
    }

    public Room(int RoomID, String RoomName, String RoomType) {
        this.RoomID = RoomID;
        this.RoomName = RoomName;
        this.RoomType = RoomType;
    }
    
    public Room(int CinemaID, String RoomName, String RoomType, boolean Status) {
        this.CinemaID = CinemaID;
        this.RoomName = RoomName;
        this.RoomType = RoomType;
        this.Status = Status;
    }

    public Room() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    

    public int getRoomID() {
        return RoomID;
    }

    public void setRoomID(int RoomID) {
        this.RoomID = RoomID;
    }

    public int getCinemaID() {
        return CinemaID;
    }

    public void setCinemaID(int CinemaID) {
        this.CinemaID = CinemaID;
    }

    public String getRoomName() {
        return RoomName;
    }

    public void setRoomName(String RoomName) {
        this.RoomName = RoomName;
    }

    public String getRoomType() {
        return RoomType;
    }

    public void setRoomType(String RoomType) {
        this.RoomType = RoomType;
    }

    public boolean isStatus() {
        return Status;
    }

    public void setStatus(boolean Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Room{" + "RoomID=" + RoomID + ", CinemaID=" + CinemaID + ", RoomName=" + RoomName + ", RoomType=" + RoomType + ", Status=" + Status + '}';
    }

}
