package com.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconnect {
    private static Connection conn;

    private static String getEnvVar(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value != null && !value.isEmpty()) ? value : defaultValue;
    }

    private static final String HOST = getEnvVar("DB_HOST", "localhost");
    private static final String PORT = getEnvVar("DB_PORT", "3306");
    private static final String DB_NAME = getEnvVar("DB_NAME", "ebook");
    private static final String USER = getEnvVar("DB_USER", "root");
    private static final String PASSWORD = getEnvVar("DB_PASSWORD", "");

    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DB_NAME
            + "?useSSL=true"
            + "&requireSSL=true"
            + "&sslMode=REQUIRED"
            + "&useUnicode=true"
            + "&characterEncoding=UTF-8"
            + "&serverTimezone=UTC";

    public static Connection getConn() {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("DB Connected: MySQL (" + HOST + ":" + PORT + "/" + DB_NAME + ")");
            }
        } catch (Exception e) {
            System.out.println("DB Connection FAILED: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
}