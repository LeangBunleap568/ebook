package com.ebook.user.servlet;

import java.io.IOException;

import com.ebook.dao.impl.BookOrderDAOImpl;
import com.ebook.db.DBconnect;
import com.ebook.entity.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cancelOrder")
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        user u = (user) session.getAttribute("userobj");

        // Guard: must be logged in
        if (u == null) {
            session.setAttribute("failedMsg", "Please login first.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String orderNo = request.getParameter("orderNo");

        if (orderNo == null || orderNo.trim().isEmpty()) {
            session.setAttribute("failedMsg", "Invalid order request.");
            response.sendRedirect(request.getContextPath() + "/user/my_orders.jsp");
            return;
        }

        // try {
        // BookOrderDAOImpl dao = new BookOrderDAOImpl(DBconnect.getConn());
        // boolean cancelled = dao.cancelOrder(orderNo.trim(), u.getEmail());

        // if (cancelled) {
        // session.setAttribute("succMsg", "Order #" + orderNo + " has been cancelled
        // successfully.");
        // } else {
        // session.setAttribute("failedMsg", "Unable to cancel Order #" + orderNo
        // + ". It may have already been cancelled or processed.");
        // }
        // } catch (Exception e) {
        // e.printStackTrace();
        // session.setAttribute("failedMsg", "Something went wrong: " + e.getMessage());
        // }

        // response.sendRedirect(request.getContextPath() + "/user/my_orders.jsp");
    }
}
