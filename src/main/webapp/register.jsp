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
            min-height: 100vh;
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

        .register-wrapper {
            background-color: #f8f9fa !important;
            padding: 50px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 120px);
        }

        .register-box {
            width: 100%;
            max-width: 480px;
            background-color: #ffffff;
            padding: 35px 30px;
            border-radius: 12px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            position: relative;
            overflow: hidden;
        }

        /* Yellow Top Accent Line ដូច Login Card */
        .register-box::before {
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

        /* Register Button Style ដើមរបស់អ្នក */
        .btn-register {
            background-color: #303f9f !important;
            color: white !important;
            border: none;
            border-radius: 6px !important;
            padding: 10px 20px;
            font-weight: 600;
            transition: background-color 0.2s ease;
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
            border-radius: 6px;
            font-size: 0.875rem;
        }

        .alert {
            border-radius: 6px;
            font-size: 0.875rem;
        }
    </style>
</head>
<body>

    <%@include file="component/navbar.jsp" %>

    <div class="register-wrapper">
        <div class="register-box">
            
            <div class="text-center mb-4">
                <i class="fas fa-user-plus text-secondary mb-2" style="font-size: 40px;"></i>
                <h3 class="fw-bold text-dark mb-1">Create Account</h3>
                <p class="text-muted small mb-0">Fill in the information below to register</p>
            </div>

            <%-- Session-based alerts --%>
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

            <form action="${pageContext.request.contextPath}/register" method="post" onsubmit="return validateRegisterForm();" autocomplete="off">
                
                <div class="mb-3">
                    <label class="form-label" for="name">Full Name</label>
                    <input type="text" id="name" name="name" class="form-control" placeholder="Enter your full name" required autocomplete="off">
                </div>

                <div class="mb-3">
                    <label class="form-label" for="email">E-mail Address</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="example@domain.com" required autocomplete="off">
                </div>

                <div class="mb-3">
                    <label class="form-label" for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" class="form-control" placeholder="Enter phone number" required autocomplete="off">
                </div>

                <div class="mb-3">
                    <label class="form-label" for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Enter password" required autocomplete="new-password">
                </div>

                <div class="mb-3">
                    <label class="form-label" for="confirm_password">Confirm Password</label>
                    <input type="password" id="confirm_password" name="confirm_password" class="form-control" placeholder="Re-enter password" required autocomplete="new-password">
                </div>

                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="text-decoration-none small text-muted">Sign in instead</a>
                    <button type="submit" class="btn btn-register px-4">Register</button>
                </div>
            </form>

            <div class="mt-4 pt-3 border-top text-center">
                <p class="small text-muted mb-0">Already have an account? <a href="${pageContext.request.contextPath}/login.jsp" class="fw-semibold text-decoration-none" style="color: #303f9f;">Login here</a></p>
            </div>

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