package com.ebook.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconnect {
    private static Connection conn;

    private static String getEnvVar(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value != null && !value.isEmpty()) ? value : defaultValue;
    }

    private static final String HOST = getEnvVar("DB_HOST", "127.0.0.1");
    private static final String PORT = getEnvVar("DB_PORT", "3309");
    private static final String DB_NAME = getEnvVar("DB_NAME", "ebook-app");
    private static final String USER = getEnvVar("DB_USER", "root");
    private static final String PASSWORD = getEnvVar("DB_PASSWORD", "admin123");

    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME
            + "?useSSL=false"
            + "&allowPublicKeyRetrieval=true"
            + "&useUnicode=true"
            + "&characterEncoding=UTF-8"
            + "&serverTimezone=UTC";

    public static Connection getConn() {
        try {
            // isValid(2) actually pings MySQL â€” catches server-side timeouts
            // that isClosed() alone cannot detect.
            if (conn == null || conn.isClosed() || !conn.isValid(2)) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("========================================");
                System.out.println("âœ… DB Connected Successfully!");
                System.out.println("   Host     : " + HOST);
                System.out.println("   Port     : " + PORT);
                System.out.println("   Database : " + DB_NAME);
                System.out.println("   User     : " + USER);
                System.out.println("========================================");
            }
        } catch (Exception e) {
            System.out.println("========================================");
            System.out.println("âŒ DB Connection FAILED!");
            System.out.println("   Reason: " + e.getMessage());
            System.out.println("========================================");
            e.printStackTrace();
        }
        return conn;
    }

    /** Returns true if currently connected to the database. */
    public static boolean isConnected() {
        try {
            return conn != null && !conn.isClosed();
        } catch (Exception e) {
            return false;
        }
    }
}