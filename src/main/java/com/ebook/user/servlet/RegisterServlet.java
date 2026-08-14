package com.ebook.user.servlet;

import java.io.IOException;

import com.ebook.dao.impl.UserDAOImpl;
import com.db.DBconnect;
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
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");

            // Build user entity
            user us = new user();
            us.setName(name != null ? name.trim() : "");
            us.setEmail(email != null ? email.trim() : "");
            us.setPhone(phone != null ? phone.trim() : "");
            us.setPassword(password != null ? password : "");

            // Save to DB — throws exception on any failure
            UserDAOImpl dao = new UserDAOImpl(DBconnect.getConn());

            // Check for duplicate email
            if (dao.checkUser(email != null ? email.trim() : "")) {
                session.setAttribute("error", "This email is already registered. Please use a different email or login.");
                resp.sendRedirect(req.getContextPath() + "/register.jsp");
                return;
            }

            dao.userRegistre(us);

            // If we reach here, insert was successful
            session.setAttribute("succMsg", "Registration successful! Please log in.");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");

        } catch (Exception e) {
            // Print the FULL cause chain so we can see the real MySQL error
            System.out.println("========================================");
            System.out.println("❌ RegisterServlet error: " + e.getMessage());
            Throwable cause = e.getCause();
            while (cause != null) {
                System.out.println("   Caused by: " + cause.getMessage());
                cause = cause.getCause();
            }
            e.printStackTrace();
            System.out.println("========================================");

            String msg = (e.getMessage() != null) ? e.getMessage() : e.getClass().getName();
            session.setAttribute("error", msg);
            resp.sendRedirect(req.getContextPath() + "/register.jsp");
        }
    }
}