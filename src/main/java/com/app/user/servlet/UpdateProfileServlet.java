package com.app.user.servlet;

import java.io.IOException;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.app.dao.impl.UserDAOImpl;
import com.app.db.DBconnect;
import com.app.entity.user;

@WebServlet({"/update_profile", "/user/update_profile"})
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");

            HttpSession session = request.getSession();
            Connection conn = DBconnect.getConn();
            if (conn == null) {
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            UserDAOImpl dao = new UserDAOImpl(conn);

            boolean passOk = dao.checkPassword(id, password);

            if (passOk) {
                user us = new user();
                us.setId(id);
                us.setName(name);
                us.setEmail(email);
                us.setPhone(phone);

                boolean updated = dao.updateProfile(us);

                if (updated) {
                    // Refresh session object with updated data
                    user sessionUser = (user) session.getAttribute("userobj");
                    if (sessionUser != null) {
                        sessionUser.setName(name);
                        sessionUser.setEmail(email);
                        sessionUser.setPhone(phone);
                        session.setAttribute("userobj", sessionUser);
                    }
                    session.setAttribute("succMsg", "Profile Updated Successfully!");
                } else {
                    session.setAttribute("failedMsg", "Update failed. Please try again.");
                }
            } else {
                session.setAttribute("failedMsg", "Incorrect Password. Profile not updated.");
            }
            response.sendRedirect(request.getContextPath() + "/user/edit_profile.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/user/edit_profile.jsp");
        }
    }
}
