package com.coursework.controller.servlets;

import com.coursework.dao.BikeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CustomerBikeServlet", urlPatterns = {"/customer/bikes"})
public class CustomerBikeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BikeDAO bikeDAO = new BikeDAO();
        request.setAttribute("availableBikes", bikeDAO.getAvailableBikes());
        request.getRequestDispatcher("/customer/bikes.jsp").forward(request, response);
    }
}
