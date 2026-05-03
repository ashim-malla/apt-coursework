package com.coursework.controller.servlets;

import com.coursework.dao.UserDAO;
import com.coursework.utilities.PasswordUtil;
import com.coursework.utilities.ValidationUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String name = request.getParameter("name");
        final String email = request.getParameter("email");
        final String phone = request.getParameter("phone");
        final String license = request.getParameter("license_number");
        final String password = request.getParameter("password");

        String error = "";
        boolean isValidName = !ValidationUtil.isNullOrEmpty(name)
                && ValidationUtil.isAlphanumericStartingWithLetter(name)
                && name.length() > 5;
        boolean isValidEmail = ValidationUtil.isValidEmail(email);
        boolean isValidPassword = ValidationUtil.isValidPassword(password);

        if (!isValidName) error += "Invalid name! ";
        if (!isValidEmail) error += "Invalid email! ";
        if (!isValidPassword) error += "Invalid password! ";

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        String hashedPassword = PasswordUtil.getHashPassword(password);
        String role = "customer";

        UserDAO userDAO = new UserDAO();
        int check = userDAO.insertUser(name, hashedPassword, email, phone, license, role);

        switch (check) {
            case 1:
                response.sendRedirect(request.getContextPath() + "/login");
                break;
            case 2:
                request.setAttribute("error", "User or Email already exists!");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                break;
            default:
                response.getWriter().println("Server error!");
                break;
        }
    }
}