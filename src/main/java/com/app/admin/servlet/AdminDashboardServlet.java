package com.app.admin.servlet;

import java.io.IOException;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.app.dao.impl.BookDAOImpl;
import com.app.dao.impl.BookOrderDAOImpl;
import com.app.dao.impl.UserDAOImpl;
import com.app.db.DBconnect;

@WebServlet("/admin/home")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection conn = DBconnect.getConn();
            if (conn == null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            BookDAOImpl bookDao = new BookDAOImpl(conn);
            UserDAOImpl userDao = new UserDAOImpl(conn);
            BookOrderDAOImpl orderDao = new BookOrderDAOImpl(conn);

            request.setAttribute("totalBooks", bookDao.countBooks());
            request.setAttribute("totalUsers", userDao.countUsers());
            request.setAttribute("totalOrders", orderDao.countOrders());

            // Total sales in USD
            double totalUSD = orderDao.getTotalSalesUSD();
            request.setAttribute("totalSalesUSD", String.format("%.2f", totalUSD));

            request.getRequestDispatcher("/admin/home.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
