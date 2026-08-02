package com.user.servlet;

import java.io.IOException;

import com.entity.user;
import com.DAO.UserDAO;
import com.DAO.UserDAOImpl;
import com.db.DBconnect;

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
        try {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");
            String confirm = req.getParameter("confirm_password");
            
            System.out.println(name + " " + email + " " + phone + " " + password);
            
            HttpSession session = req.getSession();
            if (name == null || !name.matches("[a-zA-Z\\s]+")) {
                session.setAttribute("error", "Name must contain only letters");
                resp.sendRedirect("register.jsp");
                return;
            }
            // Check password confirmation
            if (password == null || confirm == null || !password.equals(confirm)) {
                session.setAttribute("error", "Passwords do not match");
                resp.sendRedirect("register.jsp");
                return;
            }
            user us = new user();
            us.setName(name);
            us.setEmail(email);
            us.setPhone(phone);
            us.setPassword(password);

          
            UserDAO dao = new UserDAOImpl(DBconnect.getConn());
            boolean f = dao.userRegistre(us);

            if (f) {
                session.setAttribute("succMsg", "User Register Successfully");
                resp.sendRedirect("register.jsp");
            } else {
                session.setAttribute("error", "Some error occurred while registering user");
                resp.sendRedirect("register.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}