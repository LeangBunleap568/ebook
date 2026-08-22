package com.app.user.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.app.dao.impl.BookOrderDAOImpl;
import com.app.dao.impl.CartDAOImpl;
import com.app.db.DBconnect;
import com.app.entity.Book_Order;
import com.app.entity.Cart;
import com.app.entity.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/order", "/user/order"})
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        user u = (user) session.getAttribute("userobj");

        if (u == null) {
            session.setAttribute("failedMsg", "Please Login First");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String landmark = request.getParameter("landmark");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String pincode = request.getParameter("pincode");
            String paymentType = request.getParameter("paymentType");

            // Generate unique order number
            String orderNo = UUID.randomUUID().toString().substring(0, 8).toUpperCase();

            Connection conn = DBconnect.getConn();
            if (conn == null) {
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            CartDAOImpl cartDao = new CartDAOImpl(conn);
            List<Cart> cartItems = cartDao.getCartByUser(u.getId());

            List<Book_Order> orderList = new ArrayList<>();
            for (Cart c : cartItems) {
                Book_Order bo = new Book_Order();
                bo.setOrderNo(orderNo);
                bo.setBookName(c.getBookName());
                bo.setAuthor(c.getAuthor());
                bo.setPrice(String.valueOf(c.getPrice()));
                bo.setName(name);
                bo.setEmail(email);
                bo.setPhone(phone);
                bo.setAddress(address);
                bo.setLandmark(landmark);
                bo.setCity(city);
                bo.setState(state);
                bo.setPincode(pincode);
                bo.setPaymentType(paymentType);
                orderList.add(bo);
            }

            BookOrderDAOImpl orderDao = new BookOrderDAOImpl(conn);
            boolean saved = orderDao.saveOrder(orderList);

            if (saved) {
                // Clear user cart after successful order
                cartDao.deleteCartByUid(u.getId());
                session.setAttribute("orderNo", orderNo);
                session.setAttribute("succMsg", "Order Placed Successfully! Order ID: " + orderNo);
                response.sendRedirect(request.getContextPath() + "/user/order_success.jsp");
            } else {
                session.setAttribute("failedMsg", "Order failed. Please try again.");
                response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "Something went wrong: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/user/cart.jsp");
        }
    }
}
