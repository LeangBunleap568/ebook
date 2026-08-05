package com.user.servlet;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/login")
public class loginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            
            System.out.println(email + " " + password);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
            
	}
    
}
