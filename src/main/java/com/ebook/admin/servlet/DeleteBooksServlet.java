package com.ebook.admin.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ebook.dao.impl.BookDAOImpl;
import com.ebook.db.DBconnect;

@WebServlet("/admin/deleteBook")
public class DeleteBooksServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
            boolean f = dao.deleteBooks(id);
            
            HttpSession session = request.getSession();
            if (f) {
                session.setAttribute("succMsg", "Book Deleted Successfully!");
            } else {
                session.setAttribute("failedMsg", "Failed to delete the book!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/allBook.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("failedMsg", "An unexpected error occurred while deleting.");
            response.sendRedirect(request.getContextPath() + "/admin/allBook.jsp");
        }
    }
}

