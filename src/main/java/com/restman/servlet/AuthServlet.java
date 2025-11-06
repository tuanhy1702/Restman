package com.restman.servlet;

import com.restman.dao.CustomerDAO;
import com.restman.dao.StaffDAO;
import com.restman.entity.Customer;
import com.restman.entity.Manager;
import com.restman.entity.SaleStaff;
import com.restman.entity.WarehouseStaff;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

/**
 * Servlet xử lý authentication (đăng nhập/đăng xuất)
 */
@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AuthServlet.class.getName());
    private CustomerDAO customerDAO;
    private StaffDAO staffDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        customerDAO = new CustomerDAO();
        staffDAO = new StaffDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        if ("logout".equals(action)) {
            logout(req, resp);
        } else {
            // Hiển thị trang đăng nhập
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        if ("login".equals(action)) {
            login(req, resp);
        } else if ("register".equals(action)) {
            register(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/auth");
        }
    }
    
    /**
     * Xử lý đăng nhập
     */
    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        
        HttpSession session = req.getSession();
        
        try {
            // 1) Manager
            Manager manager = staffDAO.loginManager(username, password);
            if (manager != null) {
                session.setAttribute("user", manager);
                session.setAttribute("userType", "manager");
                session.setAttribute("userId", manager.getId());
                session.setAttribute("userName", manager.getName());
                resp.sendRedirect(req.getContextPath() + "/views/manager/ManagerView.jsp");
                return;
            }

            // 2) Sale Staff
            SaleStaff saleStaff = staffDAO.loginSaleStaff(username, password);
            if (saleStaff != null) {
                session.setAttribute("user", saleStaff);
                session.setAttribute("userType", "saleStaff");
                session.setAttribute("userId", saleStaff.getId());
                session.setAttribute("userName", saleStaff.getName());
                resp.sendRedirect(req.getContextPath() + "/views/saleStaff/SaleStaffView.jsp");
                return;
            }

            // 3) Warehouse Staff
            WarehouseStaff warehouseStaff = staffDAO.loginWarehouseStaff(username, password);
            if (warehouseStaff != null) {
                session.setAttribute("user", warehouseStaff);
                session.setAttribute("userType", "warehouseStaff");
                session.setAttribute("userId", warehouseStaff.getId());
                session.setAttribute("userName", warehouseStaff.getName());
                resp.sendRedirect(req.getContextPath() + "/views/warehouseStaff/WarehouseStaffView.jsp");
                return;
            }

            // 4) Customer
            Customer customer = customerDAO.login(username, password);
            if (customer != null) {
                session.setAttribute("user", customer);
                session.setAttribute("userType", "customer");
                session.setAttribute("userId", customer.getId());
                session.setAttribute("userName", customer.getName());
                resp.sendRedirect(req.getContextPath() + "/views/customer/CustomerView.jsp");
                return;
            }

            // No match
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        } catch (Exception e) {
            logger.severe("Error during login: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi đăng nhập");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
    
    /**
     * Xử lý đăng ký khách hàng
     */
    private void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String name = req.getParameter("name");
        String phoneNumber = req.getParameter("phoneNumber");
        String email = req.getParameter("email");
        String dateOfBirth = req.getParameter("dateOfBirth");
        String address = req.getParameter("address");
        
        // Validation
        if (username == null || username.isEmpty() || 
            password == null || password.isEmpty() || 
            name == null || name.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        
        if (customerDAO.isUsernameExists(username)) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        
        try {
            Customer customer = new Customer();
            customer.setUsername(username);
            customer.setPassword(password);
            customer.setName(name);
            customer.setPhoneNumber(phoneNumber);
            customer.setEmail(email);
            customer.setDateOfBirth(dateOfBirth);
            customer.setAddress(address);
            
            boolean success = customerDAO.register(customer);
            if (success) {
                req.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            logger.severe("Error during registration: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi đăng ký");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
    
    /**
     * Xử lý đăng xuất
     */
    private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect(req.getContextPath() + "/auth");
    }
    
    @Override
    public void destroy() {
        super.destroy();
        if (customerDAO != null) {
            customerDAO.closeConnection();
        }
        if (staffDAO != null) {
            staffDAO.closeConnection();
        }
    }
}
