package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.user;

public class UserDAOImpl implements UserDAO {
    private Connection conn;

    public UserDAOImpl(Connection conn) {
        super();
        this.conn = conn;
    }

    @Override
    public boolean userRegistre(user us) {
        boolean f = false;
        try {
            // Generate next ID
            int nextId = 1;
            String idSql = "SELECT COALESCE(MAX(id), 0) + 1 FROM `user`";
            try (PreparedStatement idPs = conn.prepareStatement(idSql);
                 ResultSet rs = idPs.executeQuery()) {
                if (rs.next()) {
                    nextId = rs.getInt(1);
                }
            }

            // Insert new user
            String sql = "INSERT INTO `user` (id, name, email, phone, password) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, nextId);
                ps.setString(2, us.getName());
                ps.setString(3, us.getEmail());
                ps.setString(4, us.getPhone());
                ps.setString(5, us.getPassword());

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected == 1) {
                    f = true;
                    System.out.println("User registered successfully with ID: " + nextId);
                }
            }
        } catch (Exception e) {
            System.out.println("UserDAO Error: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public user login(String email, String password) {
        user us = null;
        try {
            String sql = "SELECT * FROM `user` WHERE email=? AND password=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        us = new user();
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
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("UserDAO login error: " + e.getMessage());
            e.printStackTrace();
        }
        return us;
    }
}

