package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.entity.BookDtls;

public class BookDAOImpl implements BookDAO {

    private Connection conn;

    public BookDAOImpl(Connection conn) {
        super();
        this.conn = conn;
        createTableIfNotExists();
    }

    private void createTableIfNotExists() {
        try {
            if (conn != null) {
                String sql = "CREATE TABLE IF NOT EXISTS `book_dtls` ("
                        + " `bookId` INT NOT NULL AUTO_INCREMENT,"
                        + " `bookname` VARCHAR(255) NOT NULL,"
                        + " `author` VARCHAR(255) NOT NULL,"
                        + " `price` VARCHAR(50) NOT NULL,"
                        + " `bookCategory` VARCHAR(100) NOT NULL,"
                        + " `status` VARCHAR(50) NOT NULL,"
                        + " `photo` VARCHAR(255) NOT NULL,"
                        + " `email` VARCHAR(150) NOT NULL,"
                        + " PRIMARY KEY (`bookId`)"
                        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
                Statement stmt = conn.createStatement();
                stmt.execute(sql);
                stmt.close();
            }
        } catch (Exception e) {
            System.out.println("BookDAOImpl Table Init Exception: " + e.getMessage());
        }
    }

    @Override
    public boolean addBooks(BookDtls b) {
        boolean f = false;
        try {
            String sql = "INSERT INTO book_dtls (bookname, author, price, bookCategory, status, photo, email) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, b.getBookName());
            ps.setString(2, b.getAuthor());
            ps.setString(3, b.getPrice());
            ps.setString(4, b.getBookCategory());
            ps.setString(5, b.getStatus());
            ps.setString(6, b.getPhotoName());
            ps.setString(7, b.getEmail());

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("BookDAOImpl addBooks Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public List<BookDtls> getAllBooks() {
        List<BookDtls> list = new ArrayList<BookDtls>();
        BookDtls b = null;
        try {
            String sql = "SELECT * FROM book_dtls ORDER BY bookId DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                b = new BookDtls();
                b.setBookId(rs.getInt(1));
                b.setBookName(rs.getString(2));
                b.setAuthor(rs.getString(3));
                b.setPrice(rs.getString(4));
                b.setBookCategory(rs.getString(5));
                b.setStatus(rs.getString(6));
                b.setPhotoName(rs.getString(7));
                b.setEmail(rs.getString(8));
                list.add(b);
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("BookDAOImpl getAllBooks Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public BookDtls getBookById(int id) {
        BookDtls b = null;
        try {
            String sql = "SELECT * FROM book_dtls WHERE bookId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                b = new BookDtls();
                b.setBookId(rs.getInt(1));
                b.setBookName(rs.getString(2));
                b.setAuthor(rs.getString(3));
                b.setPrice(rs.getString(4));
                b.setBookCategory(rs.getString(5));
                b.setStatus(rs.getString(6));
                b.setPhotoName(rs.getString(7));
                b.setEmail(rs.getString(8));
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("BookDAOImpl getBookById Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return b;
    }

    @Override
    public boolean updateEditBooks(BookDtls b) {
        boolean f = false;
        try {
            String sql = "UPDATE book_dtls SET bookname = ?, author = ?, price = ?, status = ? WHERE bookId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, b.getBookName());
            ps.setString(2, b.getAuthor());
            ps.setString(3, b.getPrice());
            ps.setString(4, b.getStatus());
            ps.setInt(5, b.getBookId());

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("BookDAOImpl updateEditBooks Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public boolean deleteBooks(int id) {
        boolean f = false;
        try {
            String sql = "DELETE FROM book_dtls WHERE bookId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("BookDAOImpl deleteBooks Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }
}
