package com.coursework.controller.servlets;

import com.coursework.dao.BookingDAO;
import com.coursework.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CustomerBookingsServlet", urlPatterns = {"/customer/bookings"})
public class CustomerBookingsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        BookingDAO bookingDAO = new BookingDAO();
        request.setAttribute("bookings", bookingDAO.getBookingsByUserId(user.getUserId()));
        request.getRequestDispatcher("/customer/bookings.jsp").forward(request, response);
    }
}
