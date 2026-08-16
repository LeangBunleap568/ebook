package com.ebook.user.servlet;

import java.io.IOException;

import com.ebook.dao.UserDAO;
import com.ebook.dao.impl.UserDAOImpl;
import com.ebook.db.DBconnect;
import com.ebook.entity.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class loginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            String email    = request.getParameter("email");
            String password = request.getParameter("password");

            email    = (email    != null) ? email.trim()    : "";
            password = (password != null) ? password.trim() : "";

            System.out.println("Login attempt: email=[" + email + "]");

            // Query the database
            UserDAO dao = new UserDAOImpl(DBconnect.getConn());
            user us = dao.login(email, password);

            if (us != null) {
                session.setAttribute("userobj", us);

                // Redirect admin users to the admin dashboard
                if ("admin@gmail.com".equalsIgnoreCase(us.getEmail())) {
                    response.sendRedirect(request.getContextPath() + "/admin/home.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }
            } else {
                session.setAttribute("failedMsg", "Invalid email or password. Please try again.");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }

        } catch (Exception e) {
            System.out.println("loginServlet Exception: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Login error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}
