/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Promotion;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Statement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author pdatt
 */
public class DAOPromotion extends DBConnection {

    public int insertPromotion(Promotion promotion) {
        int affectedRow = 0;
        String sql = "INSERT INTO [dbo].[Promotion]([PromoCode],[DiscountPercent],[StartDate],[EndTime],[Status],[Description],[RemainRedemption])\n"
                + "     VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, promotion.getPromoCode());
            ps.setInt(2, promotion.getDiscountPercent());
            ps.setDate(3, (Date) promotion.getStartDate());
            ps.setDate(4, (Date) promotion.getEndDate());
            ps.setBoolean(5, promotion.isStatus());
            ps.setString(6, promotion.getDescription());
            ps.setInt(7, promotion.getRemainRedemption());
            affectedRow = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }

    public int updatePromotion(Promotion promotion) {
        int affectedRow = 0;
        String sql = "UPDATE [dbo].[Promotion] SET [PromoCode] = ?,[DiscountPercent] = ?,[StartDate] = ?,[EndTime] = ?,[Status] = ?,[Description] = ? ,[RemainRedemption] = ? WHERE PromotionID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, promotion.getPromoCode());
            ps.setInt(2, promotion.getDiscountPercent());
            ps.setDate(3, (Date) promotion.getStartDate());
            ps.setDate(4, (Date) promotion.getEndDate());
            ps.setBoolean(5, promotion.isStatus());
            ps.setString(6, promotion.getDescription());
            ps.setInt(7, promotion.getRemainRedemption());
            ps.setInt(8, promotion.getPromotionID());
            affectedRow = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }

    public int deletePromotion(int promoID) {
        int affectedRow = 0;
        String sql = "DELETE FROM [dbo].[Promotion]\n"
                + "      WHERE PromotionID = " + promoID;
        try {
            Statement statement = conn.createStatement();
            affectedRow = statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }

    public List<Promotion> getPromotion(String sql) {
        List<Promotion> list = new ArrayList<>();
        Statement statement;
        try {
            statement = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = statement.executeQuery(sql);
            while (rs.next()) {
                int PromotionID = rs.getInt(1);
                String PromoCode = rs.getString(2);
                int DiscountPercent = rs.getInt(3);
                Date StartDate = rs.getDate(4);
                Date EndDate = rs.getDate(5);
                boolean Status = rs.getBoolean(6);
                String Description = rs.getString(7);
                int RemainRedemption = rs.getInt(8);
                Promotion promotion = new Promotion(PromotionID, PromoCode, DiscountPercent, StartDate, EndDate, Status, Description, RemainRedemption);
                list.add(promotion);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public Promotion getPromoByID(int pid){
        String sql = "SELECT [PromotionID],[PromoCode],[DiscountPercent],[StartDate],[EndTime],[Status],[Description],[RemainRedemption] FROM [dbo].[Promotion] where PromotionID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, pid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                int row = 1;
                Promotion promotion = new Promotion(rs.getInt(row++), rs.getString(row++), rs.getInt(row++), rs.getDate(row++), rs.getDate(row++), rs.getBoolean(row++), rs.getString(row++), rs.getInt(row++));
                return promotion;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
     public int disablePromotion(Promotion p){
        int n = 0;
        String sql = "Update Promotion set Status = ? Where PromotionID = ?";
        PreparedStatement ps;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1,(p.isStatus() == true ? 1 : 0));
            ps.setInt(2, p.getPromotionID());   
            n = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOAccount.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    
    public static void main(String[] args) {
        DAOPromotion dao = new DAOPromotion();
      SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
//        try {
//                   try {
//        int n = dao.insertPromotion(new Promotion("NEWYEAR", 15, new Date(sdf.parse("2-3-2025").getTime()), new Date(sdf.parse("3-3-2025").getTime()), true, "New Year", 20));
//            if (n > 0){
//                System.out.println("added");
//            } else {
//                System.out.println("failed");
//            }
//        } catch (ParseException ex) {
//            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);

//int n = dao.updatePromotion(new Promotion(6, "NEWYEAR", 20, new Date(sdf.parse("4-3-2025").getTime()), new Date(sdf.parse("10-3-2025").getTime()), true, "New Year", 2 ));
// if (n > 0){
//                System.out.println("added");
//            } else {
//                System.out.println("failed");
//            }
//        } catch (ParseException ex) {
//            Logger.getLogger(DAOPromotion.class.getName()).log(Level.SEVERE, null, ex);
//        }
//List<Promotion> list =   dao.getPromotion("select*from Promotion");
//      System.out.println(list);
//    int n = dao.deletePromotion(7);
// int n = dao.disablePromotion(new Promotion(5, true));
    }
}
