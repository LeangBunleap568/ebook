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

@WebServlet("/user/register")
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

            Connection conn = DBconnect.getConn();
            if (conn == null) {
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            UserDAOImpl dao = new UserDAOImpl(conn);

            if (dao.checkUser(email != null ? email.trim() : "")) {
                session.setAttribute("error", "This email is already registered. Please use a different email or login.");
                response.sendRedirect(request.getContextPath() + "/register.jsp");
                return;
            }

            dao.userRegistre(us);

            session.setAttribute("succMsg", "Registration successful! Please log in.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            String msg = (e.getMessage() != null) ? e.getMessage() : e.getClass().getName();
            session.setAttribute("error", msg);
            response.sendRedirect(request.getContextPath() + "/register.jsp");
        }
    }
}
