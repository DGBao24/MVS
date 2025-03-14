package entity;

import java.sql.Timestamp;

public class Showtime {
    private int showtimeID;
    private int movieID;
    private int CinemaID;
    private int RoomID;
    private Timestamp startTime;
    private Timestamp endTime;

    // Constructors
    public Showtime(int showtimeID, int movieID, Timestamp startTime, Timestamp endTime) {
        this.showtimeID = showtimeID;
        this.movieID = movieID;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Showtime(int showtimeID, int movieID, int CinemaID, int RoomID, Timestamp startTime, Timestamp endTime) {
        this.showtimeID = showtimeID;
        this.movieID = movieID;
        this.CinemaID = CinemaID;
        this.RoomID = RoomID;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Showtime(int movieID, Timestamp startTime, Timestamp endTime) {
        this.movieID = movieID;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Showtime() {
    }

    

    public int getCinemaID() {
        return CinemaID;
    }

    public void setRoomID(int RoomID) {
        this.RoomID = RoomID;
    }

    public void setCinemaID(int CinemaID) {
        this.CinemaID = CinemaID;
    }

    public int getRoomID() {
        return RoomID;
    }

    // Getters và Setters
    public int getShowtimeID() {
        return showtimeID;
    }

    public void setShowtimeID(int showtimeID) {
        this.showtimeID = showtimeID;
    }

    public int getMovieID() {
        return movieID;
    }

    public void setMovieID(int movieID) {
        this.movieID = movieID;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    @Override
    public String toString() {
        return "Showtime{" + "showtimeID=" + showtimeID + ", movieID=" + movieID + ", CinemaID=" + CinemaID + ", RoomID=" + RoomID + ", startTime=" + startTime + ", endTime=" + endTime + '}';
    }
    
}
