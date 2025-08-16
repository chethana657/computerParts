<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.ItemModel" %>
<%@ page import="com.DAO.ItemDao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.connection.DBConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        /* Add your custom styles here */
        body {
            background-color: #f2f7fa;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 1000px;
            margin: auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #dc3545; /* Red color for headings */
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th {
            background-color: #dc3545; /* Red header */
            color: white;
            text-align: center;
        }

        td, th {
            padding: 12px;
            text-align: left;
        }

        tr:hover {
            background-color: #f8d7da; /* Light red on row hover */
        }

        .btn {
            margin-right: 5px;
        }

        /* Sidebar Styles */
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

        .btn-primary {
            background-color: #dc3545; /* Red background for primary buttons */
            border-color: #dc3545; /* Red border for primary buttons */
        }

        .btn-primary:hover {
            background-color: #c82333; /* Darker red on hover */
            border-color: #bd2130; /* Darker red border on hover */
        }
        
        .btn-warning {
            background-color: #ffc107; /* Yellow color for warning button */
            border-color: #ffc107; /* Yellow border for warning button */
        }

        .btn-danger {
            background-color: #dc3545; /* Red background for delete buttons */
            border-color: #dc3545; /* Red border for delete buttons */
        }

        .btn-danger:hover {
            background-color: #c82333; /* Darker red on hover */
            border-color: #bd2130; /* Darker red border on hover */
        }

        .btn-info {
            background-color: #17a2b8; /* Teal color for info button */
            border-color: #17a2b8; /* Teal border for info button */
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
    <nav class="sidebar p-3">
        <h4>Admin Menu</h4>
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
    </nav>

    <div class="container flex-grow-1 mt-5">
        <h2 class="text-center">Inventory</h2>

        <a href="addInventory.jsp" class="btn btn-primary mb-3">Add New Item</a>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Item Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Status</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = DBConnect.getConnection();
                    ItemDao itemDao = new ItemDao(conn);
                    List<ItemModel> itemList = itemDao.getAllItems(); // Fetch the items

                    for (ItemModel item : itemList) {
                        int currentStatus = item.getStatus(); // Get status as an integer
                        String statusLabel = (currentStatus == 1) ? "Active" : "Inactive"; // Label for display
                %>
                <tr>
                    <td><%= item.getInventoryId() %></td>
                    <td><%= item.getItemName() %></td>
                    <td><%= item.getDescription() %></td>
                    <td><%= item.getPrice() %></td>
                    <td><%= item.getQuantity() %></td>
                    <td><%= statusLabel %></td>
                    <td><img src="<%= item.getImgURL() %>" alt="<%= item.getItemName() %>" style="width: 100px; height: auto;"></td>
                    <td>
                        <a href="updateInventory.jsp?id=<%= item.getInventoryId() %>" class="btn btn-warning btn-sm">Update</a>
                        
                        <!-- Form for Updating Status -->
                        <form action="/computerParts/ChangeStatusServlet" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= item.getInventoryId() %>">
                            <input type="hidden" name="status" value="<%= (currentStatus == 1) ? 0 : 1 %>"> <!-- Toggle the status -->
                            <button type="submit" class="btn btn-info btn-sm">Toggle Status</button>
                        </form>
                        
                        <a href="DeleteItemServlet?id=<%= item.getInventoryId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this item?');">Delete</a>
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
