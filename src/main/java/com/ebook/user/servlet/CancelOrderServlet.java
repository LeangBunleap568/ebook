package com.ebook.user.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ebook.dao.impl.BookOrderDAOImpl;
import com.ebook.db.DBconnect;

@WebServlet("/cancel_order")
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String orderNo = req.getParameter("orderNo");

            BookOrderDAOImpl dao = new BookOrderDAOImpl(DBconnect.getConn());
            boolean f = dao.cancelOrder(orderNo);

            HttpSession session = req.getSession();
            if (f) {
                session.setAttribute("succMsg", "Order cancelled successfully!");
            } else {
                session.setAttribute("failedMsg", "Failed to cancel order!");
            }
            resp.sendRedirect(req.getContextPath() + "/user/order.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
