package model;

import entity.Showtime;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOShowtime extends DBConnection {
    
    public int insertShowtime(Showtime showtime) {
    int affectedRow = 0;
    String sql = "INSERT INTO Showtime (MovieID, StartTime, EndTime) VALUES (?, ?, ?)";
    try {
        if (conn == null || conn.isClosed()) {
            connect();
        }
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, showtime.getMovieID());
        ps.setTimestamp(2, showtime.getStartTime());
        ps.setTimestamp(3, showtime.getEndTime());
        affectedRow = ps.executeUpdate();
    } catch (SQLException ex) {
        Logger.getLogger(DAOShowtime.class.getName()).log(Level.SEVERE, null, ex);
    }
    return affectedRow;
}

    
    public int updateShowtime(Showtime showtime) {
    int affectedRow = 0;
    String sql = "UPDATE Showtime SET MovieID = ?, StartTime = ?, EndTime = ? WHERE ShowtimeID = ?";
    try {
        if (conn == null || conn.isClosed()) {
            connect();
        }
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, showtime.getMovieID());
        ps.setTimestamp(2, showtime.getStartTime());
        ps.setTimestamp(3, showtime.getEndTime());
        ps.setInt(4, showtime.getShowtimeID());
        affectedRow = ps.executeUpdate();
    } catch (SQLException ex) {
        Logger.getLogger(DAOShowtime.class.getName()).log(Level.SEVERE, null, ex);
    }
    return affectedRow;
}

    
    public int deleteShowtime(int id) {
        int affectedRow = 0;
        String sql = "DELETE FROM Showtime WHERE ShowtimeID = ?";
        try {
            if (conn == null || conn.isClosed()) {
                connect();
            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOShowtime.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }
    
    public List<Showtime> getAllShowtimes() {
        List<Showtime> list = new ArrayList<>();
        String sql = "SELECT * FROM Showtime";
        try {
            if (conn == null || conn.isClosed()) {
                connect();
            }
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            while (rs.next()) {
                Showtime showtime = new Showtime(
                        rs.getInt("ShowtimeID"), 
                        rs.getInt("MovieID"), 
                        rs.getTimestamp("StartTime"), 
                        rs.getTimestamp("EndTime")
                );
                list.add(showtime);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOShowtime.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public Showtime getShowtimeByID(int id) {
        String sql = "SELECT * FROM Showtime WHERE ShowtimeID = ?";
        try {
            if (conn == null || conn.isClosed()) {
                connect();
            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Showtime(
                        rs.getInt("ShowtimeID"), 
                        rs.getInt("MovieID"), 
                        rs.getTimestamp("StartTime"), 
                        rs.getTimestamp("EndTime")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOShowtime.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    private void connect() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
