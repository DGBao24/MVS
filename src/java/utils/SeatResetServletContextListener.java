package utils;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 * Servlet context listener for managing the seat reset scheduler.
 * Starts the scheduler when the application starts and stops it when the application stops.
 */
@WebListener
public class SeatResetServletContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Start the scheduler when the application starts
        SeatResetScheduler.startScheduler();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Stop the scheduler when the application stops
        SeatResetScheduler.stopScheduler();
    }
} 