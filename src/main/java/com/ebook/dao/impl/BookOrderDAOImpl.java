package com.ebook.dao.impl;

import com.ebook.dao.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.ebook.entity.Book_Order;

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
                        + " paymentType VARCHAR(50)"
                        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
                Statement stmt = conn.createStatement();
                stmt.execute(sql);
                stmt.close();
            }
        } catch (Exception e) {
            System.out.println("BookOrderDAOImpl Table Init Exception: " + e.getMessage());
        }
    }

    @Override
    public boolean saveOrder(List<Book_Order> blist) {
        boolean f = false;
        try {
            String sql = "INSERT INTO book_order (orderNo, bookName, author, price, name, email, phone, address, landmark, city, state, pincode, paymentType)"
                    + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
                ps.addBatch();
            }
            ps.executeBatch();
            ps.close();
            f = true;
        } catch (Exception e) {
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
        } catch (Exception e) {
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
        } catch (Exception e) {
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
        return bo;
    }
}
