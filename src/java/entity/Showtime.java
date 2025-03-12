package entity;

import java.sql.Timestamp;

public class Showtime {
    private int showtimeID;
    private int movieID;
    private String startTime;
    private String endTime;

    // Constructors
    public Showtime(int showtimeID, int movieID, String startTime, String endTime) {
        this.showtimeID = showtimeID;
        this.movieID = movieID;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Showtime(int movieID, String startTime, String endTime) {
        this.movieID = movieID;
        this.startTime = startTime;
        this.endTime = endTime;
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

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
}
