/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Combo;
import entity.Movie;
import entity.Order;
import entity.OrderCombo;
import entity.Promotion;
import entity.Room;
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
            String sql = "SELECT m.MovieID,m.MovieName,m.Duration,m.Genre,m.Director,m.ReleaseDate\n"
                    + "      ,m.Description,m.Rate,i.ImagePath,m.TrailerURL,m.BasePrice,m.Status\n"
                    + "  FROM [dbo].[Movie] m join Image i on m.MoviePoster = i.ImageID WHERE MovieID = ?";
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
        String sql = "INSERT INTO Ticket (SeatID, ShowtimeID, OrderID, Status) VALUES (?, ?, ?, 0)";

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, ticket.getSeatID());
            ps.setInt(2, ticket.getShowTimeID());
            ps.setInt(3, ticket.getOrderID());
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

    public Seat getSeatByID(int sid) {

        String sql = "Select * from Seat where SeatID =? ";
        PreparedStatement stm;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, sid);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Seat seat = new Seat(
                        rs.getInt("SeatID"),
                        rs.getString("SeatRow"),
                        rs.getInt("SeatNumber"),
                        rs.getString("SeatType"),
                        rs.getInt("RoomID"),
                        rs.getString("Status")
                );
                return seat;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public List<Room> getRoomByCinema(int mid) {
        List<Room> listS = new ArrayList<>();
        String sql = "Select * from Room where CinemaID = ?";
        PreparedStatement stm;
        try {
            stm = conn.prepareStatement(sql);
            stm.setInt(1, mid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Room show = new Room();
                show.setRoomID(rs.getInt("RoomID"));
                show.setCinemaID(rs.getInt("CinemaID"));
                show.setRoomName(rs.getString("RoomName"));
                show.setRoomType(rs.getString("RoomType"));
                show.setStatus(rs.getBoolean("Status"));
                listS.add(show);
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listS;

    }

    public int updateSeatBooking(int sid) {
        Seat seat = getSeatByID(sid);
        int affectedRow = 0;
        String sql = "UPDATE [dbo].[Seat] SET [Status] = 'Processing' WHERE SeatID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, seat.getSeatID());
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }

    public int updateSeatPayment(int sid) {
        Seat seat = getSeatByID(sid);
        int affectedRow = 0;
        String sql = "UPDATE [dbo].[Seat] SET [Status] = 'Booked' WHERE SeatID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, seat.getSeatID());
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }

    public int updateSeatEndTime(int sid) {
        Seat seat = getSeatByID(sid);
        int affectedRow = 0;
        String sql = "UPDATE [dbo].[Seat] SET [Status] = 'Available' WHERE SeatID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, seat.getSeatID());
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }

    public List<Integer> getLastInsertedTickets(int count) {
        List<Integer> ticketIDs = new ArrayList<>();
        String sql = "SELECT TOP " + count + " TicketID FROM Ticket ORDER BY TicketID DESC";

        try {
            ResultSet rs = getData(sql);
            while (rs.next()) {
                ticketIDs.add(rs.getInt("TicketID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ticketIDs;
    }

    public Combo getComboByID(int cid) {
        String sql = "SELECT [ComboID],[ComboItem],[Description],[Price],[Quantity],[Status] FROM [swp391].[dbo].[Combo] where ComboID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cid);
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

    public boolean decrementPromotionRedemption(int promotionId) {
        String sql = "UPDATE [dbo].[Promotion] SET [RemainRedemption] = [RemainRedemption] - 1 "
                + "WHERE [PromotionID] = ? AND [RemainRedemption] > 0 AND [Status] = 1";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, promotionId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public Promotion validatePromotion(String promoCode) {
        String sql = "SELECT * FROM [dbo].[Promotion] "
                + "WHERE [PromoCode] = ? AND [Status] = 1 "
                + "AND [StartDate] <= GETDATE() AND [EndTime] >= GETDATE() "
                + "AND [RemainRedemption] > 0";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, promoCode);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Promotion promotion = new Promotion();
                promotion.setPromotionID(rs.getInt("PromotionID"));
                promotion.setPromoCode(rs.getString("PromoCode"));
                promotion.setDiscountPercent(rs.getInt("DiscountPercent"));
                promotion.setStartDate(rs.getDate("StartDate"));
                promotion.setEndDate(rs.getDate("EndTime"));
                promotion.setStatus(rs.getBoolean("Status"));
                promotion.setDescription(rs.getString("Description"));
                promotion.setRemainRedemption(rs.getInt("RemainRedemption"));

                return promotion;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }


    public int insertOrder(int accountId, Timestamp orderDate, String status) {
        int orderId = -1;
        String sql = "INSERT INTO [dbo].[Order] (AccountID, OrderDate,TotalAmount,SeatQuantity,  Status) "
                + "VALUES (?, ?,0,0,?)";

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, accountId);
            ps.setTimestamp(2, orderDate);


            ps.setString(3, status);

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderId;
    }

    public void insertOrderCombo(int orderID, int comboID,int quantity,double price) {
        String sql = "INSERT INTO OrderCombo (OrderID, ComboID,Quantity,Price) VALUES (?, ?,?,?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderID);
            ps.setInt(2, comboID);
            ps.setInt(3, quantity);
            ps.setDouble(4, price);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public int updateOrderCombo(int OrderComboID,int OrderID,int ComboID,int Quantity,double price) {
        String sql = "UPDATE OrderCombo SET OrderID=?, ComboID=?,Quantity=?,Price=? Where OrderComboID= ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1,OrderID);
            ps.setInt(2, OrderID);
            
            ps.setInt(3, Quantity);
            ps.setDouble(4, price);
            ps.setInt(5, OrderComboID);

            return ps.executeUpdate (); // Trả về số dòng bị ảnh hưởng

        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Trả về -1 nếu có lỗi
        }
    }

    public Order getLatestOrder() {
        Order order = null;
        String sql = "SELECT TOP 1 * FROM [dbo].[Order] ORDER BY OrderID DESC";

        try (
                PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                order = new Order();
                order.setOrderID(rs.getInt("OrderID"));
                order.setAccountID(rs.getInt("AccountID"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setTotalAmount(rs.getFloat("TotalAmount"));
                order.setSeatQuantity(rs.getInt("SeatQuantity"));
                order.setComboQuantity(rs.getInt("ComboQuantity"));
                order.setPromotionID(rs.getInt("PromotionID"));

                order.setStatus(rs.getString("Status"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        }
        return order;
    }
    
    public OrderCombo getLatestOrderCombo() {
        OrderCombo order = null;
        String sql = "SELECT TOP 1 * FROM [dbo].[OrderCombo] ORDER BY OrderComboID DESC";

        try (
                PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                order = new OrderCombo();
                order.setOrderComboID(rs.getInt("OrderComboID"));
                order.setOrderID(rs.getInt("OrderID"));
                order.setComboID(rs.getInt("ComboID"));
                order.setQuantity(rs.getInt("Quantity"));
                order.setPrice(rs.getFloat("Price"));
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
            
        }
        return order;
    }

    public int getShowtimeID(int movieID, int cinemaID, int roomID, Timestamp startTime) {
        String sql = "SELECT ShowTimeID FROM ShowTime WHERE MovieID = ? AND CinemaID = ? AND RoomID = ? AND StartTime = ?";
        try {
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, movieID);
            stm.setInt(2, cinemaID);
            stm.setInt(3, roomID);
            stm.setTimestamp(4, startTime);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("ShowTimeID");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    

        

    public int updateComboAndPromotion(int orderId, double totalAmount, int seatQuantity,int comboQuantity, int promotionId) {
        String sql = "UPDATE [dbo].[Order] " +
                     "SET ToTalAmount = ?, SeatQuantity = ?, ComboQuantity = ?, PromotionID = ? " +
                     "WHERE OrderID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, totalAmount);
            ps.setInt(2, seatQuantity);
            ps.setInt(3, comboQuantity);
            ps.setInt(4, promotionId);
            ps.setInt(5, orderId);

            return ps.executeUpdate(); // Trả về số dòng bị ảnh hưởng
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Trả về -1 nếu có lỗi
        }
    }
    
    public int updateComboOrder(int orderId, double totalAmount, int seatQuantity,int comboQuantity) {
        String sql = "UPDATE [dbo].[Order] " +
                     "SET ToTalAmount = ?, SeatQuantity = ?, ComboQuantity = ? " +
                     "WHERE OrderID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, totalAmount);
            ps.setInt(2, seatQuantity);
            ps.setInt(3, comboQuantity);
           
            ps.setInt(4, orderId);

            return ps.executeUpdate(); // Trả về số dòng bị ảnh hưởng
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Trả về -1 nếu có lỗi
        }
    }
    
    public int updatePromotionOrder(int orderId, double totalAmount, int seatQuantity, int promotionId) {
        String sql = "UPDATE [dbo].[Order] " +
                     "SET ToTalAmount = ?, SeatQuantity = ?, PromotionID = ? " +
                     "WHERE OrderID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, totalAmount);
            ps.setInt(2, seatQuantity);
            
            ps.setInt(3, promotionId);
            ps.setInt(4, orderId);

            return ps.executeUpdate(); // Trả về số dòng bị ảnh hưởng
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Trả về -1 nếu có lỗi
        }
    }
    

    public int updateOrderPrice(int orderId, double totalAmount) {
        String sql = "UPDATE [dbo].[Order] " +
                     "SET ToTalAmount = ? " +
                     "WHERE OrderID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, totalAmount);
            ps.setInt(2, orderId);

            return ps.executeUpdate(); // Trả về số dòng bị ảnh hưởng
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Trả về -1 nếu có lỗi
        }
    }
    

    public boolean checkOrderComboExists(int orderID) {
    String query = "SELECT COUNT(*) FROM OrderCombo WHERE OrderID = ?";
    try (
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, orderID);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

      public boolean updateOrderStatus(Order order) {
        String sql = "UPDATE [dbo].[Order]\n"
                + "   SET [Status] = ?\n"
                + " WHERE OrderID = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, order.getStatus());
            st.setInt(2, order.getOrderID());
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
           ex.printStackTrace();
        }
        return false;
    }
      
    public void deleteTicket(int oid){
        String sql = "Delete Ticket where OrderID = " + oid;
        Statement state;
        try {
            state = conn.createStatement();
        state.execute(sql);
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }  
      
    public void deleteOrderCombo(int oid){
        String sql = "Delete OrderCombo where OrderID = " + oid;
        Statement state;
        try {
            state = conn.createStatement();
        state.execute(sql);
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }  
    

    
    public static void main(String[] args) {
        BookingDAO dao = new BookingDAO();
        String StartTime = "2025-03-23 00:00:00.000";
        Timestamp orderDate = Timestamp.valueOf(StartTime);
//        List<Seat> list = dao.getSeatByRoom(1);
//        for (Seat time : list) {
//            System.out.println(time);
//        }

        Ticket ticket = new Ticket(2, 1, 8);
        int n = dao.insertTicket(ticket);
//        int n = dao.getShowtimeID(1, 1, 1, orderDate);
//        if(n>0){
//            System.out.println(n);
//        }
//    Order order = dao.getLatestOrder();
//        System.out.println(order);
    }

}
