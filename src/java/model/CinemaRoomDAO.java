package model;

import entity.Cinema;
import entity.Room;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;

public class CinemaRoomDAO extends DBConnection {

    public int insertRoom(Room room) {
        int affectedRow = 0;
        String sql = "INSERT INTO [dbo].[CinemaRoom]([CinemaID],[RoomName],[RoomType],[Status]) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, room.getCinemaID());          
            ps.setString(2, room.getRoomName());
            ps.setString(3, room.getRoomType());          
            ps.setBoolean(4, room.isStatus());
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }

    public int updateRoom(Room room) {
        int affectedRow = 0;
        String sql = "UPDATE [dbo].[CinemaRoom] SET [RoomName] = ?, [RoomType] = ? WHERE RoomID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, room.getRoomName());
            ps.setString(2, room.getRoomType());
            
            ps.setInt(3, room.getRoomID());
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }

    public List<Room> getRoomsByCinema(Integer cinemaId) {
        List<Room> list = new ArrayList<>();
        String sql = cinemaId != null ? 
            "SELECT * FROM [dbo].[CinemaRoom] WHERE [CinemaID] = ?" :
            "SELECT * FROM [dbo].[CinemaRoom]";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            if (cinemaId != null) {
                ps.setInt(1, cinemaId);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int RoomID = rs.getInt("RoomID");
                int CinemaID = rs.getInt("CinemaID");
                String RoomName = rs.getString("RoomName");
                String RoomType = rs.getString("RoomType");
                boolean Status = rs.getBoolean("Status");
                Room room = new Room(RoomID, CinemaID, RoomName, RoomType, Status);
                list.add(room);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Room getRoomID(int rid) {
        String sql = "SELECT * FROM [dbo].[CinemaRoom] WHERE RoomID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, rid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int RoomID = rs.getInt("RoomID");
                int CinemaID = rs.getInt("CinemaID");
                String RoomName = rs.getString("RoomName");
                String RoomType = rs.getString("RoomType");
                boolean Status = rs.getBoolean("Status");
                return new Room(RoomID, CinemaID, RoomName, RoomType, Status);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int disableRoom(Room room) {
        int n = 0;
        String sql = "UPDATE [dbo].[CinemaRoom] SET [Status] = ? WHERE RoomID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setBoolean(1, room.isStatus());
            ps.setInt(2, room.getRoomID());
            n = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public List<Cinema> getAllCinemas() {
        List<Cinema> cinemas = new ArrayList<>();
        try {
            String sql = "SELECT [CinemaID], [CinemaName], [Address] FROM [dbo].[Cinema] ORDER BY [CinemaName]";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int cinemaID = rs.getInt("CinemaID");
                String cinemaName = rs.getString("CinemaName");
                String address = rs.getString("Address");
                cinemas.add(new Cinema(cinemaID, cinemaName, address));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, "Error fetching cinemas", ex);
        }
        return cinemas;
    }

    public List<Room> getAllCinemaRooms() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public List<Room> getRoomsByCinemaID(int cinemaID) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    public static void main(String[] args) {
        Room room = new Room(1, "Strin", "VIP");
        CinemaRoomDAO dao = new CinemaRoomDAO();
        int n = dao.updateRoom(room);
        if(n > 0){
            System.out.println("abc");
            
        
        }
    }
}
