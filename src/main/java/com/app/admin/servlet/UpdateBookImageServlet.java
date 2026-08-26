package com.app.admin.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;

import com.app.dao.impl.BookDAOImpl;
import com.app.db.DBconnect;

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
        int id = 0;

        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("failedMsg", "Invalid book ID.");
                response.sendRedirect(request.getContextPath() + "/admin/all_books.jsp");
                return;
            }
            id = Integer.parseInt(idStr.trim());

            Part bimg = null;
            try {
                bimg = request.getPart("bimg");
            } catch (Exception ignored) {}

            String fileName = (bimg != null) ? bimg.getSubmittedFileName() : "";

            // If no new image is selected, keep old image
            if (bimg == null || fileName == null || fileName.trim().isEmpty() || bimg.getSize() == 0) {
                session.setAttribute("warnMsg", "No new image was selected. Existing book cover was retained.");
                response.sendRedirect(request.getContextPath() + "/admin/edit_books.jsp?id=" + id);
                return;
            }

            // Sanitize filename
            File uploadFile = new File(fileName);
            String cleanFileName = uploadFile.getName().replaceAll("[^a-zA-Z0-9._-]", "_");
            if (cleanFileName.isEmpty()) {
                cleanFileName = "book_" + id + "_" + System.currentTimeMillis() + ".jpg";
            }

            // Update database
            Connection conn = DBconnect.getConn();
            if (conn == null) {
                session.setAttribute("failedMsg", "Database connection failed.");
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                return;
            }
            BookDAOImpl dao = new BookDAOImpl(conn);
            boolean success = dao.updateBookImage(id, cleanFileName);

            if (success) {
                // Save to runtime webapp folder
                String basePath = getServletContext().getRealPath("");
                String webappPath = new File(basePath, "book").getAbsolutePath();
                File webappDir = new File(webappPath);
                if (!webappDir.exists()) {
                    webappDir.mkdirs();
                }
                bimg.write(webappPath + File.separator + cleanFileName);

                // Also try saving to source directory if running locally
                try {
                    String baseDir = System.getProperty("user.dir");
                    if (baseDir != null) {
                        File srcBookDir = new File(baseDir, "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "book");
                        if (srcBookDir.exists()) {
                            java.nio.file.Files.copy(
                                new File(webappPath, cleanFileName).toPath(),
                                new File(srcBookDir, cleanFileName).toPath(),
                                java.nio.file.StandardCopyOption.REPLACE_EXISTING
                            );
                        }
                    }
                } catch (Exception ignored) {}

                session.setAttribute("succMsg", "Book cover image updated successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/edit_books.jsp?id=" + id);
                return;
            } else {
                session.setAttribute("failedMsg", "Failed to update cover image in database.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("failedMsg", "Invalid book ID format.");
        } catch (Exception e) {
            System.out.println("UpdateBookImageServlet Exception: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("failedMsg", "Error updating cover: " + e.getMessage());
        }

        if (id > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/edit_books.jsp?id=" + id);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/all_books.jsp");
        }
    }
}
