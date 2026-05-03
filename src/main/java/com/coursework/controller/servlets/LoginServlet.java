package com.coursework.controller.servlets;

import com.coursework.dao.UserDAO;
import com.coursework.model.User;
import com.coursework.utilities.PasswordUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String identifier = request.getParameter("identifier"); // email or user_id
        String password = request.getParameter("password");

        if (identifier == null || identifier.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Please fill in all fields!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByIdentifier(identifier);

        if (user == null) {
            request.setAttribute("error", "User not found!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (!PasswordUtil.checkPassword(password, user.getPassword())) {
            request.setAttribute("error", "Invalid password!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Create session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole());
        session.setAttribute("userId", user.getUserId());

        // Role based redirect
        switch (user.getRole()) {
            case "admin":
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
            case "staff":
                response.sendRedirect(request.getContextPath() + "/staff/dashboard");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/customer/dashboard");
                break;
        }
    }
}