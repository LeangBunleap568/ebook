<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Internal Server Error - Ebook Store</title>
    <%@include file="component/rootCss.jsp" %>
</head>
<body class="bg-light">
    <%@include file="component/navbar.jsp" %>
    <div class="container text-center mt-5">
        <i class="fas fa-exclamation-triangle fa-5x text-danger mb-4"></i>
        <h1 class="display-4">Oops! Something went wrong.</h1>
        <p class="lead">We're experiencing some technical difficulties. Please try again later.</p>
        <p>
            <% 
                String errorMsg = (String) request.getAttribute("errorMsg");
                if (errorMsg != null) { 
                    out.print("<strong>Error Details:</strong> " + errorMsg);
                } 
            %>
        </p>
        <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-primary mt-3">Return to Home</a>
    </div>
    <%@include file="component/footer.jsp" %>
</body>
</html>
