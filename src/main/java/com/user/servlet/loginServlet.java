package com.user.servlet;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class loginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            if (email != null) {
                email = email.trim();
            } else {
                email = "";
            }
            if (password != null) {
                password = password.trim();
            } else {
                password = "";
            }

            String adminEmail = "admin@gmail.com";
            String adminUser = "admin";
            String adminPassword = "admin";
            boolean isAdmin = adminPassword.equals(password)
                    && (adminEmail.equalsIgnoreCase(email) || adminUser.equalsIgnoreCase(email));

            System.out.println("Login attempt email=[" + email + "] password=[" + password + "] admin=[" + isAdmin + "]");
            if (isAdmin) {
                resp.sendRedirect(req.getContextPath() + "/admin/home.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home.jsp");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
            
    }
    
}