package com.app.admin.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.app.dao.impl.UserDAOImpl;
import com.app.db.DBconnect;
import com.app.entity.user;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection conn = DBconnect.getConn();
            if (conn == null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            UserDAOImpl userDao = new UserDAOImpl(conn);
            List<user> users = userDao.getAllUsers();
            request.setAttribute("users", users);
            request.setAttribute("totalUsers", users != null ? users.size() : 0);
            request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                Connection conn = DBconnect.getConn();
                if (conn != null) {
                    UserDAOImpl userDao = new UserDAOImpl(conn);
                    userDao.deleteUser(userId);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
