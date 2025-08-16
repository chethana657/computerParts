<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffe5e5; /* Light red background */
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
        .login-link {
            display: block;
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-4">Register</h2>

                        <!-- Form -->
                        <form action="/computerParts/RegisterServlet" method="post">
                            <div class="mb-3">
                                <label for="firstName" class="form-label">First Name:</label>
                                <input type="text" id="firstName" name="firstName" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="lastName" class="form-label">Last Name:</label>
                                <input type="text" id="lastName" name="lastName" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">Email:</label>
                                <input type="email" id="email" name="email" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="mobile" class="form-label">Mobile:</label>
                                <input type="text" id="mobile" name="mobile" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Password:</label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>

                            <!-- Hidden input for status -->
                            <input type="hidden" name="status" value="1">

                            <button type="submit" class="btn btn-red w-100">Register</button>
                        </form>

                        <!-- Error and success messages -->
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger mt-3">${errorMessage}</div>
                        </c:if>
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success mt-3">${successMessage}</div>
                        </c:if>

                        <!-- Login Link -->
                        <div class="login-link">
                            <a href="/computerParts/login.jsp" class="btn btn-link">Already have an account? Login here</a>
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
