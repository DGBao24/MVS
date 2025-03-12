package model;

import entity.Movie;
import java.sql.Date;
import model.DBConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.text.ParseException;

public class MovieDAO extends DBConnection {

//    public List<Movie> getAllMovie() {
//        List<Movie> list = new ArrayList<>();
//       String query = "SELECT m.MovieID,m.MovieName,m.Duration,m.Genre,m.Director,m.ReleaseDate\n" +
//"      ,m.Description,m.Rate,i.ImagePath,m.TrailerURL,m.BasePrice,m.Status\n" +
//"  FROM [dbo].[Movie] m join Image i on m.MoviePoster = i.ImageID";
//        try (PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
//            if (!rs.isBeforeFirst()) {
//                System.out.println("Không có dữ liệu trong bảng Movie!");
//            }
//            while (rs.next()) {
//                System.out.println("Lấy được phim: " + rs.getString("MovieName"));
//                list.add(new Movie(
//                        rs.getInt(1),
//                        rs.getString(2),
//                        rs.getInt(3),
//                        rs.getString(4),
//                        rs.getString(5),
//                        rs.getDate(6),
//                        rs.getString(7),
//                        rs.getString(8),
//                        rs.getString(9),
//                        rs.getString(10),
//                        rs.getInt(11),
//                        rs.getString(12)
//                ));
//            }
//        } catch (SQLException e) {
//            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, "Lỗi khi lấy danh sách phim", e);
//        }
//        return list;
//    }
    public List<Movie> getMovie (String sql){
        List<Movie> list = new ArrayList<>();
        try {
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            while (rs.next()){
                Movie movie = new Movie(
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
                list.add(movie);
            }
        } catch (SQLException ex) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
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
    
    public List<Movie> getListShowingMovie() {
        List<Movie> list = new ArrayList<>();
          String query = "SELECT m.MovieID,m.MovieName,m.Duration,m.Genre,m.Director,m.ReleaseDate\n" +
"      ,m.Description,m.Rate,i.ImagePath,m.TrailerURL,m.BasePrice,m.Status\n" +
"  FROM [dbo].[Movie] m join Image i on m.MoviePoster = i.ImageID where m.Status like 'NowShowing'";
        try (PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            if (!rs.isBeforeFirst()) {
                System.out.println("Không có dữ liệu trong bảng Movie!");
            }
            while (rs.next()) {
                System.out.println("Lấy được phim: " + rs.getString("MovieName"));
                list.add(new Movie(
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
                        rs.getString(12)
                ));
            }
        } catch (SQLException e) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, "Lỗi khi lấy danh sách phim", e);
        }
        return list;
    }

    public List<Movie> getListUpcomingMovie() {
        List<Movie> list = new ArrayList<>();
 String query = "SELECT m.MovieID,m.MovieName,m.Duration,m.Genre,m.Director,m.ReleaseDate\n" +
"      ,m.Description,m.Rate,i.ImagePath,m.TrailerURL,m.BasePrice,m.Status\n" +
"  FROM [dbo].[Movie] m join Image i on m.MoviePoster = i.ImageID where m.Status like 'UpcomingMovie'";
        try (PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            if (!rs.isBeforeFirst()) {
                System.out.println("Không có dữ liệu trong bảng Movie!");
            }
            while (rs.next()) {
                System.out.println("Lấy được phim: " + rs.getString("MovieName"));
                list.add(new Movie(
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
                        rs.getString(12)
                ));
            }
        } catch (SQLException e) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, "Lỗi khi lấy danh sách phim", e);
        }
        return list;
    }
    
        public int insertMovie(Movie movie){
            int affectedRow = 0;
            String sql = "INSERT INTO [dbo].[Movie]([MovieName],[Duration],[Genre],[Director],[ReleaseDate],[Description],[Rate],[TrailerURL],[BasePrice],[Status])\n" +
"     VALUES(?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, movie.getMovieName());
            ps.setInt(2, movie.getDuration());
            ps.setString(3, movie.getGenre());
            ps.setString(4, movie.getDirector());
            ps.setDate(5, (Date) movie.getReleaseDate());
            ps.setString(6, movie.getDescription());
            ps.setString(7, movie.getRate());
            ps.setString(8, movie.getTrailerURL());
            ps.setInt(9, movie.getBasePrice());
            ps.setString(10, movie.getStatus());
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
        }
        
        public int updateMovie(Movie movie){
            int affectedRow = 0;
            String sql = "UPDATE [dbo].[Movie] SET [MovieName] = ?,[Duration] = ?,[Genre] = ?,[Director] = ?,[ReleaseDate] = ?,[Description] = ?,[Rate] = ?,[TrailerURL] = ?,[BasePrice] = ?,[Status] = ? WHERE MovieID = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, movie.getMovieName());
            ps.setInt(2, movie.getDuration());
            ps.setString(3, movie.getGenre());
            ps.setString(4, movie.getDirector());
            ps.setDate(5, (Date) movie.getReleaseDate());
            ps.setString(6, movie.getDescription());
            ps.setString(7, movie.getRate());
            ps.setString(8, movie.getTrailerURL());
            ps.setInt(9, movie.getBasePrice());
            ps.setString(10, movie.getStatus());
            ps.setInt(11, movie.getMovieID());
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
        }

    public static void main(String[] args) {
        MovieDAO dao = new MovieDAO();
              SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
//        try {
//            //        List<Movie> list = dao.getListShowingMovie();
////        System.out.println(list);
//int n = dao.updateMovie(new Movie(6,"Doremi", 130, "Animation", "Nobita", new Date(sdf.parse("10-3-2025").getTime()), "Hay", "PG", null, 40000, "ShownMovie"));
//if (n > 0){
//                System.out.println("added");
//            } else {
//                System.out.println("failed");
//            }
//        } catch (ParseException ex) {
//            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
    }
}
