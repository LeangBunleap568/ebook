package com.ebook.user.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ebook.dao.impl.BookDAOImpl;
import com.ebook.dao.impl.CartDAOImpl;
import com.db.DBconnect;
import com.entity.BookDtls;
import com.entity.Cart;
import com.entity.user;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession();
            user u = (user) session.getAttribute("userobj");

            if (u == null) {
                session.setAttribute("msg", "Please Login First");
                resp.sendRedirect("login.jsp");
                return;
            }

            int bid = Integer.parseInt(req.getParameter("bid"));
            int uid = u.getId();

            BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
            BookDtls b = dao.getBookById(bid);

            Cart c = new Cart();
            c.setBid(bid);
            c.setUid(uid);
            c.setBookName(b.getBookName());
            c.setAuthor(b.getAuthor());
            c.setPrice(Double.parseDouble(b.getPrice()));
            c.setTotalPrice(Double.parseDouble(b.getPrice()));

            CartDAOImpl dao2 = new CartDAOImpl(DBconnect.getConn());
            boolean f = dao2.addCart(c);

            if (f) {
                session.setAttribute("addCart", "Book Added to cart");
                resp.sendRedirect("index.jsp");
            } else {
                session.setAttribute("failed", "Something wrong on server");
                resp.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
