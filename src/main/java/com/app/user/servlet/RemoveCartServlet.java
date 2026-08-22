package com.app.user.servlet;

import java.io.IOException;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.app.dao.impl.CartDAOImpl;
import com.app.db.DBconnect;

@WebServlet({"/remove_cart", "/user/remove_cart"})
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

                Connection conn = DBconnect.getConn();
                if (conn == null) {
                    session.setAttribute("failedMsg", "Database connection failed.");
                    response.sendRedirect(request.getContextPath() + "/error.jsp");
                    return;
                }
                CartDAOImpl dao = new CartDAOImpl(conn);

                boolean f = dao.removeBook(cid, uid);

                if (f) {
                    session.setAttribute("succMsg", "Book Removed from Cart successfully!");
                } else {
                    session.setAttribute("failedMsg", "Failed to remove book from cart.");
                }
            } else {
                session.setAttribute("failedMsg", "Invalid Request Parameters.");
            }

            response.sendRedirect(request.getContextPath() + "/user/cart.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
