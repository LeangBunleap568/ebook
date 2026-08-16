package com.ebook.user.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ebook.dao.impl.CartDAOImpl;
import com.ebook.db.DBconnect;

@WebServlet("/remove_cart")
public class RemoveCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String cidStr = request.getParameter("cid");
            String uidStr = request.getParameter("uid");

            HttpSession session = request.getSession();

            if (cidStr != null && uidStr != null) {
                int cid = Integer.parseInt(cidStr);
                int uid = Integer.parseInt(uidStr);

                CartDAOImpl dao = new CartDAOImpl(DBconnect.getConn());

                // ត្រូវប្រាកដថាឈ្មោះ Method ក្នុង CartDAOImpl របស់អ្នកគឺ removeBook ឬ
                // deleteBook
                boolean f = dao.removeBook(cid, uid);

                if (f) {
                    session.setAttribute("succMsg", "Book Removed from Cart successfully!");
                } else {
                    session.setAttribute("failedMsg", "Failed to remove book from cart.");
                }
            } else {
                session.setAttribute("failedMsg", "Invalid Request Parameters.");
            }

            // Redirect ទៅកាន់ user/cart.jsp ដោយប្រើ absolute path ឬ relative path
            // ត្រឹមត្រូវ
            response.sendRedirect(request.getContextPath() + "/user/cart.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
        }
    }
}
