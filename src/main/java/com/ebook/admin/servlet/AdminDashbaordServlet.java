package com.ebook.admin.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.ebook.dao.impl.BookDAOImpl;
import com.ebook.dao.impl.UserDAOImpl;
import com.ebook.dao.impl.BookOrderDAOImpl;
import com.ebook.db.DBconnect;

@WebServlet("/admin/home")
public class AdminDashbaordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. បង្កើត Object DAO ដើម្បីទាញទិន្នន័យពី Database
            BookDAOImpl bookDao = new BookDAOImpl(DBconnect.getConn());
            UserDAOImpl userDao = new UserDAOImpl(DBconnect.getConn());
            BookOrderDAOImpl orderDao = new BookOrderDAOImpl(DBconnect.getConn());

            // 2. Count ចំនួន real-time រួចផ្ញើទៅកាន់ JSP
            // (ចំណាំ៖ ត្រូវប្រាកដថា DAO របស់អ្នកមាន method រាប់ទាំងនេះ ឬកែប្រែតាមឈ្មោះ
            // method ជាក់ស្ដែង)
            request.setAttribute("totalBooks", bookDao.countBooks());
            request.setAttribute("totalUsers", userDao.countUsers());
            request.setAttribute("totalOrders", orderDao.countOrders());

            // 3. Forward ទៅកាន់ admin/home.jsp (ដែលនៅក្នុង webapp/admin/home.jsp)
            request.getRequestDispatcher("/admin/home.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}
