<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, entity.Movie" %>
<%
    Movie movie = (Movie)request.getAttribute("movie");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Movie</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2>Update Movie</h2>
            <form action="movie" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="service" value="updateMovie">
                <input type="hidden" name="submit" value="true">
             
                <div class="mb-3">
                    <label class="form-label">MovieID:</label>
                    <input type="text" class="form-control" name="MovieID" value="<%=movie.getMovieID()%>" readonly>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Movie Name:</label>
                    <input type="text" class="form-control" name="MovieName" value="<%=movie.getMovieName()%>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Duration (minutes):</label>
                    <input type="number" class="form-control" name="Duration" value="<%=movie.getDuration()%>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Genre:</label>
                    <input type="text" class="form-control" name="Genre" value="<%=movie.getGenre()%>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Director:</label>
                    <input type="text" class="form-control" name="Director" value="<%=movie.getDirector()%>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Release Date:</label>
                    <input type="date" class="form-control" name="ReleaseDate" value="<%=movie.getReleaseDate()%>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Description:</label>
                    <textarea class="form-control" name="Description" rows="3" required><%=movie.getDescription()%></textarea>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Rate:</label>
                    <input type="text" class="form-control" name="Rate" value="<%=movie.getRate()%>" required>
                </div>
                
            
                <div class="mb-3">
                    <label class="form-label">Update Movie Poster (Optional):</label>
                    <input type="file" class="form-control" name="MoviePoster" accept="image/*">
                    <small class="text-muted">Leave empty to keep current poster</small>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Trailer URL:</label>
                    <input type="text" class="form-control" name="TrailerURL" value="<%=movie.getTrailerURL()%>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Base Price:</label>
                    <input type="number" class="form-control" name="BasePrice" value="<%=movie.getBasePrice()%>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Status:</label>
                    <select class="form-control" name="Status" required>
                        <option value="NowShowing" <%= movie.getStatus().equals("NowShowing") ? "selected" : "" %>>NowShowing</option>
                        <option value="UpcomingMovie" <%= movie.getStatus().equals("UpcomingMovie") ? "selected" : "" %>>UpcomingMovie</option>
                        <option value="ShownMovie" <%= movie.getStatus().equals("ShownMovie") ? "selected" : "" %>>ShownMovie</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-primary">Update Movie</button>
                <a href="movie?service=listAll" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </body>
</html> 