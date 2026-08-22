package com.app.user.servlet;

import java.io.IOException;
import java.sql.Connection;

import com.app.dao.UserDAO;
import com.app.dao.impl.UserDAOImpl;
import com.app.db.DBconnect;
import com.app.entity.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            email = (email != null) ? email.trim() : "";
            password = (password != null) ? password.trim() : "";

            if (email.isEmpty() || password.isEmpty()) {
                session.setAttribute("failedMsg", "Email and password are required.");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            System.out.println("Login attempt: email=[" + email + "]");

            Connection conn = DBconnect.getConn();
            if (conn == null) {
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            UserDAO dao = new UserDAOImpl(conn);
            user us = dao.login(email, password);

            if (us != null) {
                session.setAttribute("userobj", us);

                // Redirect admin users to the admin dashboard
                if ("admin@gmail.com".equalsIgnoreCase(us.getEmail())) {
                    response.sendRedirect(request.getContextPath() + "/admin/home");
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }
            } else {
                session.setAttribute("failedMsg", "Invalid email or password. Please try again.");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }

        } catch (Exception e) {
            System.out.println("LoginServlet Exception: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Login error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}
