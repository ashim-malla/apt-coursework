package com.coursework.controller.servlets;

import com.coursework.dao.BikeDAO;
import com.coursework.dao.BookingDAO;
import com.coursework.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CustomerDashboardServlet", urlPatterns = {"/customer/dashboard"})
public class CustomerDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BikeDAO bikeDAO = new BikeDAO();
        BookingDAO bookingDAO = new BookingDAO();
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        request.setAttribute("availableBikes", bikeDAO.getAvailableBikes());
        request.setAttribute("activeBookings", bookingDAO.countActiveBookingsByUserId(user.getUserId()));
        request.setAttribute("bookings", bookingDAO.getBookingsByUserId(user.getUserId()));
        request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
    }
}
