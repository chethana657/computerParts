<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.OrderModel" %>
<%@ page import="com.DAO.OrderDao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.connection.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f2f7fa;
            font-family: Arial, sans-serif;
        }

        .container {
            margin-top: 30px;
        }

        h2 {
            color: #dc3545; /* Red color for heading */
            margin-bottom: 20px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th {
            background-color: #dc3545; /* Red background for table headers */
            color: white;
            text-align: center;
        }

        td, th {
            padding: 12px;
            text-align: left;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .btn {
            margin-right: 5px;
        }

        .sidebar {
            min-height: 100vh; /* Full height sidebar */
            background-color: #ffffff; /* White background for sidebar */
            border-right: 1px solid #dc3545; /* Red border */
        }

        .sidebar h4 {
            color: #dc3545; /* Red color for sidebar heading */
        }

        .sidebar .nav-link {
            color: #333; /* Dark text for links */
        }

        .sidebar .nav-link:hover {
            color: #dc3545; /* Red on hover */
        }

        .btn-warning {
            background-color: #ffc107; /* Yellow for update button */
            border-color: #ffc107; /* Yellow border */
        }

        .btn-warning:hover {
            background-color: #e0a800; /* Darker yellow on hover */
            border-color: #d39e00; /* Darker yellow border on hover */
        }

        .btn-danger {
            background-color: #dc3545; /* Red for delete button */
            border-color: #dc3545; /* Red border */
        }

        .btn-danger:hover {
            background-color: #c82333; /* Darker red on hover */
            border-color: #bd2130; /* Darker red border on hover */
        }

        .btn-info {
            background-color: #17a2b8; /* Teal for change status button */
            border-color: #17a2b8; /* Teal border */
        }

        .btn-info:hover {
            background-color: #138496; /* Darker teal on hover */
            border-color: #117a8b; /* Darker teal border on hover */
        }
    </style>
</head>
<body>
    <div class="d-flex">
        <!-- Sidebar -->
        <nav class="sidebar">
            <div class="position-sticky">
                <h4 class="p-3">Admin Menu</h4>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="admin_dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="inventory.jsp">Inventory Management</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="addInventory.jsp">Add Inventory</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="admin_allOrders.jsp">All Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Settings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Logout</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="container mt-5 ms-3">
            <h2 class="text-center">Orders</h2>

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>User ID</th>
                        <th>Address</th>
                        <th>Email</th>
                        <th>Mobile</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = DBConnect.getConnection();
                        OrderDao orderDao = new OrderDao(conn);
                        List<OrderModel> orderList = orderDao.getAllOrders(); // Fetch all orders

                        for (OrderModel order : orderList) {
                            String status = order.getStatus() == 1 ? "Pending" : "Completed"; // Check status
                    %>
                    <tr>
                        <td><%= order.getOrderId() %></td>
                        <td><%= order.getDate() %></td>
                        <td><%= status %></td> <!-- Display status -->
                        <td><%= order.getUserUserId() %></td>
                        <td><%= order.getAddress() %></td>
                        <td><%= order.getEmail() %></td>
                        <td><%= order.getMobile() %></td>
                        <td>
                            <!-- Removed Update button -->
                            <a href="DeleteOrderServlet?id=<%= order.getOrderId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this order?');">Delete</a>
                            <a href="ChangeOrderStatusServlet?id=<%= order.getOrderId() %>" class="btn btn-info btn-sm">Change Status</a> <!-- Change Status Button -->
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
