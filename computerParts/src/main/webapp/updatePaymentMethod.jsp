<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.PaymentModel" %>
<%@ page import="com.DAO.PaymentDao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Get the paymentId from the request
    String paymentId = request.getParameter("paymentId");

    // Initialize PaymentDao and establish a database connection
    PaymentDao paymentDao = null;
    Connection conn = null;
    PaymentModel payment = null;

    try {
        // Get a connection using the DBConnect class
        conn = DBConnect.getConnection();
        paymentDao = new PaymentDao(conn);

        // Fetch the payment method using the paymentId
        payment = paymentDao.getPaymentById(Integer.parseInt(paymentId));

        if (payment == null) {
            response.sendRedirect("myPaymentMethod.jsp?error=Payment method not found.");
            return; // Stop further processing
        }
    } catch (Exception e) {
        e.printStackTrace(); // Log the exception
        response.sendRedirect("myPaymentMethod.jsp?error=An error occurred while retrieving the payment method.");
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
    <title>Update Payment Method</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
            padding: 20px;
            border: 1px solid #dc3545;
            border-radius: 5px;
            background-color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center">Update Payment Method</h2>
        
        <form action="/computerParts/updatePaymentMethod" method="post"> <!-- Updated action to the servlet -->
            <input type="hidden" name="paymentId" value="<%= payment.getPaymentId() %>">
            <div class="mb-3">
                <label for="cardNumber" class="form-label">Card Number</label>
                <input type="text" class="form-control" id="cardNumber" name="cardNumber" value="<%= payment.getCardNumber() %>" required>
            </div>
            <div class="mb-3">
                <label for="cvv" class="form-label">CVV</label>
                <input type="text" class="form-control" id="cvv" name="cvv" value="<%= payment.getCvv() %>" required>
            </div>
            <div class="mb-3">
                <label for="expireDate" class="form-label">Expiration Date</label>
                <input type="text" class="form-control" id="expireDate" name="expireDate" value="<%= payment.getExpireDate() %>" required>
            </div>
            <input type="hidden" name="userUserId" value="<%= payment.getUserUserId() %>"> <!-- Include user ID -->
            <button type="submit" class="btn btn-primary">Update Payment Method</button>
            <a href="myPaymentMethod.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
