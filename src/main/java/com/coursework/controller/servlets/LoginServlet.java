package com.coursework.controller.servlets;

import com.coursework.dao.UserDAO;
import com.coursework.model.User;
import com.coursework.utilities.PasswordUtil;

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
		// Read saved email cookie
        String savedEmail = "";
        boolean rememberMe = false;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("savedEmail")) {
                    savedEmail = c.getValue();
                    rememberMe = true;
                }
            }
        }

        request.setAttribute("savedEmail", savedEmail);
        request.setAttribute("rememberMe", rememberMe);
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String identifier = request.getParameter("identifier"); // email or user_id
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");


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

        if (!"active".equals(user.getAccountStatus()) && !"admin".equals(user.getRole())) {
            request.setAttribute("error", "Your account is waiting for admin approval.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
     // Handle Remember Me cookie
        if ("on".equals(rememberMe)) {
            // Save email in cookie for 7 days
            Cookie emailCookie = new Cookie("savedEmail", identifier);
            emailCookie.setMaxAge(7 * 24 * 60 * 60);
            emailCookie.setPath("/");
            response.addCookie(emailCookie);
        } else {
            // Delete cookie if unchecked
            Cookie emailCookie = new Cookie("savedEmail", "");
            emailCookie.setMaxAge(0);
            emailCookie.setPath("/");
            response.addCookie(emailCookie);
        }

        // Create session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole());
        session.setAttribute("userId", user.getUserId());

        // Role based redirect
        switch (user.getRole()) {
            case "admin":
                response.sendRedirect(request.getContextPath() + "/home");
                break;
            case "staff":
                response.sendRedirect(request.getContextPath() + "/staff/dashboard");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/home");
                break;
        }
    }
}
