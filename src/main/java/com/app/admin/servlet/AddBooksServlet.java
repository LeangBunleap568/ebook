package com.app.admin.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;

import com.app.dao.impl.BookDAOImpl;
import com.app.db.DBconnect;
import com.app.entity.BookDtls;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/admin/add_books")
@MultipartConfig
public class AddBooksServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            String bookName = request.getParameter("bname");
            String author = request.getParameter("author");
            String price = request.getParameter("price");
            String categories = request.getParameter("categories");
            String status = request.getParameter("status");
            Part part = request.getPart("bimg");
            String fileName = (part != null) ? part.getSubmittedFileName() : "";

            // Validate image existence
            if (part == null || fileName == null || fileName.trim().isEmpty() || part.getSize() == 0) {
                session.setAttribute("failedMsg", "Please select a book image!");
                response.sendRedirect(request.getContextPath() + "/admin/add_books.jsp");
                return;
            }

            // Validate price constraint (minimum $2.50)
            double priceVal = 0;
            try {
                priceVal = Double.parseDouble(price);
            } catch (Exception e) {
                priceVal = 0;
            }

            if (priceVal < 2.50) {
                session.setAttribute("failedMsg", "Invalid price! Price must be at least $2.50.");
                response.sendRedirect(request.getContextPath() + "/admin/add_books.jsp");
                return;
            }

            // Save book to database
            BookDtls b = new BookDtls(bookName, author, price, categories, status, fileName, "admin@gmail.com");

            Connection conn = DBconnect.getConn();
            if (conn == null) {
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            BookDAOImpl dao = new BookDAOImpl(conn);
            boolean f = dao.addBooks(b);

            if (f) {
                // Save uploaded image to webapp book directory (matches JSP image serving path)
                String path = getServletContext().getRealPath("") + "book";
                File file = new File(path);
                if (!file.exists()) {
                    file.mkdirs();
                }
                part.write(path + File.separator + fileName);

                session.setAttribute("succMsg", "Book Added Successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/add_books.jsp");
            } else {
                session.setAttribute("failedMsg", "Failed to Add Book. Please try again.");
                response.sendRedirect(request.getContextPath() + "/admin/add_books.jsp");
            }

        } catch (Exception e) {
            System.out.println("BooksAdd Exception: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("failedMsg", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/add_books.jsp");
        }
    }
}
