<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook Store - Login</title>
    <%@include file="component/rootCss.jsp" %>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar {
            padding-top: 0.5rem !important;
            padding-bottom: 0.5rem !important;
            min-height: 60px;
        }
        .login-wrapper {
            background-color: #f8f9fa !important;
            padding: 60px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 70vh;
        }
        .login-box {
            width: 100%;
            max-width: 450px;
            background-color: #ffffff;
            padding: 30px;
            border: 1px solid #ced4da;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        .form-control, .btn {
            border-radius: 0px !important;
        }
        .form-control {
            border: 1px solid #ced4da;
        }
        .btn-signin {
            background-color: #303f9f !important;
            color: white !important;
            border: none;
        }
        .btn-signin:hover {
            background-color: #1a237e !important;
            color: white !important;
        }
    </style>
</head>
<body>

    <%@include file="component/navbar.jsp" %>

    <div class="login-wrapper">
        <div class="login-box">
            <h3 class="mb-4 text-dark text-center">Login</h3>

            <%
                String failedMsg = (String) session.getAttribute("failedMsg");
                String error = (String) session.getAttribute("error");
                String succMsg = (String) session.getAttribute("succMsg");

                if (failedMsg != null) {
            %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <%= failedMsg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
            <%
                    session.removeAttribute("failedMsg");
                } else if (error != null) {
            %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
            <%
                    session.removeAttribute("error");
                }
                if (succMsg != null) {
            %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <%= succMsg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
            <%
                    session.removeAttribute("succMsg");
                }
            %>

            <form action="${pageContext.request.contextPath}/login" method="post" autocomplete="off">
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-3 col-form-label small text-end" for="emailExampleInput">Email or username</label>
                    <div class="col-sm-9">
                        <input type="text" name="email" id="emailExampleInput" class="form-control" required autocomplete="off">
                    </div>
                </div>
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-3 col-form-label small text-end" for="passwordExampleInput">Password</label>
                    <div class="col-sm-9">
                        <input type="password" name="password" id="passwordExampleInput" class="form-control" required autocomplete="new-password">
                    </div>
                </div>
                
                <div class="row mt-4">
                    <div class="col-sm-9 offset-sm-3 d-flex justify-content-between align-items-center">
                        <a href="#" class="text-decoration-none small text-muted">Need help?</a>
                        <button type="submit" class="btn btn-signin px-4">Sign in</button>
                    </div>
                </div>
            </form>

            <div class="mt-4 text-center">
                <p class="small text-muted">Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp" class="text-primary text-decoration-none">Register here</a></p>
            </div>
        </div>
    </div>

    <%@include file="component/footer.jsp" %>

</body>
</html>

