package com.restman.servlet;

import com.restman.dao.ComboDAO;
import com.restman.dao.ComboFoodDAO;
import com.restman.dao.FoodDAO;
import com.restman.entity.Combo;
import com.restman.entity.Food;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

/**
 * Servlet xử lý các request liên quan đến Combo
 */
@WebServlet("/combo")
public class ComboServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ComboServlet.class.getName());
    private ComboDAO comboDAO;
    private ComboFoodDAO comboFoodDAO;
    private FoodDAO foodDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        comboDAO = new ComboDAO();
        comboFoodDAO = new ComboFoodDAO();
        foodDAO = new FoodDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Access control: only manager can manage combos
        Object userTypeObj = req.getSession().getAttribute("userType");
        if (userTypeObj == null || !"manager".equals(userTypeObj.toString())) {
            req.setAttribute("error", "Bạn không có quyền truy cập chức năng này");
            req.getRequestDispatcher("/views/access-denied.jsp").forward(req, resp);
            return;
        }

        String action = req.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "list":
                    listCombos(req, resp);
                    break;
                case "add":
                    showAddComboForm(req, resp);
                    break;

                default:
                    listCombos(req, resp);
                    break;
            }
        } catch (Exception e) {
            logger.severe("Error in ComboServlet doGet: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi xử lý yêu cầu");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        try {
            switch (action) {
                case "create":
                    createCombo(req, resp);
                    break;
                case "addFood":
                    addFoodToCombo(req, resp);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/combo");
                    break;
            }
        } catch (Exception e) {
            logger.severe("Error in ComboServlet doPost: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi xử lý yêu cầu");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }
    
    /**
     * Hiển thị danh sách combo
     */
    private void listCombos(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // move flash message from session to request if exists
        Object flashMsg = req.getSession().getAttribute("message");
        if (flashMsg != null) {
            req.setAttribute("message", flashMsg);
            req.getSession().removeAttribute("message");
        }

        List<Combo> combos = comboDAO.getCombo();
        req.setAttribute("combos", combos);
        req.getRequestDispatcher("/views/manager/ManageComboView.jsp").forward(req, resp);
    }
    
    /**
     * Hiển thị form thêm combo
     */
    private void showAddComboForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchTerm = req.getParameter("searchTerm");
        String searchType = req.getParameter("searchType");
        List<Food> foods;
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            // Tìm kiếm món ăn theo từ khóa
            if ("category".equals(searchType)) {
                foods = foodDAO.searchFoodByCategory(searchTerm);
            } else {
                foods = foodDAO.searchFoodByName(searchTerm);
            }

            req.setAttribute("searchTerm", searchTerm);
            req.setAttribute("searchType", searchType);
        } else {
            // Lấy tất cả món ăn
            foods = foodDAO.getAllFoods();
        }
        
        req.setAttribute("foods", foods);
        req.getRequestDispatcher("/views/manager/AddComboView.jsp").forward(req, resp);
    }

    
    /**
     * Tạo combo mới
     */
    private void createCombo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        String description = req.getParameter("description");
        
        if (name != null && !name.isEmpty() && priceStr != null && !priceStr.isEmpty()) {
            try {
                float price = Float.parseFloat(priceStr);
                Combo combo = new Combo();
                combo.setName(name);
                combo.setPrice(price);
                combo.setDescription(description);
                
                boolean success = comboDAO.setCombo(combo);
                if (success) {
                    // Xử lý các món ăn đã chọn
                    String[] selectedFoods = req.getParameterValues("selectedFoods");
                    if (selectedFoods != null && selectedFoods.length > 0) {
                        for (String foodItem : selectedFoods) {
                            // Format: "foodId:quantity"
                            String[] parts = foodItem.split(":");
                            if (parts.length == 2) {
                                try {
                                    int foodId = Integer.parseInt(parts[0]);
                                    int quantity = Integer.parseInt(parts[1]);
                                    comboFoodDAO.addFoodToCombo(combo.getId(), foodId, quantity);
                                } catch (NumberFormatException e) {
                                    logger.warning("Invalid food item format: " + foodItem);
                                }
                            }
                        }
                        req.setAttribute("message", "Tạo combo thành công và đã thêm " + selectedFoods.length + " món ăn");
                    } else {
                        req.setAttribute("message", "Tạo combo thành công. Lưu ý: Chưa có món ăn nào được thêm vào combo.");
                    }
                    
                    // Flash success then redirect to combo list
                    req.getSession().setAttribute("message", "Tạo combo thành công");
                    resp.sendRedirect(req.getContextPath() + "/combo");
                    return;
                } else {
                    req.setAttribute("error", "Tạo combo thất bại");
                    showAddComboForm(req, resp);
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Giá combo không hợp lệ");
                showAddComboForm(req, resp);
            }
        } else {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
            showAddComboForm(req, resp);
        }
    }
    
    /**
     * Thêm món ăn vào combo
     */
    private void addFoodToCombo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String comboIdStr = req.getParameter("comboId");
        String foodIdStr = req.getParameter("foodId");
        String quantityStr = req.getParameter("quantity");
        
        if (comboIdStr != null && !comboIdStr.isEmpty() && 
            foodIdStr != null && !foodIdStr.isEmpty() && 
            quantityStr != null && !quantityStr.isEmpty()) {
            try {
                int comboId = Integer.parseInt(comboIdStr);
                int foodId = Integer.parseInt(foodIdStr);
                int quantity = Integer.parseInt(quantityStr);
                
                boolean success = comboFoodDAO.addFoodToCombo(comboId, foodId, quantity);
                if (success) {
                    req.setAttribute("message", "Thêm món ăn vào combo thành công");
                } else {
                    req.setAttribute("error", "Thêm món ăn vào combo thất bại");
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Dữ liệu không hợp lệ");
            }
        } else {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
        }
        
       
    }
    
    @Override
    public void destroy() {
        super.destroy();
        if (comboDAO != null) {
            comboDAO.closeConnection();
        }
        if (comboFoodDAO != null) {
            comboFoodDAO.closeConnection();
        }
        if (foodDAO != null) {
            foodDAO.closeConnection();
        }
    }
}
