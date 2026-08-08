package com.user.servlet;

import java.io.IOException;

import com.DAO.UserDAO;
import com.DAO.UserDAOImpl;
import com.db.DBconnect;
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
            String email    = req.getParameter("email");
            String password = req.getParameter("password");

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
                    resp.sendRedirect(req.getContextPath() + "/admin/home.jsp");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/index.jsp");
                }
            } else {
                session.setAttribute("failedMsg", "Invalid email or password. Please try again.");
                resp.sendRedirect(req.getContextPath() + "/login.jsp");
            }

        } catch (Exception e) {
            System.out.println("loginServlet Exception: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("error", "Login error: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
}