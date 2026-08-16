<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.db.DBconnect, com.DAO.UserDAOImpl, com.entity.user" %>
<!DOCTYPE html>
<html>
<head>
    <title>DB Diagnostic</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 30px; background: #f4f4f4; }
        h1 { color: #333; }
        .box { padding: 16px 20px; margin: 12px 0; border-radius: 6px; font-size: 15px; }
        .ok  { background: #d4edda; border: 2px solid #28a745; color: #155724; }
        .err { background: #f8d7da; border: 2px solid #dc3545; color: #721c24; }
        .inf { background: #d1ecf1; border: 2px solid #17a2b8; color: #0c5460; }
        pre  { background: #fff; padding: 10px; border-radius: 4px; overflow-x: auto; font-size: 13px; }
        a.btn { display: inline-block; margin-top: 20px; padding: 10px 20px;
                background: #303f9f; color: #fff; border-radius: 4px; text-decoration: none; }
    </style>
</head>
<body>
<h1>🔍 Ebook DB Diagnostic</h1>
<hr>
<%
    // ── STEP 1: Connection ──────────────────────────────────────────
    Connection conn = null;
    try {
        conn = DBconnect.getConn();
    } catch (Exception e) {
        out.println("<div class='box err'><b>❌ STEP 1 FAILED — Cannot get connection</b><br>" + e.getMessage() + "<pre>");
        e.printStackTrace(new java.io.PrintWriter(out));
        out.println("</pre></div>");
    }

    if (conn != null && !conn.isClosed()) {
        out.println("<div class='box ok'>✅ <b>STEP 1 PASSED</b> — Connected to MySQL<br>"
            + "URL: " + conn.getMetaData().getURL() + "<br>"
            + "DB: "  + conn.getCatalog() + "</div>");

        // ── STEP 2: Table check / auto-create ──────────────────────
        try {
            UserDAOImpl dao = new UserDAOImpl(conn);
            out.println("<div class='box ok'>✅ <b>STEP 2 PASSED</b> — UserDAOImpl initialized (table ensured)</div>");

            // ── STEP 3: Count existing users ───────────────────────
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM `user`")) {
                if (rs.next()) {
                    out.println("<div class='box inf'>ℹ️ <b>STEP 3</b> — Users in DB: <b>" + rs.getInt(1) + "</b></div>");
                }
            }

            // ── STEP 4: Test register ───────────────────────────────
            String testEmail = "test_diag_" + System.currentTimeMillis() + "@test.com";
            user testUser = new user();
            testUser.setName("Test User");
            testUser.setEmail(testEmail);
            testUser.setPhone("0000000000");
            testUser.setPassword("test123");

            boolean registered = false;
            try {
                registered = dao.userRegistre(testUser);
            } catch (Exception e) {
                out.println("<div class='box err'>❌ <b>STEP 4 FAILED</b> — Register threw exception:<br>"
                    + e.getMessage() + "<pre>");
                e.printStackTrace(new java.io.PrintWriter(out));
                out.println("</pre></div>");
            }

            if (registered) {
                out.println("<div class='box ok'>✅ <b>STEP 4 PASSED</b> — Test user INSERT successful<br>Email: " + testEmail + "</div>");

                // ── STEP 5: Test login ──────────────────────────────
                user loggedIn = null;
                try {
                    loggedIn = dao.login(testEmail, "test123");
                } catch (Exception e) {
                    out.println("<div class='box err'>❌ <b>STEP 5 FAILED</b> — Login threw exception:<br>" + e.getMessage() + "</div>");
                }

                if (loggedIn != null) {
                    out.println("<div class='box ok'>✅ <b>STEP 5 PASSED</b> — Login successful for: <b>"
                        + loggedIn.getName() + "</b> (" + loggedIn.getEmail() + ")</div>");

                    // Cleanup test user
                    try (PreparedStatement del = conn.prepareStatement("DELETE FROM `user` WHERE email = ?")) {
                        del.setString(1, testEmail);
                        del.executeUpdate();
                        out.println("<div class='box inf'>🧹 Test user cleaned up.</div>");
                    }

                    out.println("<div class='box ok' style='font-size:18px;'>"
                        + "🎉 <b>ALL STEPS PASSED</b> — Register &amp; Login are fully working!</div>");
                } else {
                    out.println("<div class='box err'>❌ <b>STEP 5 FAILED</b> — Login returned null (credential mismatch or query error)</div>");
                }
            }

        } catch (Exception e) {
            out.println("<div class='box err'>❌ <b>STEP 2/3 FAILED</b>:<br>" + e.getMessage() + "<pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
            out.println("</pre></div>");
        }

    } else if (conn == null) {
        out.println("<div class='box err'>❌ <b>Connection is NULL</b> — Check DBconnect credentials</div>");
    }
%>

<a class="btn" href="${pageContext.request.contextPath}/register.jsp">→ Go to Register</a>
&nbsp;&nbsp;
<a class="btn" href="${pageContext.request.contextPath}/login.jsp">→ Go to Login</a>
</body>
</html>


