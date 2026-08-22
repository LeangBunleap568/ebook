package com.app.dao.impl;

import com.app.dao.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import com.app.entity.Cart;

public class CartDAOImpl implements CartDAO {

    private Connection conn;

    public CartDAOImpl(Connection conn) {
        this.conn = conn;
        createTableIfNotExists();
    }

    private void createTableIfNotExists() {
        try {
            if (conn != null) {
                String sql = "CREATE TABLE IF NOT EXISTS cart ("
                        + " cid INT AUTO_INCREMENT PRIMARY KEY,"
                        + " bid INT,"
                        + " uid INT,"
                        + " bookName VARCHAR(255),"
                        + " author VARCHAR(255),"
                        + " price DOUBLE,"
                        + " total_price DOUBLE"
                        + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
                Statement stmt = conn.createStatement();
                stmt.execute(sql);
                stmt.close();
            }
        } catch (Exception e) {
            System.out.println("CartDAOImpl Table Init Exception: " + e.getMessage());
        }
    }

    @Override
    public boolean addCart(Cart c) {
        boolean f = false;
        try {
            String sql = "INSERT INTO cart (bid, uid, bookName, author, price, total_price) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, c.getBid());
            ps.setInt(2, c.getUid());
            ps.setString(3, c.getBookName());
            ps.setString(4, c.getAuthor());
            ps.setDouble(5, c.getPrice());
            ps.setDouble(6, c.getTotalPrice());

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("CartDAOImpl addCart Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public java.util.List<Cart> getCartByUser(int uid) {
        java.util.List<Cart> list = new java.util.ArrayList<Cart>();
        Cart c = null;
        double totalPrice = 0;
        try {
            String sql = "SELECT * FROM cart WHERE uid=? ORDER BY cid DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, uid);
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                c = new Cart();
                c.setCid(rs.getInt(1));
                c.setBid(rs.getInt(2));
                c.setUid(rs.getInt(3));
                c.setBookName(rs.getString(4));
                c.setAuthor(rs.getString(5));
                c.setPrice(rs.getDouble(6));
                
                totalPrice = totalPrice + rs.getDouble(7);
                c.setTotalPrice(totalPrice);
                
                list.add(c);
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("CartDAOImpl getCartByUser Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean removeBook(int cid, int uid) {
        boolean f = false;
        try {
            String sql = "DELETE FROM cart WHERE cid=? AND uid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cid);
            ps.setInt(2, uid);
            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("CartDAOImpl removeBook Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public int countCart(int uid) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM cart WHERE uid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, uid);
            java.sql.ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("CartDAOImpl countCart Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public boolean deleteCartByUid(int uid) {
        boolean f = false;
        try {
            String sql = "DELETE FROM cart WHERE uid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, uid);
            ps.executeUpdate();
            ps.close();
            f = true;
        } catch (Exception e) {
            System.out.println("CartDAOImpl deleteCartByUid Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }
    @Override
    public boolean isBookInCart(int bid, int uid) {
        boolean f = false;
        try {
            String sql = "SELECT * FROM cart WHERE bid=? AND uid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bid);
            ps.setInt(2, uid);
            java.sql.ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                f = true;
            }
            ps.close();
        } catch (Exception e) {
            System.out.println("CartDAOImpl isBookInCart Exception: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }
}

