package com.app.dao.impl;

import com.app.dao.*;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.app.entity.user;

public class UserDAOImpl implements UserDAO {
    private Connection conn;

    public UserDAOImpl(Connection conn) {
        super();
        this.conn = conn;
        ensureTableExists();
    }

    private void ensureTableExists() {
        if (conn == null)
            return;
        try {
            DatabaseMetaData meta = conn.getMetaData();
            try (ResultSet rs = meta.getTables(null, null, "user", new String[] { "TABLE" })) {
                if (!rs.next()) {
                    System.out.println("Creating `user` table...");
                    String sql = "CREATE TABLE `user` (" +
                            "  id       INT NOT NULL AUTO_INCREMENT," +
                            "  name     VARCHAR(100) NOT NULL," +
                            "  email    VARCHAR(150) NOT NULL UNIQUE," +
                            "  phone    VARCHAR(20)  DEFAULT NULL," +
                            "  password VARCHAR(255) NOT NULL," +
                            "  address  VARCHAR(255) DEFAULT NULL," +
                            "  landmark VARCHAR(100) DEFAULT NULL," +
                            "  city     VARCHAR(100) DEFAULT NULL," +
                            "  state    VARCHAR(100) DEFAULT NULL," +
                            "  pincode  VARCHAR(20)  DEFAULT NULL," +
                            "  PRIMARY KEY (id)" +
                            ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";
                    try (Statement st = conn.createStatement()) {
                        st.executeUpdate(sql);
                        System.out.println("`user` table created.");
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("ensureTableExists error: " + e.getMessage());
        }
    }

    @Override
    public boolean userRegistre(user us) {
        if (conn == null) {
            throw new RuntimeException(
                    "Cannot connect to database. Check MySQL is running and credentials are correct.");
        }
        try {
            String sql = "INSERT INTO `user` (name, email, phone, password) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, us.getName());
                ps.setString(2, us.getEmail());
                ps.setString(3, us.getPhone());
                ps.setString(4, us.getPassword());
                ps.executeUpdate();
                System.out.println("User registered: " + us.getEmail());
                return true;
            }
        } catch (Exception e) {
            System.out.println("Register error: " + e.getMessage());
            // Surface a user-friendly message for duplicate email
            if (e.getMessage() != null && e.getMessage().contains("Duplicate entry")) {
                throw new RuntimeException("This email is already registered. Please use a different email.");
            }
            throw new RuntimeException("Registration failed: " + e.getMessage());
        }
    }

    @Override
    public user login(String email, String password) {
        if (conn == null) {
            throw new RuntimeException("Cannot connect to database.");
        }
        try {
            String sql = "SELECT * FROM `user` WHERE email = ? AND password = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        user us = new user();
                        us.setId(rs.getInt("id"));
                        us.setName(rs.getString("name"));
                        us.setEmail(rs.getString("email"));
                        us.setPhone(rs.getString("phone"));
                        us.setPassword(rs.getString("password"));
                        us.setAddress(rs.getString("address"));
                        us.setLandmark(rs.getString("landmark"));
                        us.setCity(rs.getString("city"));
                        us.setState(rs.getString("state"));
                        us.setPincode(rs.getString("pincode"));
                        return us;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Login error: " + e.getMessage());
            throw new RuntimeException("Login failed: " + e.getMessage());
        }
        return null; // credentials not found
    }

    @Override
    public boolean checkPassword(int id, String ps) {
        if (conn == null)
            return false;
        try {
            String sql = "SELECT id FROM `user` WHERE id=? AND password=?";
            try (PreparedStatement pst = conn.prepareStatement(sql)) {
                pst.setInt(1, id);
                pst.setString(2, ps);
                try (ResultSet rs = pst.executeQuery()) {
                    return rs.next();
                }
            }
        } catch (Exception e) {
            System.out.println("checkPassword error: " + e.getMessage());
        }
        return false;
    }

    @Override
    public boolean updateProfile(user us) {
        if (conn == null)
            return false;
        try {
            String sql = "UPDATE `user` SET name=?, email=?, phone=? WHERE id=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, us.getName());
                ps.setString(2, us.getEmail());
                ps.setString(3, us.getPhone());
                ps.setInt(4, us.getId());
                int rows = ps.executeUpdate();
                return rows > 0;
            }
        } catch (Exception e) {
            System.out.println("updateProfile error: " + e.getMessage());
        }
        return false;
    }

    @Override
    public boolean checkUser(String email) {
        if (conn == null)
            return false;
        try {
            String sql = "SELECT id FROM `user` WHERE email=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next(); // true = user already exists
                }
            }
        } catch (Exception e) {
            System.out.println("checkUser error: " + e.getMessage());
        }
        return false;
    }

    public int countUsers() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM user";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public List<user> getAllUsers() {
        List<user> users = new ArrayList<>();
        if (conn == null) return users;
        try {
            String sql = "SELECT * FROM `user` ORDER BY id DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    user us = new user();
                    us.setId(rs.getInt("id"));
                    us.setName(rs.getString("name"));
                    us.setEmail(rs.getString("email"));
                    us.setPhone(rs.getString("phone"));
                    us.setAddress(rs.getString("address"));
                    us.setCity(rs.getString("city"));
                    us.setState(rs.getString("state"));
                    users.add(us);
                }
            }
        } catch (Exception e) {
            System.out.println("getAllUsers error: " + e.getMessage());
        }
        return users;
    }

    @Override
    public boolean deleteUser(int id) {
        if (conn == null) return false;
        try {
            String sql = "DELETE FROM `user` WHERE id=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            System.out.println("deleteUser error: " + e.getMessage());
        }
        return false;
    }

}

