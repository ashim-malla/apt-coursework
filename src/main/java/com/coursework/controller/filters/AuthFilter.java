package com.coursework.controller.filters;

import com.coursework.model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/customer/*", "/staff/*", "/users/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String path = request.getServletPath();

        if (path.startsWith("/admin") || path.startsWith("/users")) {
            requireRole(user, "admin", request, response, chain);
        } else if (path.startsWith("/staff")) {
            requireRole(user, "staff", request, response, chain);
        } else if (path.startsWith("/customer")) {
            requireRole(user, "customer", request, response, chain);
        } else {
            chain.doFilter(request, response);
        }
    }

    private void requireRole(User user, String role, HttpServletRequest request, HttpServletResponse response,
                             FilterChain chain) throws IOException, ServletException {
        if (role.equals(user.getRole())) {
            chain.doFilter(request, response);
            return;
        }

        request.getRequestDispatcher("/WEB-INF/error/403.jsp").forward(request, response);
    }
}
