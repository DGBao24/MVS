package controller;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import model.BookingDAO;

@WebListener
public class OrderStatusScheduler implements ServletContextListener {
    
    private ScheduledExecutorService scheduler;
    
    @Override
    public void contextInitialized(ServletContextEvent event) {
        scheduler = Executors.newSingleThreadScheduledExecutor();
        // Check every minute for orders that need to be updated
        scheduler.scheduleAtFixedRate(() -> {
            BookingDAO dao = new BookingDAO();
            dao.checkAndUpdateOrderStatus();
        }, 0, 1, TimeUnit.MINUTES);
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent event) {
        if (scheduler != null) {
            scheduler.shutdownNow();
        }
    }
} 