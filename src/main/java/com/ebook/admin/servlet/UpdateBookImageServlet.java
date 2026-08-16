package com.ebook.admin.servlet;

import java.io.File;
import java.io.IOException;

import com.ebook.dao.impl.BookDAOImpl;
import com.ebook.db.DBconnect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/admin/update_image")
@MultipartConfig
public class UpdateBookImageServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Part bimg = request.getPart("bimg");
            String fileName = (bimg != null) ? bimg.getSubmittedFileName() : "";

            // Validate that an image file was actually selected
            if (bimg == null || fileName == null || fileName.trim().isEmpty() || bimg.getSize() == 0) {
                session.setAttribute("failedMsg", "Please select a new cover image!");
                response.sendRedirect(request.getContextPath() + "/admin/edit_books.jsp?id=" + id);
                return;
            }

            // Update the photo column in the database
            BookDAOImpl dao = new BookDAOImpl(DBconnect.getConn());
            boolean success = dao.updateBookImage(id, fileName);

            if (success) {
                // Save the uploaded image file to the webapp /book/ directory
                String path = getServletContext().getRealPath("") + "book";
                File dir = new File(path);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                bimg.write(path + File.separator + fileName);

                session.setAttribute("succMsg", "Book cover image updated successfully!");
            } else {
                session.setAttribute("failedMsg", "Failed to update book cover image. Please try again.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("failedMsg", "Invalid book ID.");
        } catch (Exception e) {
            System.out.println("UpdateBookImageServlet Exception: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("failedMsg", "Error: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/allBook.jsp");
    }
}

