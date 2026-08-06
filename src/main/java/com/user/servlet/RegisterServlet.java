package com.user.servlet;

import java.io.IOException;

import com.entity.user;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        try {
            // Fetch form parameters
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            String confirm = req.getParameter("confirm_password");

            // Validate name
            if (name == null || name.trim().isEmpty() || !name.matches("[a-zA-Z\\s]+")) {
                session.setAttribute("error", "Name must contain only letters");
                resp.sendRedirect("register.jsp");
                return;
            }

            // Validate password match
            if (password == null || confirm == null || !password.equals(confirm)) {
                session.setAttribute("error", "Passwords do not match");
                resp.sendRedirect("register.jsp");
                return;
            }

            // Build user entity
            user us = new user();
            us.setName(name.trim());
            us.setEmail(email.trim());
            us.setPhone(phone);
            us.setPassword(password);

            // Insert into database (removed as per instructions)
            // Just simulate success
            boolean success = true;

            if (success) {
                session.setAttribute("succMsg", "User Registered Successfully");
                resp.sendRedirect("register.jsp");
            } else {
                session.setAttribute("error", "Registration failed. Email may already exist.");
                resp.sendRedirect("register.jsp");
            }

        } catch (Exception e) {
            System.out.println("RegisterServlet Exception: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Registration error: " + e.getMessage());
            resp.sendRedirect("register.jsp");
        }
    }
}