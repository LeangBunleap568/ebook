package com.admin.servlet;

import java.io.File;
import java.io.IOException;

import com.DAO.BookDAOImpl;
import com.db.DBconnect;
import com.entity.BookDtls;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/addBooks")
@MultipartConfig
public class AddBooksServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        try {
            String bookName = req.getParameter("bname");
            String author = req.getParameter("author");
            String price = req.getParameter("price");
            String categories = req.getParameter("categories");
            String status = req.getParameter("status");
            Part part = req.getPart("bimg");
            String fileName = (part != null) ? part.getSubmittedFileName() : "";

            // Validate image existence
            if (part == null || fileName == null || fileName.trim().isEmpty() || part.getSize() == 0) {
                session.setAttribute("failedMsg", "Please select a book image!");
                resp.sendRedirect(req.getContextPath() + "/admin/addBook.jsp");
                return;
            }

            // Validate price constraint (minimum 10000)
            double priceVal = 0;
            try {
                priceVal = Double.parseDouble(price);
            } catch (Exception e) {
                priceVal = 0;
            }

            if (priceVal < 10000) {
                session.setAttribute("failedMsg", "Invalid price! Must be at least 10,000.");
                resp.sendRedirect(req.getContextPath() + "/admin/addBook.jsp");
                return;
            }

            // Save book to database
            BookDtls b = new BookDtls(bookName, author, price, categories, status, fileName, "admin@gmail.com");

            BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
            boolean f = dao.addBooks(b);

            if (f) {
                // Save uploaded image to webapp img directory
                String path = getServletContext().getRealPath("") + "img";
                File file = new File(path);
                if (!file.exists()) {
                    file.mkdirs();
                }
                part.write(path + File.separator + fileName);

                session.setAttribute("succMsg", "Book Added Successfully!");
                resp.sendRedirect(req.getContextPath() + "/admin/addBook.jsp");
            } else {
                session.setAttribute("failedMsg", "Failed to Add Book. Please try again.");
                resp.sendRedirect(req.getContextPath() + "/admin/addBook.jsp");
            }

        } catch (Exception e) {
            System.out.println("BooksAdd Exception: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("failedMsg", "Error: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/admin/addBook.jsp");
        }
    }
}