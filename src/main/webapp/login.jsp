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

        /* Navbar Style ដើមរបស់អ្នក - មិនបានកែប្រែទេ */
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
            min-height: calc(100vh - 120px);
        }

        .login-box {
            width: 100%;
            max-width: 440px;
            background-color: #ffffff;
            padding: 35px 30px;
            border-radius: 12px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            position: relative;
            overflow: hidden;
        }

        /* Yellow Top Accent Line (ពណ៌តាមរូបភាព) */
        .login-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background-color: #eab308;
        }

        .form-label {
            font-weight: 500;
            font-size: 0.9rem;
            color: #495057;
            margin-bottom: 6px;
        }

        .form-control {
            border-radius: 6px !important;
            border: 1px solid #ced4da;
            padding: 10px 14px;
            font-size: 0.95rem;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-control:focus {
            border-color: #303f9f;
            box-shadow: 0 0 0 3px rgba(48, 63, 159, 0.15);
        }

        /* Sign-in Button Style ដើមរបស់អ្នក */
        .btn-signin {
            background-color: #303f9f !important;
            color: white !important;
            border: none;
            border-radius: 6px !important;
            padding: 10px 16px;
            font-weight: 600;
            transition: background-color 0.2s ease;
        }

        .btn-signin:hover {
            background-color: #1a237e !important;
            color: white !important;
        }

        .alert {
            border-radius: 6px;
            font-size: 0.875rem;
        }
    </style>
</head>
<body>

    <%@include file="component/navbar.jsp" %>

    <div class="login-wrapper">
        <div class="login-box">
            
            <div class="text-center mb-4">
                <i class="fas fa-user-circle text-secondary mb-2" style="font-size: 45px;"></i>
                <h3 class="fw-bold text-dark mb-1">Login</h3>
                <p class="text-muted small mb-0">Enter your credentials to access your account</p>
            </div>

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
                <div class="mb-3">
                    <label class="form-label" for="emailExampleInput">Email or Username</label>
                    <input type="text" name="email" id="emailExampleInput" class="form-control" placeholder="Enter email or username" required autocomplete="off">
                </div>

                <div class="mb-3">
                    <label class="form-label" for="passwordExampleInput">Password</label>
                    <input type="password" name="password" id="passwordExampleInput" class="form-control" placeholder="Enter password" required autocomplete="new-password">
                </div>
                
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="#" class="text-decoration-none small text-muted">Need help?</a>
                    <button type="submit" class="btn btn-signin px-4">Sign in</button>
                </div>
            </form>

            <div class="mt-4 pt-3 border-top text-center">
                <p class="small text-muted mb-0">Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp" class="fw-semibold text-decoration-none" style="color: #303f9f;">Register here</a></p>
            </div>

        </div>
    </div>

    <%@include file="component/footer.jsp" %>

</body>
</html>