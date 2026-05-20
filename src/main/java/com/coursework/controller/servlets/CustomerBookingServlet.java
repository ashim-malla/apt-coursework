package com.coursework.controller.servlets;

import com.coursework.dao.BikeDAO;
import com.coursework.dao.BookingDAO;
import com.coursework.model.Bike;
import com.coursework.model.Booking;
import com.coursework.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet(name = "CustomerBookingServlet", urlPatterns = {"/customer/book"})
public class CustomerBookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final BikeDAO bikeDAO = new BikeDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Bike bike = getBikeFromRequest(request);
        if (bike == null || !"available".equals(bike.getStatus())) {
            request.getSession().setAttribute("message", "Selected bike is not available for booking.");
            response.sendRedirect(request.getContextPath() + "/bikes");
            return;
        }

        request.setAttribute("bike", bike);
        request.getRequestDispatcher("/customer/book-bike.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        Bike bike = getBikeFromRequest(request);

        if (bike == null || !"available".equals(bike.getStatus())) {
            request.getSession().setAttribute("message", "Selected bike is not available for booking.");
            response.sendRedirect(request.getContextPath() + "/bikes");
            return;
        }

        LocalDate startDate;
        LocalDate endDate;
        try {
            startDate = LocalDate.parse(request.getParameter("startDate"));
            endDate = LocalDate.parse(request.getParameter("endDate"));
        } catch (Exception e) {
            forwardBookingError(request, response, bike, "Please choose valid start and end dates.");
            return;
        }

        if (startDate.isBefore(LocalDate.now())) {
            forwardBookingError(request, response, bike, "Start date cannot be in the past.");
            return;
        }
        if (endDate.isBefore(startDate)) {
            forwardBookingError(request, response, bike, "End date cannot be before start date.");
            return;
        }

        long rentalDays = ChronoUnit.DAYS.between(startDate, endDate) + 1;
        BigDecimal totalAmount = bike.getPricePerDay().multiply(BigDecimal.valueOf(rentalDays));

        Booking booking = new Booking();
        booking.setUserId(user.getUserId());
        booking.setBikeId(bike.getBikeId());
        booking.setStartDate(startDate);
        booking.setEndDate(endDate);
        booking.setTotalAmount(totalAmount);

        int result = bookingDAO.createBooking(booking);
        if (result == 1) {
            request.getSession().setAttribute("message", "Booking request submitted successfully.");
            response.sendRedirect(request.getContextPath() + "/customer/bookings");
            return;
        }

        forwardBookingError(request, response, bike, "Booking could not be created. Please try again.");
    }

    private Bike getBikeFromRequest(HttpServletRequest request) {
        try {
            return bikeDAO.getBikeById(Integer.parseInt(request.getParameter("bikeId")));
        } catch (Exception e) {
            return null;
        }
    }

    private void forwardBookingError(HttpServletRequest request, HttpServletResponse response, Bike bike, String error)
            throws ServletException, IOException {
        request.setAttribute("bike", bike);
        request.setAttribute("error", error);
        request.getRequestDispatcher("/customer/book-bike.jsp").forward(request, response);
    }
}
