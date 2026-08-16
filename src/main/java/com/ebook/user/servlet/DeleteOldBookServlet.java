package com.ebook.user.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ebook.dao.impl.BookDAOImpl;
import com.ebook.db.DBconnect;

@WebServlet("/delete_old_book")
public class DeleteOldBookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("em");
        int id = Integer.parseInt(request.getParameter("id"));

        BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
        boolean f = dao.oldBookDelete(email, "Old", id);

        HttpSession session = request.getSession();

        if (f) {
            session.setAttribute("succMsg", "Book Deleted Successfully");
        } else {
            session.setAttribute("failedMsg", "Something went wrong. Please try again.");
        }
        response.sendRedirect(request.getContextPath() + "/user/old_book.jsp");
    }
}

