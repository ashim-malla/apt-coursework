package com.coursework.controller.servlets;

import com.coursework.dao.BikeDAO;
import com.coursework.dao.UserDAO;
import com.coursework.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check role
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Get stats
        UserDAO userDAO = new UserDAO();
        BikeDAO bikeDAO = new BikeDAO();
        request.setAttribute("totalUsers", userDAO.getTotalUsers());
        request.setAttribute("totalBikes", bikeDAO.getTotalBikes());
        request.setAttribute("availableBikes", bikeDAO.getAvailableBikeCount());
        request.setAttribute("recentUsers", userDAO.getRecentUsers(5)); // 

        request.getRequestDispatcher("/users/adminDashboard.jsp").forward(request, response);
        
    }
}
