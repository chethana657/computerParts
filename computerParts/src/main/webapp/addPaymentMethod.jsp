<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    // Redirect to login.jsp if the user is not logged in
    if (session.getAttribute("currentUser") == null) {
        response.sendRedirect("login.jsp");
        return; // Stop further processing of the page
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Payment Method</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffe5e5; /* Light red background */
        }
        h2 {
            color: #dc3545; /* Red color for headings */
        }
        .btn-red {
            background-color: #dc3545; /* Red button */
            color: white; /* White text on red buttons */
            border: none;
            width: 200px; /* Set a specific width for buttons */
        }
        .btn-red:hover {
            background-color: #c82333; /* Darker red on hover */
        }
        .form-label {
            color: #6c757d; /* Subtle gray for labels */
        }
        .container {
            border: 1px solid #dc3545; /* Red border around container */
            border-radius: 5px; /* Rounded corners */
            padding: 20px; /* Padding for the container */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Shadow for depth */
            background-color: #ffffff; /* White background for container */
            margin-top: 50px; /* Margin for top spacing */
        }
        /* Sidebar Styles */
        .sidebar {
            background-color: #dc3545; /* Red background for sidebar */
            height: 100vh; /* Full height */
            padding: 15px; /* Padding for sidebar */
        }
        .sidebar h4 {
            color: white; /* White color for sidebar heading */
        }
        .sidebar a {
            color: white; /* White text for sidebar links */
            text-decoration: none; /* No underline */
            padding: 10px; /* Padding for links */
            display: block; /* Make links block level */
        }
        .sidebar a:hover {
            background-color: #c82333; /* Darker red on hover */
        }
    </style>
</head>
<body>

<div class="container-fluid">
<div class="row">
    <!-- Sidebar -->
    <div class="col-md-2 sidebar">
        <h4 class="text-center">Menu</h4>
        <a href="home.jsp">Home</a>
        <a href="myOrders.jsp">My Orders</a>
        <a href="addPaymentMethod.jsp">Add Payment Method</a>
        <a href="profile.jsp">Profile</a>
        <a href="logout.jsp">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="col-md-10">
        <div class="container">
            <h2 class="text-center">Add Payment Method</h2>
            
            <form action="/computerParts/AddPaymentServlet" method="post">
                <div class="mb-3">
                    <label for="cardNumber" class="form-label">Card Number:</label>
                    <input type="text" id="cardNumber" name="cardNumber" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="cvv" class="form-label">CVV:</label>
                    <input type="text" id="cvv" name="cvv" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="expireDate" class="form-label">Expiration Date (MM/YY):</label>
                    <input type="text" id="expireDate" name="expireDate" placeholder="MM/YY" class="form-control" required>
                </div>

                <!-- Assuming userId is stored in the session -->
                <input type="hidden" name="user_userId" value="${sessionScope.currentUser.userId}">

                <button type="submit" class="btn btn-red">Add Payment</button>
            </form>

            <div class="mt-3">
                <a href="home.jsp" class="btn btn-secondary">Back to Home</a> <!-- Link to go back to home page -->
            </div>
        </div>
    </div>
    </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
