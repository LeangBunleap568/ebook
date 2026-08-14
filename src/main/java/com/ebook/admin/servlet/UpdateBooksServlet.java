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
import com.ebook.entity.BookDtls;

@WebServlet("/admin/updateBook")
public class UpdateBooksServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String bname = req.getParameter("bname");
            String author = req.getParameter("author");
            String price = req.getParameter("price");
            String status = req.getParameter("status");

            BookDtls b = new BookDtls();
            b.setBookId(id);
            b.setBookName(bname);
            b.setAuthor(author);
            b.setPrice(price);
            b.setStatus(status);

            BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
            boolean f = dao.updateEditBooks(b);

            HttpSession session = req.getSession();
            if (f) {
                session.setAttribute("succMsg", "Book Updated Successfully!");
                resp.sendRedirect(req.getContextPath() + "/admin/allBook.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong on server!");

                resp.sendRedirect(req.getContextPath() + "/admin/updateBook.jsp?id=" + id);
            }

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("failedMsg", "An unexpected error occurred.");
            resp.sendRedirect(req.getContextPath() + "/admin/allBook.jsp");
        }
    }
}