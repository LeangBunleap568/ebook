package com.app.user.servlet;

import java.io.IOException;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.app.dao.impl.BookOrderDAOImpl;
import com.app.db.DBconnect;

@WebServlet("/user/cancel_order")
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String orderNo = request.getParameter("orderNo");

            Connection conn = DBconnect.getConn();
            if (conn == null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            BookOrderDAOImpl dao = new BookOrderDAOImpl(conn);
            boolean f = dao.cancelOrder(orderNo);

            HttpSession session = request.getSession();
            if (f) {
                session.setAttribute("succMsg", "Order cancelled successfully!");
            } else {
                session.setAttribute("failedMsg", "Failed to cancel order!");
            }
            response.sendRedirect(request.getContextPath() + "/user/order.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/user/order.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
