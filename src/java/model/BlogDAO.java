/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Blog;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.DBConnection;

/**
 *
 * @author jun
 */
public class BlogDAO {
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    
    public BlogDAO() {
        DBConnection db = new DBConnection();
        conn = db.conn;
    }
    
    public List<Blog> getAllBlogs() {
        List<Blog> list = new ArrayList<>();
        String query = "SELECT * FROM Blog";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Blog(
                        rs.getInt("BlogID"),
                        rs.getString("Title"),
                        rs.getDate("ReleaseDate"),
                        rs.getString("Description"),
                        rs.getInt("BlogPoster"),
                        rs.getString("Status")
                ));
            }
            System.out.println("Found " + list.size() + " blogs"); // Debug line
        } catch (SQLException e) {
            System.out.println("Error in getAllBlogs: " + e.getMessage());
            e.printStackTrace(); // Print full stack trace
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.out.println("Error closing: " + e.getMessage());
            }
        }
        return list;
    }
    
    public Blog getBlogById(int blogId) {
        String query = "SELECT * FROM Blog WHERE BlogID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, blogId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Blog(
                    rs.getInt("BlogID"),
                    rs.getString("Title"),
                    rs.getDate("ReleaseDate"),
                    rs.getString("Description"),
                    rs.getInt("BlogPoster"),
                    rs.getString("Status")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in getBlogById: " + e.getMessage());
            e.printStackTrace(); // Print full stack trace
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.out.println("Error closing: " + e.getMessage());
            }
        }
        return null;
    }

    public List<Blog> getActiveBlogs() {
        List<Blog> list = new ArrayList<>();
        String query = "SELECT * FROM Blog WHERE Status = '1' ORDER BY ReleaseDate DESC";
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Blog(
                        rs.getInt("BlogID"),
                        rs.getString("Title"),
                        rs.getDate("ReleaseDate"),
                        rs.getString("Description"),
                        rs.getInt("BlogPoster"),
                        rs.getString("Status")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.out.println("Error closing: " + e.getMessage());
            }
        }
        return list;
    }

    public void insertBlog(Blog blog) {
        String query = "INSERT INTO Blog (Title, ReleaseDate, Description, BlogPoster, Status) VALUES (?, ?, ?, ?, ?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, blog.getTitle());
            ps.setDate(2, blog.getReleaseDate());
            ps.setString(3, blog.getDescription());
            ps.setInt(4, blog.getBlogPoster());
            ps.setString(5, blog.getStatus());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error inserting blog: " + e.getMessage());
            e.printStackTrace(); // Print full stack trace
            throw new RuntimeException("Error inserting blog", e);
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.out.println("Error closing: " + e.getMessage());
            }
        }
    }

    public void updateBlog(Blog blog) {
        String query = "UPDATE Blog SET Title=?, ReleaseDate=?, Description=?, BlogPoster=?, Status=? WHERE BlogID=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, blog.getTitle());
            ps.setDate(2, blog.getReleaseDate());
            ps.setString(3, blog.getDescription());
            ps.setInt(4, blog.getBlogPoster());
            ps.setString(5, blog.getStatus());
            ps.setInt(6, blog.getBlogID());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating blog: " + e.getMessage());
            e.printStackTrace(); // Print full stack trace
            throw new RuntimeException("Error updating blog", e);
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.out.println("Error closing: " + e.getMessage());
            }
        }
    }

    public void deleteBlog(int blogId) {
        String query = "DELETE FROM Blog WHERE BlogID=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, blogId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error deleting blog: " + e.getMessage());
            e.printStackTrace(); // Print full stack trace
            throw new RuntimeException("Error deleting blog", e);
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.out.println("Error closing: " + e.getMessage());
            }
        }
    }
    
    public void updateBlogStatus(int blogId, String status) {
        String query = "UPDATE Blog SET Status=? WHERE BlogID=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, blogId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error updating blog status: " + e.getMessage());
            e.printStackTrace(); // Print full stack trace
            throw new RuntimeException("Error updating blog status", e);
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.out.println("Error closing: " + e.getMessage());
            }
        }
    }
}
