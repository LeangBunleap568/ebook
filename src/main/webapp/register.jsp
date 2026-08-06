<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ebook Store - Register</title>
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
        .register-wrapper {
            background-color: #f8f9fa !important;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 75vh;
        }
        .register-box {
            width: 100%;
            max-width: 480px;
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
        .btn-register {
            background-color: #303f9f !important;
            color: white !important;
            border: none;
        }
        .btn-register:hover {
            background-color: #1a237e !important;
            color: white !important;
        }
        .alert-inline {
            display: none;
            margin-bottom: 1rem;
            padding: 0.75rem 1rem;
            border: 1px solid #f5c2c7;
            background-color: #f8d7da;
            color: #842029;
            border-radius: 0.25rem;
        }
    </style>
</head>
<body>

    <%@include file="component/navbar.jsp" %>

    <div class="register-wrapper">
        <div class="register-box">
            <h3 class="mb-4 text-dark text-center">Register</h3>

            <%-- Session-based alerts: show and then clear the session attributes --%>
            <%
                String error = (String) session.getAttribute("error");
                String succMsg = (String) session.getAttribute("succMsg");
                if (error != null) {
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

            <div id="formAlert" class="alert-inline" role="alert"></div>

            <form action="register" method="post" onsubmit="return validateRegisterForm();" autocomplete="off">
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label small text-end">Full Name</label>
                    <div class="col-sm-8">
                        <input type="text" id="name" name="name" class="form-control" required autocomplete="off">
                    </div>
                </div>
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label small text-end">E-mail</label>
                    <div class="col-sm-8">
                        <input type="email" id="email" name="email" class="form-control" required autocomplete="off">
                    </div>
                </div>
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label small text-end">Phone Number</label>
                    <div class="col-sm-8">
                        <input type="tel" id="phone" name="phone" class="form-control" required autocomplete="off">
                    </div>
                </div>
                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label small text-end">Password</label>
                    <div class="col-sm-8">
                        <input type="password" id="password" name="password" class="form-control" required autocomplete="new-password">
                    </div>
                </div>

                <div class="row mb-3 align-items-center">
                    <label class="col-sm-4 col-form-label small text-end">Confirm Password</label>
                    <div class="col-sm-8">
                        <input type="password" id="confirm_password" name="confirm_password" class="form-control" required autocomplete="new-password">
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col-sm-8 offset-sm-4 d-flex justify-content-between align-items-center">
                        <a href="login.jsp" class="text-decoration-none small text-muted">Sign in instead</a>
                        <button type="submit" class="btn btn-register px-4">Register</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%@include file="component/footer.jsp" %>

    <script>
        function validateRegisterForm() {
            const alertBox = document.getElementById('formAlert');
            const fields = [
                { id: 'name', label: 'Name' },
                { id: 'email', label: 'Email' },
                { id: 'phone', label: 'Phone' },
                { id: 'password', label: 'Password' },
                { id: 'confirm_password', label: 'Confirm Password' }
            ];

            const emptyField = fields.find(field => {
                const value = document.getElementById(field.id) && document.getElementById(field.id).value && document.getElementById(field.id).value.trim();
                return !value;
            });

            if (emptyField) {
                alertBox.textContent = emptyField.label + ' is required.';
                alertBox.style.display = 'block';
                return false;
            }

            const pw = document.getElementById('password').value;
            const cpw = document.getElementById('confirm_password').value;
            if (pw !== cpw) {
                alertBox.textContent = 'Passwords do not match.';
                alertBox.style.display = 'block';
                return false;
            }

            alertBox.style.display = 'none';
            return true;
        }
    </script>
</body>
</html>