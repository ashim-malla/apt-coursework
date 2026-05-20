package com.coursework.controller.servlets;

import com.coursework.dao.BikeDAO;
import com.coursework.model.Bike;
import com.coursework.utilities.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet(name = "AdminBikeServlet", urlPatterns = {"/admin/bikes"})
public class AdminBikeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final BikeDAO bikeDAO = new BikeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String editId = request.getParameter("editId");
        if (editId != null) {
            try {
                request.setAttribute("editBike", bikeDAO.getBikeById(Integer.parseInt(editId)));
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid bike selected.");
            }
        }

        request.setAttribute("bikes", bikeDAO.getAllBikes());
        request.getRequestDispatcher("/users/adminBikes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteBike(request, response);
            return;
        }

        Bike bike = buildBikeFromRequest(request);
        String error = validateBike(bike);

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.setAttribute("editBike", bike);
            request.setAttribute("bikes", bikeDAO.getAllBikes());
            request.getRequestDispatcher("/users/adminBikes.jsp").forward(request, response);
            return;
        }

        int result;
        if ("update".equals(action)) {
            if (bikeDAO.registrationExistsForAnotherBike(bike.getRegistrationNumber(), bike.getBikeId())) {
                forwardWithError(request, response, bike, "Bike registration number already exists.");
                return;
            }
            result = bikeDAO.updateBike(bike);
            request.getSession().setAttribute("message", getBikeResultMessage(result, "Bike updated successfully.", "Bike could not be updated. Please check the database schema and try again."));
        } else {
            if (bikeDAO.registrationExists(bike.getRegistrationNumber())) {
                forwardWithError(request, response, bike, "Bike registration number already exists.");
                return;
            }
            result = bikeDAO.insertBike(bike);
            request.getSession().setAttribute("message", getBikeResultMessage(result, "Bike added successfully.", "Bike could not be added. Please check the database schema and try again."));
        }

        response.sendRedirect(request.getContextPath() + "/admin/bikes");
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, Bike bike, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        request.setAttribute("editBike", bike);
        request.setAttribute("bikes", bikeDAO.getAllBikes());
        request.getRequestDispatcher("/users/adminBikes.jsp").forward(request, response);
    }

    private String getBikeResultMessage(int result, String successMessage, String failureMessage) {
        if (result == BikeDAO.SUCCESS) {
            return successMessage;
        }
        if (result == BikeDAO.DUPLICATE_REGISTRATION) {
            return "Bike registration number already exists.";
        }
        return failureMessage;
    }

    private void deleteBike(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int bikeId = Integer.parseInt(request.getParameter("bikeId"));
            bikeDAO.deleteBike(bikeId);
            request.getSession().setAttribute("message", "Bike deleted successfully.");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("message", "Invalid bike selected.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/bikes");
    }

    private Bike buildBikeFromRequest(HttpServletRequest request) {
        Bike bike = new Bike();
        String bikeId = request.getParameter("bikeId");
        if (!ValidationUtil.isNullOrEmpty(bikeId)) {
            try {
                bike.setBikeId(Integer.parseInt(bikeId));
            } catch (NumberFormatException e) {
                bike.setBikeId(0);
            }
        }

        bike.setName(clean(request.getParameter("name")));
        bike.setBrand(clean(request.getParameter("brand")));
        bike.setType(clean(request.getParameter("type")));
        bike.setRegistrationNumber(clean(request.getParameter("registrationNumber")));
        bike.setStatus(clean(request.getParameter("status")));
        bike.setDescription(clean(request.getParameter("description")));

        try {
            bike.setPricePerDay(new BigDecimal(request.getParameter("pricePerDay")));
        } catch (Exception e) {
            bike.setPricePerDay(BigDecimal.ZERO);
        }

        return bike;
    }

    private String clean(String value) {
        return value == null ? null : value.trim();
    }

    private String validateBike(Bike bike) {
        StringBuilder error = new StringBuilder();

        if (ValidationUtil.isNullOrEmpty(bike.getName())) {
            error.append("Bike name is required. ");
        }
        if (ValidationUtil.isNullOrEmpty(bike.getBrand())) {
            error.append("Brand is required. ");
        }
        if (ValidationUtil.isNullOrEmpty(bike.getType())) {
            error.append("Type is required. ");
        }
        if (ValidationUtil.isNullOrEmpty(bike.getRegistrationNumber())) {
            error.append("Registration number is required. ");
        }
        if (bike.getPricePerDay() == null || bike.getPricePerDay().compareTo(BigDecimal.ZERO) <= 0) {
            error.append("Price per day must be greater than zero. ");
        }
        if (ValidationUtil.isNullOrEmpty(bike.getStatus())) {
            error.append("Status is required. ");
        }

        return error.toString();
    }
}
