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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("em");
        int id = Integer.parseInt(req.getParameter("id"));

        BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
        boolean f = dao.oldBookDelete(email, "Old", id);

        HttpSession session = req.getSession();

        if (f) {
            session.setAttribute("succMsg", "Book Deleted Successfully");
        } else {
            session.setAttribute("failedMsg", "Something went wrong. Please try again.");
        }
        resp.sendRedirect("user/old_book.jsp");
    }
}
