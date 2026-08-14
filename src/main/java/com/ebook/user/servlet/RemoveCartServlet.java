package com.ebook.user.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.ebook.dao.impl.CartDAOImpl;
import com.db.DBconnect;

@WebServlet("/remove_cart")
public class RemoveCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int cid = Integer.parseInt(req.getParameter("cid"));
        int uid = Integer.parseInt(req.getParameter("uid"));
        
        CartDAOImpl dao = new CartDAOImpl(DBconnect.getConn());
        boolean f = dao.removeBook(cid, uid);
        
        HttpSession session = req.getSession();
        
        if (f) {
            session.setAttribute("succMsg", "Book Removed from Cart");
            resp.sendRedirect("cart.jsp");
        } else {
            session.setAttribute("failedMsg", "Something went wrong on server");
            resp.sendRedirect("cart.jsp");
        }
    }
}
