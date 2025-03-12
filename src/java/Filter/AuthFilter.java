package Filter;

import entity.Account;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        // Get the requested URI
        String requestURI = req.getRequestURI();
        
        // Get logged in account from session
        Account account = (Account) session.getAttribute("account");

        // Check if user is logged in and has appropriate role
        if (account != null && (account.getRole().equals("Admin") || 
                              account.getRole().equals("Manager"))) {
            // User has permission, proceed with the request
            chain.doFilter(request, response);
        } else {
            // User doesn't have permission, redirect to error page
            res.sendRedirect(req.getContextPath() + "/Error.jsp");
        }
    }

    @Override
    public void destroy() {
    }
}
