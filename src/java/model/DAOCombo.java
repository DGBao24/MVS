/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


import entity.Combo;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author pdatt
 */
public class DAOCombo extends DBConnection{
     public int insertCombo(Combo combo) {
        int affectedRow = 0;
        String sql = "INSERT INTO [dbo].[Combo] ([ComboItem] ,[Description] ,[Price] ,[Quantity]\n" +
"      ,[Status]) VALUES (? , ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, combo.getComboItem());
            ps.setString(2, combo.getDescription());
            ps.setFloat(3, combo.getPrice());
            ps.setInt(4, combo.getQuantity());
            ps.setBoolean(5, combo.isStatus());
            affectedRow = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }

    public int updateCombo(Combo combo) {
        int affectedRow = 0;
        String sql = "UPDATE [dbo].[Combo] SET [ComboItem] = ?,[Description] = ?,[Price] = ?,[Quantity] = ?,[Status] = ? WHERE ComboID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
           ps.setString(1, combo.getComboItem());
            ps.setString(2, combo.getDescription());
            ps.setFloat(3, combo.getPrice());
            ps.setInt(4, combo.getQuantity());
            ps.setBoolean(5, combo.isStatus());
            ps.setInt(6, combo.getComboID());
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }

    public int deleteCombo(int comboID) {
        int affectedRow = 0;
        String sql = "DELETE FROM [dbo].[Combo]\n" +
"      WHERE ComboID = " + comboID;
        try {
            Statement statement = conn.createStatement();
            affectedRow = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
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
    
    public Combo getComboByID(int cid){
        String sql = "SELECT [ComboID],[ComboItem],[Description],[Price],[Quantity],[Status] FROM [swp391].[dbo].[Combo] where ComboID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cid);
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
    
}
