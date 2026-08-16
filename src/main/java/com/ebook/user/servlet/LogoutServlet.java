package com.ebook.user.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            session.removeAttribute("userobj");
            
            HttpSession session2 = request.getSession();
            session2.setAttribute("succMsg", "Logout Successfully!");
            
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

