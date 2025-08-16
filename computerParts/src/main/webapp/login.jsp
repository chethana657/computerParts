<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffe5e5; /* Light red background */
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            border-color: #dc3545; /* Red border for the card */
        }
        .btn-red {
            background-color: #dc3545;
            border-color: #dc3545;
            color: #fff;
        }
        .btn-red:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }
        .card-title {
            color: #dc3545; /* Red title */
        }
        .form-label {
            color: #6c757d; /* Subtle gray for labels */
        }
        .register-link {
            display: block;
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-4">Login</h2>

                        <!-- Login Form -->
                        <form action="/computerParts/LoginServlet" method="post">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email:</label>
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Password:</label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>

                            <button type="submit" class="btn btn-red w-100">Login</button>
                        </form>

                        <!-- Error message -->
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger mt-3">${errorMessage}</div>
                        </c:if>

                        <!-- Registration Link -->
                        <div class="register-link">
                            <a href="/computerParts/register.jsp" class="btn btn-link">Don't have an account? Register here</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
