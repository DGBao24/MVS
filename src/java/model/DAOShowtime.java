package model;

import entity.Showtime;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOShowtime extends DBConnection {
    
    public int insertShowtime(Showtime showtime) {
        int affectedRow = 0;
        String sql = "INSERT INTO Showtime (MovieID, StartTime, EndTime) VALUES (?, ?, ?)";
        try {
            System.out.println("Executing query: " + sql);  // Debug log
            if (conn == null || conn.isClosed()) {
                System.out.println("Database connection is null or closed. Reconnecting...");

            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, showtime.getMovieID());
            ps.setString(2, showtime.getStartTime());
            ps.setString(3, showtime.getEndTime());
            affectedRow = ps.executeUpdate();
            System.out.println("Affected rows: " + affectedRow);  // Debug log
        } catch (SQLException ex) {
            System.out.println("Error executing query: " + ex.getMessage());  // Debug log
            Logger.getLogger(DAOShowtime.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }
    
    public int updateShowtime(Showtime showtime) {
        int affectedRow = 0;
        String sql = "UPDATE Showtime SET MovieID = ?, StartTime = ?, EndTime = ? WHERE ShowtimeID = ?";
        try {
            System.out.println("Executing query: " + sql);  // Debug log
            if (conn == null || conn.isClosed()) {
                System.out.println("Database connection is null or closed. Reconnecting...");
                
            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, showtime.getMovieID());
            ps.setString(2, showtime.getStartTime());
            ps.setString(3, showtime.getEndTime());
            ps.setInt(4, showtime.getShowtimeID());
            affectedRow = ps.executeUpdate();
            System.out.println("Affected rows: " + affectedRow);  // Debug log
        } catch (SQLException ex) {
            System.out.println("Error executing query: " + ex.getMessage());  // Debug log
            Logger.getLogger(DAOShowtime.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }
    
    public int deleteShowtime(int id) {
        int affectedRow = 0;
        String sql = "DELETE FROM Showtime WHERE ShowtimeID = ?";
        try {
            System.out.println("Executing query: " + sql);  // Debug log
            if (conn == null || conn.isClosed()) {
                System.out.println("Database connection is null or closed. Reconnecting...");
               
            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            affectedRow = ps.executeUpdate();
            System.out.println("Affected rows: " + affectedRow);  // Debug log
        } catch (SQLException ex) {
            System.out.println("Error executing query: " + ex.getMessage());  // Debug log
            Logger.getLogger(DAOShowtime.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }
    
    public List<Showtime> getAllShowtimes() {
        List<Showtime> list = new ArrayList<>();
        String sql = "SELECT * FROM Showtime";
        try {
            System.out.println("Executing query: " + sql);  // Debug log
            if (conn == null || conn.isClosed()) {
                System.out.println("Database connection is null or closed. Reconnecting...");
                
            }
            Statement statement = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);
            while (rs.next()) {
                int row = 1;
                Showtime showtime = new Showtime(
                        rs.getInt(row++), 
                        rs.getInt(row++), 
                        rs.getString(row++), 
                        rs.getString(row++)
                );
                list.add(showtime);
                System.out.println("Added showtime: ID=" + showtime.getShowtimeID() + ", MovieID=" + showtime.getMovieID());  // Debug log
            }
            System.out.println("Total showtimes found: " + list.size());  // Debug log
        } catch (SQLException ex) {
            System.out.println("Error executing query: " + ex.getMessage());  // Debug log
            Logger.getLogger(DAOShowtime.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public Showtime getShowtimeByID(int id) {
        String sql = "SELECT * FROM Showtime WHERE ShowtimeID = ?";
        try {
            System.out.println("Executing query: " + sql);  // Debug log
            if (conn == null || conn.isClosed()) {
                System.out.println("Database connection is null or closed. Reconnecting...");
                
            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int row = 1;
                Showtime showtime = new Showtime(
                        rs.getInt(row++), 
                        rs.getInt(row++), 
                        rs.getString(row++), 
                        rs.getString(row++)
                );
                System.out.println("Found showtime: ID=" + showtime.getShowtimeID() + ", MovieID=" + showtime.getMovieID());  // Debug log
                return showtime;
            }
        } catch (SQLException ex) {
            System.out.println("Error executing query: " + ex.getMessage());  // Debug log
            Logger.getLogger(DAOShowtime.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}