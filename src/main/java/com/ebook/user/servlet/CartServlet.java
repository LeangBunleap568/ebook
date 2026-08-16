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
import com.ebook.db.DBconnect;
import com.ebook.entity.BookDtls;
import com.ebook.entity.Cart;
import com.ebook.entity.user;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            user u = (user) session.getAttribute("userobj");

            if (u == null) {
                session.setAttribute("msg", "Please Login First");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            int bid = Integer.parseInt(request.getParameter("bid"));
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
            
            String referer = request.getHeader("referer");
            if(referer == null || referer.isEmpty()) {
                referer = "index.jsp";
            }
            
            // Check if book already exists in the cart
            boolean isBookExists = dao2.isBookInCart(bid, uid);
            
            if(isBookExists) {
                session.setAttribute("warnMsg", "Book already added to cart!");
                response.sendRedirect(referer);
                return;
            }

            boolean f = dao2.addCart(c);

            // Redirect back to recent books with success/error message
            if (f) {
                session.setAttribute("succMsg", "Book Added to Cart successfully!");
                response.sendRedirect(referer);
            } else {
                session.setAttribute("failedMsg", "Failed to add book to cart. Please try again.");
                response.sendRedirect(referer);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

