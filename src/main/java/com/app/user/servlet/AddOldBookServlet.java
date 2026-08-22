package com.app.user.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.app.dao.impl.BookDAOImpl;
import com.app.db.DBconnect;
import com.app.entity.BookDtls;

@WebServlet({"/add_old_book", "/user/add_old_book"})
@MultipartConfig
public class AddOldBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String bookName = request.getParameter("bname");
            String author = request.getParameter("author");
            String price = request.getParameter("price");
            String categories = "Old";
            String status = "Active";
            String email = request.getParameter("email");
            Part part = request.getPart("bimg");
            String fileName = (part != null) ? part.getSubmittedFileName() : "";

            BookDtls b = new BookDtls(bookName, author, price, categories, status, fileName, email);

            Connection conn = DBconnect.getConn();
            if (conn == null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            BookDAOImpl dao = new BookDAOImpl(conn);
            boolean f = dao.addBooks(b);

            HttpSession session = request.getSession();

            if (f) {
                if (part != null && !fileName.isEmpty()) {
                    String path = getServletContext().getRealPath("") + "book";
                    File dir = new File(path);
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }
                    part.write(path + File.separator + fileName);
                }
                session.setAttribute("succMsg", "Book Published Successfully");
                response.sendRedirect(request.getContextPath() + "/user/sell_book.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong on server");
                response.sendRedirect(request.getContextPath() + "/user/sell_book.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
