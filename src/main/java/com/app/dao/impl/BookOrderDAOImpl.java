package com.app.dao.impl;

import com.app.dao.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.app.entity.Book_Order;

public class BookOrderDAOImpl implements BookOrderDAO {

    private Connection conn;

    public BookOrderDAOImpl(Connection conn) {
        this.conn = conn;
        createTableIfNotExists();
    }

    private void createTableIfNotExists() {
        try {
            if (conn != null) {
                String sql = "CREATE TABLE IF NOT EXISTS book_order ("
                        + " id INT AUTO_INCREMENT PRIMARY KEY,"
                        + " orderNo VARCHAR(100),"
                        + " bookName VARCHAR(255),"
                        + " author VARCHAR(255),"
                        + " price VARCHAR(50),"
                        + " name VARCHAR(100),"
                        + " email VARCHAR(150),"
                        + " phone VARCHAR(20),"
                        + " address VARCHAR(255),"
                        + " landmark VARCHAR(100),"
                        + " city VARCHAR(100),"
                        + " state VARCHAR(100),"
                        + " pincode VARCHAR(20),"
                        + " paymentType VARCHAR(50),"
                        + " order_status VARCHAR(50) DEFAULT 'Pending'"
                        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
                Statement stmt = conn.createStatement();
                stmt.execute(sql);
                stmt.close();
            }
        } catch (Exception e) { e.printStackTrace();
            System.out.println("BookOrderDAOImpl Table Init Exception: " + e.getMessage());
        }
    }

    @Override
    public boolean saveOrder(List<Book_Order> blist) {
        boolean f = false;
        try {
            String sql = "INSERT INTO book_order (orderNo, bookName, author, price, name, email, phone, address, landmark, city, state, pincode, paymentType, order_status)"
                    + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            for (Book_Order bo : blist) {
                ps.setString(1, bo.getOrderNo());
                ps.setString(2, bo.getBookName());
                ps.setString(3, bo.getAuthor());
                ps.setString(4, bo.getPrice());
                ps.setString(5, bo.getName());
                ps.setString(6, bo.getEmail());
                ps.setString(7, bo.getPhone());
                ps.setString(8, bo.getAddress());
                ps.setString(9, bo.getLandmark());
                ps.setString(10, bo.getCity());
                ps.setString(11, bo.getState());
                ps.setString(12, bo.getPincode());
                ps.setString(13, bo.getPaymentType());
                ps.setString(14, "Pending");
                ps.addBatch();
            }
            ps.executeBatch();
            ps.close();
            f = true;
        } catch (Exception e) { e.printStackTrace();
            System.out.println("BookOrderDAOImpl saveOrder Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public List<Book_Order> getBookOrder(String email) {
        List<Book_Order> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM book_order WHERE email=? ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book_Order bo = mapRow(rs);
                list.add(bo);
            }
            ps.close();
        } catch (Exception e) { e.printStackTrace();
            System.out.println("BookOrderDAOImpl getBookOrder Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Book_Order> getAllOrder() {
        List<Book_Order> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM book_order ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book_Order bo = mapRow(rs);
                list.add(bo);
            }
            ps.close();
        } catch (Exception e) { e.printStackTrace();
            System.out.println("BookOrderDAOImpl getAllOrder Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    private Book_Order mapRow(ResultSet rs) throws Exception {
        Book_Order bo = new Book_Order();
        bo.setId(rs.getInt("id"));
        bo.setOrderNo(rs.getString("orderNo"));
        bo.setBookName(rs.getString("bookName"));
        bo.setAuthor(rs.getString("author"));
        bo.setPrice(rs.getString("price"));
        bo.setName(rs.getString("name"));
        bo.setEmail(rs.getString("email"));
        bo.setPhone(rs.getString("phone"));
        bo.setAddress(rs.getString("address"));
        bo.setLandmark(rs.getString("landmark"));
        bo.setCity(rs.getString("city"));
        bo.setState(rs.getString("state"));
        bo.setPincode(rs.getString("pincode"));
        bo.setPaymentType(rs.getString("paymentType"));
        bo.setStatus(rs.getString("order_status"));
        return bo;
    }

    public int countOrders() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM book_order";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) { e.printStackTrace();
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public int countActiveTransactions() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(DISTINCT orderNo) FROM book_order WHERE order_status != 'Cancelled'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            ps.close();
        } catch (Exception e) { e.printStackTrace();
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public double getTotalSalesUSD() {
        double total = 0.0;
        try {
            String sql = "SELECT price FROM book_order WHERE order_status != 'Cancelled'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String priceStr = rs.getString("price");
                if (priceStr != null && !priceStr.trim().isEmpty()) {
                    try {
                        total += Double.parseDouble(priceStr.trim());
                    } catch (NumberFormatException ignored) {}
                }
            }
            ps.close();
        } catch (Exception e) { e.printStackTrace();
            System.out.println("BookOrderDAOImpl getTotalSalesUSD Exception: " + e.getMessage());
        }
        return total;
    }

    @Override
    public boolean cancelOrder(String orderNo) {
        boolean f = false;
        try {
            String sql = "UPDATE book_order SET order_status='Cancelled' WHERE orderNo=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, orderNo);
            int i = ps.executeUpdate();
            if (i > 0) {
                f = true;
            }
            ps.close();
        } catch (Exception e) { e.printStackTrace();
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public boolean deleteOrdersByEmail(String email) {
        boolean f = false;
        try {
            String sql = "DELETE FROM book_order WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            int i = ps.executeUpdate();
            if (i >= 0) {
                f = true;
            }
            ps.close();
        } catch (Exception e) { e.printStackTrace();
            System.out.println("BookOrderDAOImpl deleteOrdersByEmail Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public boolean deleteOrderByOrderNo(String orderNo) {
        boolean f = false;
        try {
            String sql = "DELETE FROM book_order WHERE orderNo=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, orderNo);
            int i = ps.executeUpdate();
            if (i > 0) {
                f = true;
            }
            ps.close();
        } catch (Exception e) { e.printStackTrace();
            System.out.println("BookOrderDAOImpl deleteOrderByOrderNo Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }
}

