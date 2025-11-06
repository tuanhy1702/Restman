package com.restman.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Utility class để xử lý authentication và authorization
 */
public class AuthUtil {
    
    /**
     * Kiểm tra xem user đã đăng nhập chưa
     */
    public static boolean isLoggedIn(HttpSession session) {
        return session != null && session.getAttribute("user") != null;
    }
    
    /**
     * Kiểm tra xem user có role cụ thể không
     */
    public static boolean hasRole(HttpSession session, String role) {
        if (!isLoggedIn(session)) {
            return false;
        }
        String userType = (String) session.getAttribute("userType");
        return role.equals(userType);
    }
    
    /**
     * Kiểm tra xem user có phải là manager không
     */
    public static boolean isManager(HttpSession session) {
        return hasRole(session, "manager");
    }
    
    /**
     * Kiểm tra xem user có phải là sale staff không
     */
    public static boolean isSaleStaff(HttpSession session) {
        return hasRole(session, "saleStaff");
    }
    
    /**
     * Kiểm tra xem user có phải là warehouse staff không
     */
    public static boolean isWarehouseStaff(HttpSession session) {
        return hasRole(session, "warehouseStaff");
    }
    
    /**
     * Kiểm tra xem user có phải là customer không
     */
    public static boolean isCustomer(HttpSession session) {
        return hasRole(session, "customer");
    }
    
    /**
     * Redirect đến trang đăng nhập nếu chưa đăng nhập
     */
    public static void requireLogin(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        if (!isLoggedIn(request.getSession())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
    
    /**
     * Redirect đến trang đăng nhập nếu không có role cụ thể
     */
    public static void requireRole(HttpServletRequest request, HttpServletResponse response, String role) 
            throws IOException {
        if (!hasRole(request.getSession(), role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
    
    /**
     * Redirect đến trang đăng nhập nếu không phải manager
     */
    public static void requireManager(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        requireRole(request, response, "manager");
    }
    
    /**
     * Redirect đến trang đăng nhập nếu không phải sale staff
     */
    public static void requireSaleStaff(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        requireRole(request, response, "saleStaff");
    }
    
    /**
     * Redirect đến trang đăng nhập nếu không phải warehouse staff
     */
    public static void requireWarehouseStaff(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        requireRole(request, response, "warehouseStaff");
    }
    
    /**
     * Redirect đến trang đăng nhập nếu không phải customer
     */
    public static void requireCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        requireRole(request, response, "customer");
    }
    
    /**
     * Lấy user ID từ session
     */
    public static Integer getUserId(HttpSession session) {
        if (!isLoggedIn(session)) {
            return null;
        }
        return (Integer) session.getAttribute("userId");
    }
    
    /**
     * Lấy username từ session
     */
    public static String getUsername(HttpSession session) {
        if (!isLoggedIn(session)) {
            return null;
        }
        return (String) session.getAttribute("userName");
    }
    
    /**
     * Lấy user type từ session
     */
    public static String getUserType(HttpSession session) {
        if (!isLoggedIn(session)) {
            return null;
        }
        return (String) session.getAttribute("userType");
    }
    
    /**
     * Đăng xuất user
     */
    public static void logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
    }
    
    /**
     * Kiểm tra xem user có quyền truy cập resource không
     */
    public static boolean hasAccess(HttpSession session, String resource) {
        if (!isLoggedIn(session)) {
            return false;
        }
        
        String userType = getUserType(session);
        
        // Manager có quyền truy cập tất cả
        if ("manager".equals(userType)) {
            return true;
        }
        
        // Kiểm tra quyền theo resource
        switch (resource) {
            case "food":
            case "combo":
                return "manager".equals(userType) || "saleStaff".equals(userType);
            case "customer":
                return "manager".equals(userType) || "saleStaff".equals(userType);
            case "order":
            case "table":
                return "manager".equals(userType) || "saleStaff".equals(userType);
            case "supplier":
            case "import":
                return "manager".equals(userType) || "warehouseStaff".equals(userType);
            case "statistics":
                return "manager".equals(userType);
            default:
                return false;
        }
    }
    
    /**
     * Redirect đến trang không có quyền truy cập
     */
    public static void accessDenied(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/views/access-denied.jsp");
    }
}
