/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Combo;
import entity.Seat;
import entity.Showtime;
import entity.Ticket;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author Nhat Anh
 */
public class BookingDAO extends DBConnection {

    public List<Showtime> getShowTimeByMovie(int mid) {
        List<Showtime> listS = new ArrayList<>();
        String sql = "Select * from Showtime where MovieID =?";
        PreparedStatement stm;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, mid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Showtime show = new Showtime();
                show.setShowtimeID(rs.getInt("ShowTimeID"));
                show.setMovieID(rs.getInt("MovieID"));
                show.setCinemaID(rs.getInt("CinemaID"));
                show.setRoomID(rs.getInt("RoomID"));
                show.setStartTime(rs.getTimestamp("StartTime"));
                show.setEndTime(rs.getTimestamp("EndTime"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listS;

    }

    public List<Showtime> getDateByCinema(int mid, int cid) {
        List<Showtime> listS = new ArrayList<>();
        String sql = "Select StartTime from Showtime where MovieID =? And CinemaID=?";
        PreparedStatement stm;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, mid);
            stm.setInt(2, cid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Showtime show = new Showtime();

                show.setStartTime(rs.getTimestamp("StartTime"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listS;

    }

    public List<Showtime> getRoomByDate(int mid, int cid, Timestamp startTime) {
        List<Showtime> listS = new ArrayList<>();
        String sql = "Select * from Showtime where MovieID =? And CinemaID=? And StartTime=?";
        PreparedStatement stm;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, mid);
            stm.setInt(2, cid);
            Timestamp sqlStartTime = new Timestamp(startTime.getTime());

            stm.setTimestamp(3, sqlStartTime);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Showtime show = new Showtime();
                
                show.setRoomID(rs.getInt("RoomID"));
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listS;

    }
    public List<Seat> getSeatByRoom(int rid) {
        List<Seat> listS = new ArrayList<>();
        String sql = "Select * from Seat where RoomID =? And Status like 'Avialable'";
        PreparedStatement stm;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, rid);
           
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Seat seat = new Seat();
                seat.setSeatID(rs.getInt("SeatID"));
                seat.setSeatRow(rs.getString("SeatRow"));
                seat.setSeatNumber(rs.getInt("SeatNumber"));
                seat.setSeatType(rs.getString("SeatType"));
                seat.setRoomID(rs.getInt("RoomID"));
                seat.setStatus(rs.getString("Status"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listS;

    }
    
    public List<Combo> getCombo(String sql) {
        List<Combo> list = new ArrayList<>();
        try {
           Statement statement = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);
            while (rs.next()) {
                int ComboID = rs.getInt(1);
                String ComboItem = rs.getString(2);
                String Description = rs.getString(3);
                float Price = rs.getFloat(4);
                int Quantity = rs.getInt(5);
                boolean Status = rs.getBoolean(6);
                Combo combo = new Combo(ComboID, ComboItem, Description, Price, Quantity, Status);
                list.add(combo);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public Combo getComboByID(String cit){
        String sql = "SELECT * FROM [swp391].[dbo].[Combo] where ComboItem = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cit);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                int row = 1;
                Combo combo = new Combo(rs.getInt(row++), rs.getString(row++), rs.getString(row++), rs.getFloat(row++), rs.getInt(row++), rs.getBoolean(row++));
                return combo;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    
    public int insertTicket(Ticket ticket) {
        int affectedRow = 0;
        String sql = "INSERT INTO [dbo].[Ticket] ([SeatID] ,[ShowTimeID] ,[ComboID]\n" +
"      ) VALUES (? , ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, ticket.getSeatID());
            ps.setInt(2, ticket.getShowTimeID());
            ps.setInt(3, ticket.getComboID());
            affectedRow = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }
    
    public int insertTicketWithOutCombo(Ticket ticket) {
        int affectedRow = 0;
        String sql = "INSERT INTO [dbo].[Ticket] ([SeatID] ,[ShowTimeID] \n" +
"      ) VALUES (? , ? )";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, ticket.getSeatID());
            ps.setInt(2, ticket.getShowTimeID());
            
            affectedRow = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }
    
    public static void main(String[] args) {
        BookingDAO dao = new BookingDAO();
        List<Showtime> list = dao.getShowTimeByMovie(1);
        for(Showtime time : list){
            System.out.println(time);
        }
    }
}
