package com.restman.servlet;

import com.restman.dao.FoodDAO;
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
 * Servlet xử lý các request liên quan đến Food
 */
@WebServlet("/food")
public class FoodServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(FoodServlet.class.getName());
    private FoodDAO foodDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        foodDAO = new FoodDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        if (action == null) {
            action = "search";
        }
        
        try {
            switch (action) {
                case "search": {
                    String searchTerm = req.getParameter("searchTerm");
                    List<Food> foods = foodDAO.searchFoodByName(searchTerm);
                    req.setAttribute("foods", foods);
                    req.setAttribute("searchTerm", searchTerm);
                    String userType = (String) req.getSession().getAttribute("userType");
                    if ("customer".equals(userType)) {
                        req.getRequestDispatcher("/views/customer/SearchFoodView.jsp").forward(req, resp);
                    } else if ("manager".equals(userType)) {
                        req.getRequestDispatcher("/views/manager/SearchView.jsp").forward(req, resp);
                    } else {
                        req.getRequestDispatcher("/views/SearchFoodView.jsp").forward(req, resp);
                    }
                    break;
                }
                case "detail": {
                    String foodIdStr = req.getParameter("foodId");
                    if (foodIdStr != null && !foodIdStr.isEmpty()) {
                        try {
                            int foodId = Integer.parseInt(foodIdStr);
                            Food food = foodDAO.getFoodById(foodId);
                            if (food != null) {
                                req.setAttribute("food", food);
                                String userType = (String) req.getSession().getAttribute("userType");
                                if ("customer".equals(userType)) {
                                    req.getRequestDispatcher("/views/customer/FoodDetailView.jsp").forward(req, resp);
                                } else {
                                    req.getRequestDispatcher("/views/FoodDetailView.jsp").forward(req, resp);
                                }
                            } else {
                                req.setAttribute("error", "Không tìm thấy món ăn");
                                req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                            }
                        } catch (NumberFormatException e) {
                            req.setAttribute("error", "ID món ăn không hợp lệ");
                            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                        }
                    } else {
                        req.setAttribute("error", "Thiếu thông tin ID món ăn");
                        req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                    }
                    break;
                }
                default:
                    req.setAttribute("error", "Chức năng không khả dụng");
                    req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                    break;
            }
        } catch (Exception e) {
            logger.severe("Error in FoodServlet doGet: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi xử lý yêu cầu");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }
    
    @Override
    public void destroy() {
        super.destroy();
        if (foodDAO != null) {
            foodDAO.closeConnection();
        }
    }
}
