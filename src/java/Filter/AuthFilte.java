/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package Filter;

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
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import entity.Account;
import utils.Role;


/**
 *
 * @author Tĩnh ăn loz
 */

@WebFilter(filterName = "NewFilter", urlPatterns = {"/*"})
public class AuthFilte implements Filter {
    
    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;
    
    public AuthFilte() {
    }    
    
    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("NewFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }    
    
    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("NewFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        
        String contextPath = req.getContextPath();
        String url = req.getRequestURI();
        
        // Nhóm 1: Kiểm tra các request liên quan đến tài khoản
        boolean isLoginPage = url.equals(contextPath + "/login.jsp");
        boolean isRegisterPage = url.equals(contextPath + "/register.jsp");
        boolean isLogoutPage = url.equals(contextPath + "/logout");
        boolean isResetPassword = url.equals(contextPath + "/reset-pass");
        boolean isChangePassword = url.equals(contextPath + "/profile/change-pass");
        boolean isChangeAvatar = url.contains(contextPath + "/account") && "ChangeAvatar".equals(req.getParameter("service"));

        // Nhóm 2: Kiểm tra các request truy cập nội dung
        boolean isHomePage = url.equals(contextPath + "/home.jsp");
        boolean isMovieList = url.equals(contextPath + "/movies");
        boolean isMovieDetail = url.contains(contextPath + "/detailmovie");

        // Nhóm 3: Kiểm tra các request liên quan đến đơn hàng và thanh toán
        boolean isBuyPage = url.contains(contextPath + "/buy");
        boolean isCartPage = url.equals(contextPath + "/cart");
        boolean isCheckoutPage = url.equals(contextPath + "/checkout");
        boolean isPaymentPage = url.equals(contextPath + "/payment");

        // Nhóm 4: Kiểm tra các request liên quan đến quản lý đơn hàng
        boolean isMyOrders = url.equals(contextPath + "/orders");
        boolean isCancelOrder = url.equals(contextPath + "/orders/cancel");
        boolean isConfirmOrder = url.equals(contextPath + "/orders/confirm");

        // Nhóm 5: Kiểm tra các request liên quan đến trang quản trị

        // Kiểm tra người dùng đã đăng nhập hay chưa
        boolean isLoggedIn = (session != null && session.getAttribute("account") != null);
        if(isLoggedIn){
        Account acc = (Account)session.getAttribute("account");
        boolean isAdmin = (session != null && acc.getRole().equals("Admin"));
        boolean isAdminDashboard = url.equals(contextPath + "/admin/dashboard");
        boolean isOrderManagement = url.equals(contextPath + "/admin/orders");
        boolean isUserManagement = url.equals(contextPath + "/admin/users");
        if (!isAdmin && (isAdminDashboard || isOrderManagement || isUserManagement)) {
            res.sendRedirect(contextPath + "/home.jsp");
            return;
        }
        }

        // Nếu chưa đăng nhập mà vào các trang yêu cầu đăng nhập -> Chuyển hướng đến login
        if (!isLoggedIn && (isBuyPage || isCartPage || isCheckoutPage || isPaymentPage || isMyOrders)) {
            res.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        // Nếu không phải admin mà vào trang quản trị -> Chuyển hướng về home

        // Cho phép request tiếp tục nếu không bị chặn
        chain.doFilter(request, response);
    }
   

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {        
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {        
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {                
                log("NewFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("NewFilter()");
        }
        StringBuffer sb = new StringBuffer("NewFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }
    
    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);        
        
        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);                
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");                
                pw.print(stackTrace);                
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }
    
    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }
    
    public void log(String msg) {
        filterConfig.getServletContext().log(msg);        
    }
    
}
