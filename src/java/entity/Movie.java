/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author Acer Nitro
 */
public class Movie {

    private int MovieID;
    private String MovieName;
    private int Duration;
    private String Genre;
    private String Director;
    private Date ReleaseDate;
    private String Description;
    private String Rate;
    private String MoviePoster;
    private String TrailerURL;
    private int BasePrice;
    private String Status;
    

    public Movie() {
    }

    public Movie(String MovieName, int Duration, String Genre, String Director, Date ReleaseDate, String Description, String Rate, String TrailerURL, int BasePrice, String Status) {
        this.MovieName = MovieName;
        this.Duration = Duration;
        this.Genre = Genre;
        this.Director = Director;
        this.ReleaseDate = ReleaseDate;
        this.Description = Description;
        this.Rate = Rate;
        this.TrailerURL = TrailerURL;
        this.BasePrice = BasePrice;
        this.Status = Status;
    }
    

    public Movie(int MovieID, String MovieName, int Duration, String Genre, String Director, Date ReleaseDate, String Description, String Rate, String TrailerURL, int BasePrice, String Status) {
        this.MovieID = MovieID;
        this.MovieName = MovieName;
        this.Duration = Duration;
        this.Genre = Genre;
        this.Director = Director;
        this.ReleaseDate = ReleaseDate;
        this.Description = Description;
        this.Rate = Rate;
        this.TrailerURL = TrailerURL;
        this.BasePrice = BasePrice;
        this.Status = Status;
    }
    
    

    public Movie(int MovieID, String MovieName, int Duration, String Genre, String Director, Date ReleaseDate, String Description, String Rate, String MoviePoster, String TrailerURL, int BasePrice, String Status) {
        this.MovieID = MovieID;
        this.MovieName = MovieName;
        this.Duration = Duration;
        this.Genre = Genre;
        this.Director = Director;
        this.ReleaseDate = ReleaseDate;
        this.Description = Description;
        this.Rate = Rate;
        this.MoviePoster = MoviePoster;
        this.TrailerURL = TrailerURL;
        this.BasePrice = BasePrice;
        this.Status = Status;
    }

    public Movie(String MovieName, int Duration, String Genre, String Director, Date ReleaseDate, String Description, String Rate, String MoviePoster, String TrailerURL, int BasePrice, String Status) {
        this.MovieName = MovieName;
        this.Duration = Duration;
        this.Genre = Genre;
        this.Director = Director;
        this.ReleaseDate = ReleaseDate;
        this.Description = Description;
        this.Rate = Rate;
        this.MoviePoster = MoviePoster;
        this.TrailerURL = TrailerURL;
        this.BasePrice = BasePrice;
        this.Status = Status;
    }

    public int getMovieID() {
        return MovieID;
    }

    public void setMovieID(int MovieID) {
        this.MovieID = MovieID;
    }

    public String getMovieName() {
        return MovieName;
    }

    public void setMovieName(String MovieName) {
        this.MovieName = MovieName;
    }

    public int getDuration() {
        return Duration;
    }

    public void setDuration(int Duration) {
        this.Duration = Duration;
    }

    public String getGenre() {
        return Genre;
    }

    public void setGenre(String Genre) {
        this.Genre = Genre;
    }

    public String getDirector() {
        return Director;
    }

    public void setDirector(String Director) {
        this.Director = Director;
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

    public String getRate() {
        return Rate;
    }

    public void setRate(String Rate) {
        this.Rate = Rate;
    }

    public String getMoviePoster() {
        return MoviePoster;
    }

    public void setMoviePoster(String MoviePoster) {
        this.MoviePoster = MoviePoster;
    }

    public String getTrailerURL() {
        return TrailerURL;
    }

    public void setTrailerURL(String TrailerURL) {
        this.TrailerURL = TrailerURL;
    }

    public int getBasePrice() {
        return BasePrice;
    }

    public void setBasePrice(int BasePrice) {
        this.BasePrice = BasePrice;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Movie{" + "MovieID=" + MovieID + ", MovieName=" + MovieName + ", Duration=" + Duration + ", Genre=" + Genre + ", Director=" + Director + ", ReleaseDate=" + ReleaseDate + ", Description=" + Description + ", Rate=" + Rate + ", MoviePoster=" + MoviePoster + ", TrailerURL=" + TrailerURL + ", BasePrice=" + BasePrice + ", Status=" + Status + '}';
    }
    
    

}