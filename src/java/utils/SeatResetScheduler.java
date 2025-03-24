package utils;

import entity.Seat;
import entity.Showtime;
import entity.Ticket;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.BookingDAO;
import model.DAOShowtime;
import model.SeatDAO;

/**
 * A scheduler utility to automatically reset seat status after showtimes end.
 */
public class SeatResetScheduler {
    private static final Logger LOGGER = Logger.getLogger(SeatResetScheduler.class.getName());
    private static Timer timer;
    private static final long CHECK_INTERVAL = TimeUnit.MINUTES.toMillis(5); // Check every 5 minutes
    
    private SeatResetScheduler() {
        // Private constructor to prevent instantiation
    }
    
    /**
     * Starts the seat reset scheduler
     */
    public static void startScheduler() {
        if (timer != null) {
            return; // Scheduler already running
        }
        
        timer = new Timer(true); // Run as daemon thread
        timer.scheduleAtFixedRate(new SeatResetTask(), 0, CHECK_INTERVAL);
        LOGGER.info("Seat reset scheduler started");
    }
    
    /**
     * Stops the seat reset scheduler
     */
    public static void stopScheduler() {
        if (timer != null) {
            timer.cancel();
            timer = null;
            LOGGER.info("Seat reset scheduler stopped");
        }
    }
    
    /**
     * Task that runs periodically to check for completed showtimes and reset seats
     */
    private static class SeatResetTask extends TimerTask {
        @Override
        public void run() {
            try {
                resetSeatsForCompletedShowtimes();
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error in seat reset task", e);
            }
        }
        
        private void resetSeatsForCompletedShowtimes() {
            DAOShowtime showtimeDAO = new DAOShowtime();
            BookingDAO bookingDAO = new BookingDAO();
            
            // Get all showtimes
            List<Showtime> showtimes = showtimeDAO.getAllShowtimes();
            Timestamp currentTime = new Timestamp(new Date().getTime());
            
            for (Showtime showtime : showtimes) {
                // Check if the showtime has ended
                if (showtime.getEndTime().before(currentTime)) {
                    resetSeatsForShowtime(showtime, bookingDAO);
                }
            }
        }
        
        private void resetSeatsForShowtime(Showtime showtime, BookingDAO bookingDAO) {
            try {
                // Find tickets related to this showtime
                List<Ticket> tickets = bookingDAO.getTicketsByShowtime(showtime.getShowtimeID());
                
                for (Ticket ticket : tickets) {
                    // Reset each seat that was booked for this showtime
                    Seat seat = bookingDAO.getSeatByID(ticket.getSeatID());
                    if (seat != null && !"Available".equals(seat.getStatus())) {
                        bookingDAO.updateSeatEndTime(seat.getSeatID());
                        LOGGER.info("Reset seat " + seat.getSeatID() + " for showtime " + showtime.getShowtimeID());
                    }
                }
                
                LOGGER.info("Completed seat reset for showtime " + showtime.getShowtimeID());
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error resetting seats for showtime " + showtime.getShowtimeID(), e);
            }
        }
    }
} 