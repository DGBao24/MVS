package model;

import entity.Seat;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SeatDAO extends DBConnection{
    
    

    
    public List<Seat> getSeatsByRoom(int roomID) {
        List<Seat> seats = new ArrayList<>();
        String query = "SELECT * FROM Seat WHERE RoomID = ? ORDER BY SeatRow, SeatNumber";
        

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, roomID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                seats.add(new Seat(
                    rs.getInt("SeatID"),
                    rs.getString("SeatRow"),
                    rs.getInt("SeatNumber"),
                    rs.getString("SeatType"),
                    rs.getInt("RoomID"),
                    rs.getString("Status")
                ));
            }
           
        } catch (SQLException e) {
            System.out.println("Error getting seats by room: " + e.getMessage()); // Debug log
            e.printStackTrace();
        }
        return seats;
    }

    public Seat getSeatID(int sid) {
        String sql = "SELECT * FROM [dbo].[Seat] WHERE SeatID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, sid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int SeatID = rs.getInt("SeatID");
                String SeatRow = rs.getString("SeatRow");
                int SeatNumber = rs.getInt("SeatNumber");
                String SeatType = rs.getString("SeatType");
                int RoomID = rs.getInt("RoomID");
                String Status = rs.getString("Status");
                return new Seat(SeatID, SeatRow, SeatNumber, SeatType, RoomID, Status);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int insertSeat(Seat seat) {
        int affectedRow = 0;
        String sql = "INSERT INTO [dbo].[Seat]([SeatRow],[SeatNumber],[SeatType],[RoomID],[Status]) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, seat.getSeatRow());          
            ps.setInt(2, seat.getSeatNumber());
            ps.setString(3, seat.getSeatType());   
            ps.setInt(4, seat.getRoomID());
            ps.setString(5, seat.getStatus());
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }
    
    public int updateSeat(Seat seat) {
        int affectedRow = 0;
        String sql = "UPDATE [dbo].[Seat] SET [SeatType] = ?, [Status] = ? WHERE SeatID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, seat.getSeatType());
            ps.setString(2, seat.getStatus());
            
            ps.setInt(3, seat.getSeatID());
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }
    // Hàm lấy tất cả ghế trong hệ thống
    public List<Seat> getAllSeats() {
        List<Seat> seats = new ArrayList<>();
        String query = "SELECT * FROM Seat ORDER BY RoomID, SeatRow, SeatNumber";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(query)) {

                while (rs.next()) {
                    seats.add(new Seat(
                        rs.getInt("SeatID"),
                        rs.getString("SeatRow"),
                        rs.getInt("SeatNumber"),
                        rs.getString("SeatType"),
                        rs.getInt("RoomID"),
                        rs.getString("Status")
                    ));
                }
                
           
        } catch (Exception e) {
            System.out.println("Error getting all seats: " + e.getMessage()); // Debug log
            e.printStackTrace();
        }
        return seats;
    }

    
    
    public static void main(String[] args) {
        SeatDAO dao = new SeatDAO();
        List<Seat> list = dao.getAllSeats();
        for(Seat seat : list){
            System.out.println(seat);
    }
}
}