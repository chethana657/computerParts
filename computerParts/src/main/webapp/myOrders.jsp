<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.OrderModel" %>
<%@ page import="com.DAO.OrderDao" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page import="com.model.UserModel" %>
<%@ page import="java.sql.Connection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #ffe5e5; /* Light red background */
            font-family: Arial, sans-serif;
        }
        h1 {
            color: #dc3545; /* Red color for headings */
        }
        .container {
            margin-top: 30px;
        }
        .card {
            margin-bottom: 20px; /* Space between cards */
        }
        .status-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 5px 10px;
            font-size: 0.9rem;
            border-radius: 5px;
            color: white;
        }
        .status-pending {
            background-color: #ffc107; /* Yellow for Pending */
        }
        .status-completed {
            background-color: #28a745; /* Green for Completed */
        }
        .sidebar {
            background-color: #dc3545; /* Red background for sidebar */
            height: 100vh; /* Full height */
            padding: 15px; /* Padding for sidebar */
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
            <div class="col-md-2 sidebar">
                <h4 class="text-center">Menu</h4>
                <a href="home.jsp">Home</a>
                <a href="profile.jsp">Profile</a>
                <a href="myOrders.jsp">My Orders</a>
                <a href="addPaymentMethod.jsp">Add Payment</a> <!-- Link to Add Payment page -->
                <a href="myPaymentMethod.jsp">My Payments</a> <!-- Link to My Payments page -->
                <a href="logout.jsp">Logout</a>
            </div>
            <div class="col-md-10">
                <div class="container mt-5">
                    <h1>My Orders</h1>

                    <%
                        // Get current user from session
                        UserModel currentUser = (UserModel) session.getAttribute("currentUser");

                        if (currentUser == null) {
                            // Redirect to login if no user is logged in
                            response.sendRedirect("login.jsp");
                            return; // Ensure we stop further processing
                        }

                        // Database connection
                        Connection con = DBConnect.getConnection();
                        OrderDao orderDao = new OrderDao(con);

                        // Fetch orders for the current user
                        List<OrderModel> orders = orderDao.getOrdersByUserId(currentUser.getUserId());
                    %>

                    <div class="row">
                        <%
                            if (orders != null && !orders.isEmpty()) {
                                for (OrderModel order : orders) {
                                    String statusClass = order.getStatus() == 1 ? "status-pending" : "status-completed";
                                    String statusText = order.getStatus() == 1 ? "Pending" : "Completed";
                                    // Show Update button only for pending orders (status 1)
                                    boolean isPending = (order.getStatus() == 1);
                        %>
                            <div class="col-md-4 position-relative"> <!-- Adjust column size as needed -->
                                <div class="card">
                                    <div class="card-body">
                                        <span class="status-badge <%= statusClass %>"><%= statusText %></span>
                                        <h5 class="card-title">Order ID: <%= order.getOrderId() %></h5>
                                        <p class="card-text"><strong>Date:</strong> <%= order.getDate() %></p>
                                        <p class="card-text"><strong>Address:</strong> <%= order.getAddress() %></p>
                                        <p class="card-text"><strong>Email:</strong> <%= order.getEmail() %></p>
                                        <p class="card-text"><strong>Mobile:</strong> <%= order.getMobile() %></p>
                                        <p class="card-text"><strong>Quantity:</strong> <%= order.getQuantity() %></p>
                                        <p class="card-text"><strong>Total Price:</strong> $<%= order.getTotalPrice() %></p>
                                        <% if (isPending) { %>
                                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateModal<%= order.getOrderId() %>">Update</button>
                                        <% } %>
                                    </div>
                                </div>

                                <!-- Modal for updating order -->
                                <div class="modal fade" id="updateModal<%= order.getOrderId() %>" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="updateModalLabel">Update Order ID: <%= order.getOrderId() %></h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="UpdateOrderServlet" method="POST">
                                                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                                    <div class="mb-3">
                                                        <label for="email" class="form-label">Email</label>
                                                        <input type="email" class="form-control" id="email" name="email" value="<%= order.getEmail() %>" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="mobile" class="form-label">Mobile</label>
                                                        <input type="text" class="form-control" id="mobile" name="mobile" value="<%= order.getMobile() %>" required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="address" class="form-label">Address</label>
                                                        <input type="text" class="form-control" id="address" name="address" value="<%= order.getAddress() %>" required>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary">Update</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <%
                                }
                            } else {
                        %>
                            <div class="col-12 text-center">
                                <div class="alert alert-info" role="alert">
                                    No orders found.
                                </div>
                            </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
