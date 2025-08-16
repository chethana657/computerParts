<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.PaymentModel" %>
<%@ page import="com.DAO.PaymentDao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.connection.DBConnect" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.model.UserModel" %>

<%
    // Get the current user object from the session
    UserModel currentUser = (UserModel) session.getAttribute("currentUser");
    
    // Initialize userId variable
    int userId = -1; // Default value for userId

    if (currentUser != null) {
        userId = currentUser.getUserId(); // Get userId from UserModel
    }

    // Redirect if user is not logged in
    if (userId == -1) {
        response.sendRedirect("login.jsp");
        return; // Stop further processing of the page
    }

    // Initialize PaymentDao and establish a database connection
    PaymentDao paymentDao = null;
    Connection conn = null;

    try {
        // Get a connection using the DBConnect class
        conn = DBConnect.getConnection();
        paymentDao = new PaymentDao(conn);
        
        // Fetch payment methods for the current user
        List<PaymentModel> payments = paymentDao.getPaymentsByUserId(userId);
        request.setAttribute("payments", payments); // Set the payments list in request scope
    } catch (Exception e) {
        e.printStackTrace(); // Log the exception
    } finally {
        // Close the connection if it's not null
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace(); // Log closing exception
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Payment Methods</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        h2 {
            color: #dc3545;
        }
        .container {
            margin-top: 50px;
            padding: 20px;
            border: 1px solid #dc3545;
            border-radius: 5px;
            background-color: #ffffff;
        }
        /* Sidebar Styles */
        .sidebar {
            background-color: #dc3545; /* Red background for sidebar */
            height: 100vh; /* Full height */
            padding: 15px; /* Padding for sidebar */
            position: fixed; /* Fixed position */
            top: 0;
            left: 0;
            width: 250px; /* Fixed width */
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
        .content {
            margin-left: 270px; /* To accommodate the sidebar */
            padding: 20px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h4 class="text-center">Menu</h4>
        <a href="home.jsp">Home</a>
        <a href="myOrders.jsp">My Orders</a>
        <a href="addPaymentMethod.jsp">Add Payment Method</a>
        <a href="myPaymentMethods.jsp">My Payment Methods</a>
        <a href="profile.jsp">Profile</a>
        <a href="logout.jsp">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="container">
            <h2 class="text-center">My Payment Methods</h2>
            
            <c:if test="${not empty payments}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Payment ID</th>
                            <th>Card Number</th>
                            <th>CVV</th>
                            <th>Expiration Date</th>
                            <th>Actions</th> <!-- New header for actions -->
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="payment" items="${payments}">
                            <tr>
                                <td>${payment.paymentId}</td>
                                <td>${payment.cardNumber}</td>
                                <td>${payment.cvv}</td>
                                <td>${payment.expireDate}</td>
                                <td>
                                    <a href="updatePaymentMethod.jsp?paymentId=${payment.paymentId}" class="btn btn-warning btn-sm">Update</a>
                                    <form action="deletePaymentMethod.jsp" method="post" style="display:inline;">
                                        <input type="hidden" name="paymentId" value="${payment.paymentId}" />
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this payment method?');">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            
            <c:if test="${empty payments}">
                <p class="text-warning">No payment methods found.</p>
            </c:if>

            <div class="mt-3">
                <a href="addPaymentMethod.jsp" class="btn btn-primary">Add Payment Method</a>
                <a href="home.jsp" class="btn btn-secondary">Back to Home</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
