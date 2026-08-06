package com.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBconnect {
    private static Connection conn;

    public static Connection getConn() {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");

                String host = System.getenv().getOrDefault("AIVEN_DB_HOST", "localhost");
                String port = System.getenv().getOrDefault("AIVEN_DB_PORT", "3306");
                String dbName = System.getenv().getOrDefault("AIVEN_DB_NAME", "ebook_app");
                String user = System.getenv().getOrDefault("AIVEN_DB_USER", "avnadmin");
                String password = System.getenv().getOrDefault("AIVEN_DB_PASSWORD", "");

                String jdbcUrl = String.format(
                    "jdbc:mysql://%s:%s/%s?sslMode=REQUIRED&useSSL=true&serverTimezone=UTC",
                    host, port, dbName
                );

                conn = DriverManager.getConnection(jdbcUrl, user, password);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}