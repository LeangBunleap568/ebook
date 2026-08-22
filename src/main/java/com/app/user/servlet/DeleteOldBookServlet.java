package com.app.user.servlet;

import java.io.IOException;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.app.dao.impl.BookDAOImpl;
import com.app.db.DBconnect;

@WebServlet("/user/delete_old_book")
public class DeleteOldBookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String email = request.getParameter("em");
            int id = Integer.parseInt(request.getParameter("id"));

            Connection conn = DBconnect.getConn();
            if (conn == null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            BookDAOImpl dao = new BookDAOImpl(conn);
            boolean f = dao.oldBookDelete(email, "Old", id);

            HttpSession session = request.getSession();

            if (f) {
                session.setAttribute("succMsg", "Book Deleted Successfully");
            } else {
                session.setAttribute("failedMsg", "Something went wrong. Please try again.");
            }
            response.sendRedirect(request.getContextPath() + "/user/old_book.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/user/old_book.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
