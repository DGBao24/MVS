    package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import entity.Cinema;

public class CinemaDAO extends DBConnection {
    
    public List<Cinema> getAllCinemas() {
        List<Cinema> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Cinema";
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cinema cinema = new Cinema();
                cinema.setCinemaID(rs.getInt("CinemaID"));
                cinema.setCinemaName(rs.getString("CinemaName"));
                cinema.setAddress(rs.getString("Address"));
                list.add(cinema);
            }
        } catch (Exception ex) {
            Logger.getLogger(CinemaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public boolean isCinemaExists(String name, String address) {
        try {
            String sql = "SELECT COUNT(*) FROM Cinema WHERE CinemaName = ? OR Address = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, name);
            stm.setString(2, address);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception ex) {
            Logger.getLogger(CinemaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean insertCinema(Cinema cinema) {
        if (isCinemaExists(cinema.getCinemaName(), cinema.getAddress())) {
            return false;
        }
        try {
            String sql = "INSERT INTO Cinema (CinemaName, Address) VALUES (?, ?)";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, cinema.getCinemaName());
            stm.setString(2, cinema.getAddress());
            return stm.executeUpdate() > 0;
        } catch (Exception ex) {
            Logger.getLogger(CinemaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    public int updateCinema(Cinema cinema) {
         try {
            String sql = "UPDATE Cinema SET CinemaName = ?, Address = ? WHERE CinemaID = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, cinema.getCinemaName());
            stm.setString(2, cinema.getAddress());
            stm.setInt(3, cinema.getCinemaID());
            return stm.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    
    }

    public List<Cinema> searchCinemasByName(String name) {
        List<Cinema> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Cinema WHERE CinemaName LIKE ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, "%" + name + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cinema cinema = new Cinema();
                cinema.setCinemaID(rs.getInt("CinemaID"));
                cinema.setCinemaName(rs.getString("CinemaName"));
                cinema.setAddress(rs.getString("Address"));
                list.add(cinema);
            }
        } catch (Exception ex) {
            Logger.getLogger(CinemaDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Cinema getCinemaByID(int cinemaID) {
    Cinema cinema = null;
    try {
        String sql = "SELECT * FROM Cinema WHERE CinemaID = ?";
        PreparedStatement stm = conn.prepareStatement(sql);
        stm.setInt(1, cinemaID);
        ResultSet rs = stm.executeQuery();

        if (rs.next()) {
            cinema = new Cinema();
            cinema.setCinemaID(rs.getInt("CinemaID"));
            cinema.setCinemaName(rs.getString("CinemaName"));
            cinema.setAddress(rs.getString("Address"));
        }
    } catch (Exception ex) {
        Logger.getLogger(CinemaDAO.class.getName()).log(Level.SEVERE, "Error getting cinema by ID", ex);
    }
    return cinema;
}
    public static void main(String[] args) {
        
        CinemaDAO dao = new CinemaDAO();
        List<Cinema> list = dao.getAllCinemas();
    
        for(Cinema cinema : list){
        System.out.println(cinema);
            
        
    }}
    

    public Cinema getCinemaById(int cinemaID) {
        try {
            String sql = "SELECT * FROM Cinema WHERE CinemaID = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, cinemaID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Cinema(
                    rs.getInt("CinemaID"),
                    rs.getString("CinemaName"),
                    rs.getString("Address")
                );
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

}
