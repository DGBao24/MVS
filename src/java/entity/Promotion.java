/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author pdatt
 */
public class Promotion {
    private int PromotionID;
    private String PromoCode;
    private int DiscountPercent;
    private Date StartDate;
    private Date EndDate;
    private boolean Status;
    private String Description;
    private int RemainRedemption;

    public Promotion() {
    }

    public Promotion(int PromotionID, boolean Status) {
        this.PromotionID = PromotionID;
        this.Status = Status;
    }
    

    public Promotion(int PromotionID, String PromoCode, int DiscountPercent, Date StartDate, Date EndDate, boolean Status, String Description, int RemainRedemption) {
        this.PromotionID = PromotionID;
        this.PromoCode = PromoCode;
        this.DiscountPercent = DiscountPercent;
        this.StartDate = StartDate;
        this.EndDate = EndDate;
        this.Status = Status;
        this.Description = Description;
        this.RemainRedemption = RemainRedemption;
    }

    public Promotion(String PromoCode, int DiscountPercent, Date StartDate, Date EndDate, boolean Status, String Description, int RemainRedemption) {
        this.PromoCode = PromoCode;
        this.DiscountPercent = DiscountPercent;
        this.StartDate = StartDate;
        this.EndDate = EndDate;
        this.Status = Status;
        this.Description = Description;
        this.RemainRedemption = RemainRedemption;
    }

    public int getPromotionID() {
        return PromotionID;
    }

    public void setPromotionID(int PromotionID) {
        this.PromotionID = PromotionID;
    }

    public String getPromoCode() {
        return PromoCode;
    }

    public void setPromoCode(String PromoCode) {
        this.PromoCode = PromoCode;
    }

    public int getDiscountPercent() {
        return DiscountPercent;
    }

    public void setDiscountPercent(int DiscountPercent) {
        this.DiscountPercent = DiscountPercent;
    }

    public Date getStartDate() {
        return StartDate;
    }

    public void setStartDate(Date StartDate) {
        this.StartDate = StartDate;
    }

    public Date getEndDate() {
        return EndDate;
    }

    public void setEndDate(Date EndDate) {
        this.EndDate = EndDate;
    }

    public boolean isStatus() {
        return Status;
    }

    public void setStatus(boolean Status) {
        this.Status = Status;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public int getRemainRedemption() {
        return RemainRedemption;
    }

    public void setRemainRedemption(int RemainRedemption) {
        this.RemainRedemption = RemainRedemption;
    }

    @Override
    public String toString() {
        return "Promotion{" + "PromotionID=" + PromotionID + ", PromoCode=" + PromoCode + ", DiscountPercent=" + DiscountPercent + ", StartDate=" + StartDate + ", EndDate=" + EndDate + ", Status=" + Status + ", Description=" + Description + ", RemainRedemption=" + RemainRedemption + '}';
    }
    
}