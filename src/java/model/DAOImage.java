/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nhat Anh
 */

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;
import java.sql.Statement;

public class DAOImage extends DBConnection {

    public int saveImage(String imagePath) {
        String sql = "INSERT INTO Image (ImagePath, ImageType) VALUES (?, 'Avatar')";
        try (PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, imagePath);
            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                // Lấy ID ảnh mới thêm vào
                try (var rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Trả về ID của ảnh vừa lưu
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Trả về -1 nếu lưu ảnh thất bại
    }

    public String getImagePathById(int imageId) {
        String imagePath = null;
        String sql = "SELECT ImagePath FROM Image WHERE ImageID = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, imageId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                imagePath = rs.getString("ImagePath");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOAccount.class.getName()).log(Level.SEVERE, "Lỗi khi lấy đường dẫn hình ảnh: " + ex.getMessage(), ex);
        }
        
        return imagePath;
    }

    public int saveMovieImage(String imagePath) {
        int imageId = -1;
        try {
            String sql = "INSERT INTO Image (ImagePath, ImageType) VALUES (?, 'Poster')";
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, imagePath);
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    imageId = rs.getInt(1);
                }
                rs.close();
            }
            ps.close();
        } catch (SQLException ex) {
            System.out.println("Error saving image: " + ex.getMessage());
            ex.printStackTrace();
        }
        return imageId;
    }

    public int saveBlogImage(String imagePath) {
        int imageId = -1;
        try {
            String sql = "INSERT INTO Image (ImagePath, ImageType) VALUES (?, 'Blog')";
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, imagePath);
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    imageId = rs.getInt(1);
                }
                rs.close();
            }
            ps.close();
        } catch (SQLException ex) {
            System.out.println("Error saving blog image: " + ex.getMessage());
            ex.printStackTrace();
        }
        return imageId;
    }
    
    public static void main(String[] args) {
        DAOImage dao = new DAOImage();
        String n = dao.getImagePathById(7);
        System.out.println(n);
    }

    public void deleteImage(int blogPoster) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
