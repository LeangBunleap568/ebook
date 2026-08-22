package com.app.user.servlet;

import java.io.IOException;
import java.sql.Connection;

import com.app.dao.impl.UserDAOImpl;
import com.app.db.DBconnect;
import com.app.entity.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/register", "/user/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm_password");

            name = (name != null) ? name.trim() : "";
            email = (email != null) ? email.trim() : "";
            phone = (phone != null) ? phone.trim() : "";
            password = (password != null) ? password.trim() : "";
            confirmPassword = (confirmPassword != null) ? confirmPassword.trim() : "";

            if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
                session.setAttribute("error", "Please fill in all required fields (Name, Email, Password).");
                response.sendRedirect(request.getContextPath() + "/register.jsp");
                return;
            }

            if (!confirmPassword.isEmpty() && !password.equals(confirmPassword)) {
                session.setAttribute("error", "Passwords do not match. Please verify and try again.");
                response.sendRedirect(request.getContextPath() + "/register.jsp");
                return;
            }

            // Build user entity
            user us = new user();
            us.setName(name);
            us.setEmail(email);
            us.setPhone(phone);
            us.setPassword(password);

            Connection conn = DBconnect.getConn();
            if (conn == null) {
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            UserDAOImpl dao = new UserDAOImpl(conn);

            if (dao.checkUser(email)) {
                session.setAttribute("error", "This email (" + email + ") is already registered. Please use a different email or sign in.");
                response.sendRedirect(request.getContextPath() + "/register.jsp");
                return;
            }

            dao.userRegistre(us);

            session.setAttribute("succMsg", "Registration successful! Welcome, " + name + ". Please sign in.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            String msg = (e.getMessage() != null) ? e.getMessage() : e.getClass().getName();
            session.setAttribute("error", "Registration error: " + msg);
            response.sendRedirect(request.getContextPath() + "/register.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/register.jsp");
    }
}
