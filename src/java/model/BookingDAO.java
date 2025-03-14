/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Combo;
import entity.Movie;
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
                listS.add(show);
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listS;

    }
    
    public Showtime getShowTimeByID(int stid) {
        
        String sql = "Select * from Showtime where ShowtimeID =?";
        PreparedStatement stm;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, stid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                    Showtime show = new Showtime(
               rs.getInt("ShowTimeID"),
                rs.getInt("MovieID"),
               rs.getInt("CinemaID"),
                rs.getInt("RoomID"),
                rs.getTimestamp("StartTime"),
                rs.getTimestamp("EndTime")
                );
                return show;    
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }
    
    public Movie getMovieById(int id) {
        Movie movie = null;
        try {
             String sql = "SELECT m.MovieID,m.MovieName,m.Duration,m.Genre,m.Director,m.ReleaseDate\n" +
"      ,m.Description,m.Rate,i.ImagePath,m.TrailerURL,m.BasePrice,m.Status\n" +
"  FROM [dbo].[Movie] m join Image i on m.MoviePoster = i.ImageID WHERE MovieID = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                movie = new Movie(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getDate(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getInt(11),
                        rs.getString(12));
            }
        } catch (Exception ex) {
            Logger.getLogger(model.MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return movie;
    }

    public List<Showtime> getDateByCinema(int mid, int cid) {
        List<Showtime> listS = new ArrayList<>();
        String sql = "Select * from Showtime where MovieID =? And CinemaID=?";
        PreparedStatement stm;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, mid);
            stm.setInt(2, cid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Showtime show = new Showtime();

                show.setShowtimeID(rs.getInt("ShowTimeID"));
                show.setMovieID(rs.getInt("MovieID"));
                show.setCinemaID(rs.getInt("CinemaID"));
                show.setRoomID(rs.getInt("RoomID"));
                show.setStartTime(rs.getTimestamp("StartTime"));
                show.setEndTime(rs.getTimestamp("EndTime"));
                listS.add(show);
                listS.add(show);
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
                listS.add(show);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listS;

    }

    public List<Seat> getSeatByRoom(int rid) {
        List<Seat> listS = new ArrayList<>();
        String sql = "Select * from Seat where RoomID =? And Status like 'Available'";
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
                listS.add(seat);
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

    public Combo getComboByID(String cit) {
        String sql = "SELECT * FROM [swp391].[dbo].[Combo] where ComboItem = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cit);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
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
        int ticketID = -1;
        String sql = "INSERT INTO Ticket (SeatID, ShowtimeID, ComboID, Status) VALUES (?, ?, ?, 0)";

        try ( PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, ticket.getSeatID());
            ps.setInt(2, ticket.getShowTimeID());
            ps.setInt(3, ticket.getComboID());
            int affectedRows = ps.executeUpdate();

            // Lấy ID của vé vừa được thêm vào
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    ticketID = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ticketID;
    }

    public int insertTicketWithOutCombo(Ticket ticket) {
    int ticketID = -1;
    String sql = "INSERT INTO Ticket (SeatID, ShowtimeID, Status) VALUES (?, ?, 0)";

    try (
         PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
        
        ps.setInt(1, ticket.getSeatID());
        ps.setInt(2, ticket.getShowTimeID());
        int affectedRows = ps.executeUpdate();

        // Lấy ID của vé vừa được thêm vào
        if (affectedRows > 0) {
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                ticketID = rs.getInt(1);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return ticketID;
}


    public static void main(String[] args) {
        BookingDAO dao = new BookingDAO();
        List<Seat> list = dao.getSeatByRoom(1);
        for (Seat time : list) {
            System.out.println(time);
        }
    }
}
