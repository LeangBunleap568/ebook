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

@WebServlet({"/user/cancel_order", "/admin/cancel_order"})
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String uri = request.getRequestURI();
        boolean isAdmin = uri != null && uri.contains("/admin/");
        String email = request.getParameter("email");
        String returnUrl = request.getParameter("returnUrl");

        try {
            String orderNo = request.getParameter("orderNo");
            if (orderNo == null || orderNo.trim().isEmpty()) {
                session.setAttribute("failedMsg", "Invalid order number.");
                redirectBack(request, response, isAdmin, email, returnUrl);
                return;
            }

            Connection conn = DBconnect.getConn();
            if (conn == null) {
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }

            BookOrderDAOImpl dao = new BookOrderDAOImpl(conn);
            String action = request.getParameter("action");

            if ("delete".equalsIgnoreCase(action) && isAdmin) {
                boolean f = dao.deleteOrderByOrderNo(orderNo.trim());
                if (f) {
                    session.setAttribute("succMsg", "Order #" + orderNo + " deleted successfully!");
                } else {
                    session.setAttribute("failedMsg", "Failed to delete order #" + orderNo + ".");
                }
            } else {
                boolean f = dao.cancelOrder(orderNo.trim());
                if (f) {
                    session.setAttribute("succMsg", "Order #" + orderNo + " cancelled successfully! Total revenue updated.");
                } else {
                    session.setAttribute("failedMsg", "Failed to cancel order #" + orderNo + ".");
                }
            }

            redirectBack(request, response, isAdmin, email, returnUrl);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "Error processing order: " + e.getMessage());
            redirectBack(request, response, isAdmin, email, returnUrl);
        }
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response, boolean isAdmin, String email, String returnUrl) throws IOException {
        if (returnUrl != null && !returnUrl.trim().isEmpty() && !returnUrl.startsWith("http")) {
            response.sendRedirect(request.getContextPath() + returnUrl);
        } else if (isAdmin) {
            if (email != null && !email.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/order_details.jsp?email=" + java.net.URLEncoder.encode(email.trim(), "UTF-8"));
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/orders.jsp");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/user/order.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
