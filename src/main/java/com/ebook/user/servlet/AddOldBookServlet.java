package com.ebook.user.servlet;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.ebook.dao.impl.BookDAOImpl;
import com.db.DBconnect;
import com.entity.BookDtls;

@WebServlet("/add_old_book")
@MultipartConfig
public class AddOldBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String bookName = req.getParameter("bname");
            String author = req.getParameter("author");
            String price = req.getParameter("price");
            String categories = "Old";
            String status = "Active";
            String email = req.getParameter("email");
            Part part = req.getPart("bimg");
            String fileName = part.getSubmittedFileName();

            BookDtls b = new BookDtls(bookName, author, price, categories, status, fileName, email);

            BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
            boolean f = dao.addBooks(b);

            HttpSession session = req.getSession();

            if (f) {
                // Since the web pages expect images to be in the "book" directory,
                // we'll save it to "book" instead of "sell_book" so images load properly
                // on view_books.jsp and all_old_book.jsp.
                String path = getServletContext().getRealPath("") + "book";
                File dir = new File(path);
                if (!dir.exists()) {
                    dir.mkdir();
                }
                part.write(path + File.separator + fileName);

                session.setAttribute("succMsg", "Book Published Successfully");
                resp.sendRedirect("sell_book.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong on server");
                resp.sendRedirect("sell_book.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
