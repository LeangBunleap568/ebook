package com.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconnect {
    private static Connection conn;

    public static Connection getConn() {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3309/ebook-app", "root", "admin123");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}