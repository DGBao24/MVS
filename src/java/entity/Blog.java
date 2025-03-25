/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;

/**
 *
 * @author jun
 */
public class Blog {
    private int BlogID;
    private String Title;
    private Date ReleaseDate;
    private String Description;
    private int BlogPoster;
    private String Status;

    public Blog(int BlogID, String Title, Date ReleaseDate, String Description, int BlogPoster, String Status) {
        this.BlogID = BlogID;
        this.Title = Title;
        this.ReleaseDate = ReleaseDate;
        this.Description = Description;
        this.BlogPoster = BlogPoster;
        this.Status = Status;
    }

    public Blog() {
        // Empty constructor
    }

    public int getBlogID() {
        return BlogID;
    }

    public void setBlogID(int BlogID) {
        this.BlogID = BlogID;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String Title) {
        this.Title = Title;
    }

    public Date getReleaseDate() {
        return ReleaseDate;
    }

    public void setReleaseDate(Date ReleaseDate) {
        this.ReleaseDate = ReleaseDate;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public int getBlogPoster() {
        return BlogPoster;
    }

    public void setBlogPoster(int BlogPoster) {
        this.BlogPoster = BlogPoster;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Blog{" + "BlogID=" + BlogID + ", Title=" + Title + ", ReleaseDate=" + ReleaseDate + ", Description=" + Description + ", BlogPoster=" + BlogPoster + ", Status=" + Status + '}';
    }
}
