package com.ebook.user.servlet;

import java.io.IOException;

import com.ebook.dao.impl.UserDAOImpl;
import com.ebook.db.DBconnect;
import com.ebook.entity.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");

            // Build user entity
            user us = new user();
            us.setName(name != null ? name.trim() : "");
            us.setEmail(email != null ? email.trim() : "");
            us.setPhone(phone != null ? phone.trim() : "");
            us.setPassword(password != null ? password : "");

            // Save to DB â€” throws exception on any failure
            UserDAOImpl dao = new UserDAOImpl(DBconnect.getConn());

            if (dao.checkUser(email != null ? email.trim() : "")) {
                session.setAttribute("error", "This email is already registered. Please use a different email or login.");
                response.sendRedirect(request.getContextPath() + "/register.jsp");
                return;
            }

            dao.userRegistre(us);

            // If we reach here, insert was successful
            session.setAttribute("succMsg", "Registration successful! Please log in.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");

        } catch (Exception e) {
            // Print the FULL cause chain so we can see the real MySQL error
            System.out.println("========================================");
            System.out.println("âŒ RegisterServlet error: " + e.getMessage());
            Throwable cause = e.getCause();
            while (cause != null) {
                System.out.println("   Caused by: " + cause.getMessage());
                cause = cause.getCause();
            }
            e.printStackTrace();
            System.out.println("========================================");

            String msg = (e.getMessage() != null) ? e.getMessage() : e.getClass().getName();
            session.setAttribute("error", msg);
            response.sendRedirect(request.getContextPath() + "/register.jsp");
        }
    }
}
