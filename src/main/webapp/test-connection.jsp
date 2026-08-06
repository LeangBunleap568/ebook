<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.db.DBconnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Aiven Connection Test</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        .box { padding: 20px; margin: 10px 0; border-radius: 5px; }
        .success { background: #d4edda; border: 2px solid #28a745; color: #155724; }
        .error { background: #f8d7da; border: 2px solid #dc3545; color: #721c24; }
        h1 { color: #333; }
        pre { background: #f4f4f4; padding: 10px; border-radius: 3px; overflow-x: auto; }
    </style>
</head>
<body>
    <h1>🔌 Aiven Database Connection Test</h1>
    <hr>
    
    <%
        try {
            out.println("<div class='box'>");
            Connection conn = DBconnect.getConn();
            
            if (conn == null) {
                out.println("<div class='box error'>");
                out.println("<h2>❌ FAILED: Connection is NULL</h2>");
                out.println("<p>DBconnect.getConn() returned null</p>");
                out.println("</div>");
            } else if (conn.isClosed()) {
                out.println("<div class='box error'>");
                out.println("<h2>❌ FAILED: Connection is CLOSED</h2>");
                out.println("</div>");
            } else {
                out.println("<div class='box success'>");
                out.println("<h2>✓ SUCCESS: Connected to Aiven!</h2>");
                out.println("<p><strong>Database Product:</strong> " + conn.getMetaData().getDatabaseProductName() + "</p>");
                out.println("<p><strong>URL:</strong> " + conn.getMetaData().getURL() + "</p>");
                out.println("<p><strong>Database Version:</strong> " + conn.getMetaData().getDatabaseProductVersion() + "</p>");
                
                // Check user table
                DatabaseMetaData dbm = conn.getMetaData();
                ResultSet tables = dbm.getTables(null, null, "user", null);
                
                if (tables.next()) {
                    out.println("<h3>✓ Table 'user' EXISTS</h3>");
                } else {
                    out.println("<h3>❌ Table 'user' NOT FOUND</h3>");
                }
                
                out.println("</div>");
                conn.close();
            }
        } catch (Exception e) {
            out.println("<div class='box error'>");
            out.println("<h2>❌ ERROR:</h2>");
            out.println("<p><strong>" + e.getClass().getName() + "</strong></p>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("<pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
            out.println("</pre>");
            out.println("</div>");
        }
    %>
    
    <hr>
    <p><a href="register.jsp">Back to Register</a></p>
</body>
</html>
