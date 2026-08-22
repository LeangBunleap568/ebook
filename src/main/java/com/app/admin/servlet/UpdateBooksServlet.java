package com.app.admin.servlet;

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
import com.app.entity.BookDtls;

@WebServlet("/admin/updateBook")
public class UpdateBooksServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String bname  = request.getParameter("bname");
            String author = request.getParameter("author");
            String price  = request.getParameter("price");
            String status = request.getParameter("status");

            // Backend validation: price must be at least $2.50
            double priceVal = 0;
            try {
                priceVal = Double.parseDouble(price);
            } catch (Exception e) {
                priceVal = 0;
            }
            if (priceVal < 2.50) {
                session.setAttribute("failedMsg", "Invalid price! Price must be at least $2.50.");
                response.sendRedirect(request.getContextPath() + "/admin/edit_books.jsp?id=" + id);
                return;
            }

            BookDtls b = new BookDtls();
            b.setBookId(id);
            b.setBookName(bname);
            b.setAuthor(author);
            b.setPrice(price);
            b.setStatus(status);

            Connection conn = DBconnect.getConn();
            if (conn == null) {
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            BookDAOImpl dao = new BookDAOImpl(conn);
            boolean f = dao.updateEditBooks(b);

            if (f) {
                session.setAttribute("succMsg", "Book Updated Successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/all_books.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong on server!");
                response.sendRedirect(request.getContextPath() + "/admin/edit_books.jsp?id=" + id);
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "An unexpected error occurred.");
            response.sendRedirect(request.getContextPath() + "/admin/all_books.jsp");
        }
    }
}
