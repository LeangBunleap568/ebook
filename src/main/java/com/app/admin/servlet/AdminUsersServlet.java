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

import com.app.dao.impl.BookDAOImpl;
import com.app.dao.impl.BookOrderDAOImpl;
import com.app.dao.impl.CartDAOImpl;
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
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String userIdStr = request.getParameter("userId");
            if (userIdStr == null || userIdStr.trim().isEmpty()) {
                session.setAttribute("failedMsg", "Invalid user ID.");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            try {
                int userId = Integer.parseInt(userIdStr.trim());
                Connection conn = DBconnect.getConn();
                if (conn == null) {
                    session.setAttribute("failedMsg", "Database connection failed.");
                    response.sendRedirect(request.getContextPath() + "/error.jsp");
                    return;
                }

                UserDAOImpl userDao = new UserDAOImpl(conn);
                user targetUser = userDao.getUserById(userId);

                if (targetUser == null) {
                    session.setAttribute("failedMsg", "User not found.");
                    response.sendRedirect(request.getContextPath() + "/admin/users");
                    return;
                }

                // Guard: Admin role cannot be deleted
                if ("admin@gmail.com".equalsIgnoreCase(targetUser.getEmail())) {
                    session.setAttribute("failedMsg", "Security Alert: Admin role cannot be deleted!");
                    response.sendRedirect(request.getContextPath() + "/admin/users");
                    return;
                }

                // Cascade delete: cart items, customer orders, and user-submitted books
                CartDAOImpl cartDao = new CartDAOImpl(conn);
                cartDao.deleteCartByUid(userId);

                BookOrderDAOImpl orderDao = new BookOrderDAOImpl(conn);
                orderDao.deleteOrdersByEmail(targetUser.getEmail());

                BookDAOImpl bookDao = new BookDAOImpl(conn);
                bookDao.deleteBooksByEmail(targetUser.getEmail());

                // Delete the user record
                boolean deleted = userDao.deleteUser(userId);
                if (deleted) {
                    session.setAttribute("succMsg", "User '" + targetUser.getName() + "' and all associated orders were deleted successfully.");
                } else {
                    session.setAttribute("failedMsg", "Failed to delete user. Please try again.");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("failedMsg", "Invalid user ID format.");
            } catch (Exception e) {
                System.out.println("AdminUsersServlet Delete Exception: " + e.getMessage());
                e.printStackTrace();
                session.setAttribute("failedMsg", "Error deleting user: " + e.getMessage());
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
