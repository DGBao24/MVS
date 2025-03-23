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
    public List<Movie> getMovie(String sql) {
        List<Movie> list = new ArrayList<>();
        try {
            System.out.println("Executing SQL: " + sql); // Debug log
            Statement statement = conn.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            while (rs.next()) {
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
                        rs.getString(12)
                );
                list.add(movie);
            }
            System.out.println("Found " + list.size() + " movies"); // Debug log
        } catch (SQLException ex) {
            System.out.println("SQL Error: " + ex.getMessage()); // Debug log
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Movie getMovieById(int id) {
        try {
//            String sql = "SELECT m.MovieID, m.MovieName, m.Duration, m.Genre, m.Director, " +
//                        "m.ReleaseDate, m.Description, m.Rate, i.ImagePath, m.TrailerURL, " +
//                        "m.BasePrice, m.Status " +
//                        "FROM [dbo].[Movie] m " +
//                        "JOIN Image i ON m.MoviePoster = i.ImageID " +
//                        "WHERE m.MovieID = ?";
    String sql = "SELECT m.MovieID, m.MovieName, m.Duration, m.Genre, m.Director, " +
            "m.ReleaseDate, m.Description, m.Rate, m.MoviePoster, m.TrailerURL, " +
            "m.BasePrice, m.Status " +
            "FROM [dbo].[Movie] m " +
            "WHERE m.MovieID = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
               return new Movie(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getDate(6),
                        rs.getString(7),
                        rs.getString(8),
                       String.valueOf(rs.getInt("MoviePoster")),
//                        rs.getString(9),
                        rs.getString(10),
                        rs.getInt(11),
                        rs.getString(12)
                );
            }
        } catch (Exception ex) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public Movie showMovieById(int id) {
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
        String query = "SELECT m.MovieID,m.MovieName,m.Duration,m.Genre,m.Director,m.ReleaseDate\n"
                + "      ,m.Description,m.Rate,i.ImagePath,m.TrailerURL,m.BasePrice,m.Status\n"
                + "  FROM [dbo].[Movie] m join Image i on m.MoviePoster = i.ImageID where m.Status like 'NowShowing'";
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
        String query = "SELECT m.MovieID,m.MovieName,m.Duration,m.Genre,m.Director,m.ReleaseDate\n"
                + "      ,m.Description,m.Rate,i.ImagePath,m.TrailerURL,m.BasePrice,m.Status\n"
                + "  FROM [dbo].[Movie] m join Image i on m.MoviePoster = i.ImageID where m.Status like 'UpcomingMovie'";
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

    public int insertMovie(Movie movie) {
        int affectedRow = 0;
        String sql = "INSERT INTO [dbo].[Movie]([MovieName],[Duration],[Genre],[Director],"
                + "[ReleaseDate],[Description],[Rate],[MoviePoster],[TrailerURL],[BasePrice],[Status])\n"
                + "VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, movie.getMovieName());
            ps.setInt(2, movie.getDuration());
            ps.setString(3, movie.getGenre());
            ps.setString(4, movie.getDirector());
            ps.setDate(5, (Date) movie.getReleaseDate());
            ps.setString(6, movie.getDescription());
            ps.setString(7, movie.getRate());
            ps.setString(8, movie.getMoviePoster());
            ps.setString(9, movie.getTrailerURL());
            ps.setInt(10, movie.getBasePrice());
            ps.setString(11, movie.getStatus());
            affectedRow = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return affectedRow;
    }
    
    

//    public int updateMovie(Movie movie) {
//        int affectedRow = 0;
//        String sql = "UPDATE [dbo].[Movie] SET [MovieName] = ?,[Duration] = ?,[Genre] = ?,[Director] = ?,"
//                + "[ReleaseDate] = ?,[Description] = ?,[Rate] = ?,[MoviePoster] = ?,[TrailerURL] = ?,"
//                + "[BasePrice] = ?,[Status] = ? WHERE MovieID = ?";
//        try {
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, movie.getMovieName());
//            ps.setInt(2, movie.getDuration());
//            ps.setString(3, movie.getGenre());
//            ps.setString(4, movie.getDirector());
//            ps.setDate(5, (Date) movie.getReleaseDate());
//            ps.setString(6, movie.getDescription());
//            ps.setString(7, movie.getRate());
//            ps.setString(8, movie.getMoviePoster());
//            ps.setString(9, movie.getTrailerURL());
//            ps.setInt(10, movie.getBasePrice());
//            ps.setString(11, movie.getStatus());
//            ps.setInt(12, movie.getMovieID());
//            affectedRow = ps.executeUpdate();
//        } catch (SQLException ex) {
//            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return affectedRow;
//    }
    
    public int updateMovie(Movie movie) {
    int affectedRow = 0;
    String sql = "UPDATE [dbo].[Movie] SET [MovieName] = ?,[Duration] = ?,[Genre] = ?,[Director] = ?,"
            + "[ReleaseDate] = ?,[Description] = ?,[Rate] = ?,[MoviePoster] = ?,[TrailerURL] = ?,"
            + "[BasePrice] = ?,[Status] = ? WHERE MovieID = ?";
    try {
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, movie.getMovieName());
        ps.setInt(2, movie.getDuration());
        ps.setString(3, movie.getGenre());
        ps.setString(4, movie.getDirector());
        ps.setDate(5, (Date) movie.getReleaseDate());
        ps.setString(6, movie.getDescription());
        ps.setString(7, movie.getRate());
        
        // Handle MoviePoster correctly - it should be an integer ID
        try {
            int posterID = Integer.parseInt(movie.getMoviePoster());
            ps.setInt(8, posterID);
        } catch (NumberFormatException e) {
            // If it's not a number, it might be a path - handle accordingly
            // For now, set it to null or a default value
            ps.setNull(8, java.sql.Types.INTEGER);
            System.out.println("Warning: MoviePoster is not a valid integer ID: " + movie.getMoviePoster());
        }
        
        ps.setString(9, movie.getTrailerURL());
        ps.setInt(10, movie.getBasePrice());
        ps.setString(11, movie.getStatus());
        ps.setInt(12, movie.getMovieID());
        
        // Debug output
        System.out.println("Executing SQL: " + sql);
        System.out.println("MovieID: " + movie.getMovieID());
        System.out.println("MovieName: " + movie.getMovieName());
        System.out.println("MoviePoster: " + movie.getMoviePoster());
        
        affectedRow = ps.executeUpdate();
        System.out.println("Affected rows: " + affectedRow);
    } catch (SQLException ex) {
        System.out.println("SQL Error: " + ex.getMessage());
        Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
    return affectedRow;
}

    public ResultSet getData(String sql) {
        ResultSet rs = null;
        try {
            Statement statement = conn.createStatement(
                ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY
            );
            rs = statement.executeQuery(sql);
        } catch (SQLException ex) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public static void main(String[] args) {
        MovieDAO dao = new MovieDAO();
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

        
        try {
            //        try {
//            //        List<Movie> list = dao.getListShowingMovie();
////        System.out.println(list);
//int n = dao.updateMovie(new Movie(10,"Doremi", 130, "Animation", "Nobita", new Date(sdf.parse("10-3-2025").getTime()), "Hay", "PG", "5", null,  40000, "ShownMovie"));
//if (n > 0){
//                System.out.println("added");
//            } else {
//                System.out.println("failed");
//            }
//        } catch (ParseException ex) {
//            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
        } catch (Exception ex) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Movie> getMoviesByGenre(String genre) {
    List<Movie> list = new ArrayList<>();
     String query = "SELECT m.MovieID,m.MovieName,m.Duration,m.Genre,m.Director,m.ReleaseDate\n"
                + "      ,m.Description,m.Rate,i.ImagePath,m.TrailerURL,m.BasePrice,m.Status\n"
                + "  FROM [dbo].[Movie] m join Image i on m.MoviePoster = i.ImageID where m.Genre like 'UpcomingMovie'";
    try (PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setString(1, genre);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
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
        Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, "Error filtering movies by genre", e);
    }
    return list;
}


   

}
