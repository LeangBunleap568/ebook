package com.user.servlet;

import java.io.IOException;


import com.entity.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class loginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        try {
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            email = (email != null) ? email.trim() : "";
            password = (password != null) ? password.trim() : "";

            System.out.println("Login attempt email=[" + email + "]");

            if ("admin@gmail.com".equals(email)) {
                user adminUser = new user();
                adminUser.setName("Admin");
                adminUser.setEmail(email);
                session.setAttribute("userobj", adminUser);
                resp.sendRedirect(req.getContextPath() + "/admin/home.jsp");
            } else {
                user normalUser = new user();
                normalUser.setName("User"); // Or extract name from email prefix
                normalUser.setEmail(email);
                session.setAttribute("userobj", normalUser);
                resp.sendRedirect(req.getContextPath() + "/index.jsp");
            }
        } catch (Exception e) {
            System.out.println("loginServlet Exception: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Login error: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
}