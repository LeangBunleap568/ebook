package com.ebook.user.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ebook.dao.impl.UserDAOImpl;
import com.ebook.db.DBconnect;
import com.ebook.entity.user;

@WebServlet("/update_profile")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");

        HttpSession session = req.getSession();
        UserDAOImpl dao = new UserDAOImpl(DBconnect.getConn());

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
                sessionUser.setName(name);
                sessionUser.setEmail(email);
                sessionUser.setPhone(phone);
                session.setAttribute("userobj", sessionUser);
                session.setAttribute("succMsg", "Profile Updated Successfully!");
            } else {
                session.setAttribute("failedMsg", "Update failed. Please try again.");
            }
        } else {
            session.setAttribute("failedMsg", "Incorrect Password. Profile not updated.");
        }
        resp.sendRedirect("user/edit_profile.jsp");
    }
}
