<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.UserModel" %>
<%@ page import="com.DAO.UserDao" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page import="java.sql.Connection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f2f7fa;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 30px;
        }
        .sidebar {
            min-height: 100vh; /* Full height sidebar */
        }
        .sidebar {
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
        h1 {
            color: #dc3545; /* Red color for headings */
        }
        .table thead th {
            background-color: #dc3545; /* Red header */
            color: white; /* White text for header */
        }
        .table tbody tr:hover {
            background-color: #f8d7da; /* Light red on row hover */
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

    <div class="container flex-grow-1">
        <h1>Admin Dashboard</h1>

        <%
            // Database connection
            Connection con = DBConnect.getConnection();
            UserDao userDao = new UserDao(con);

            // Fetch all users from the database
            List<UserModel> users = userDao.getAllUsers();
        %>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Status</th>
                    <th>Actions</th> <!-- New Actions Column -->
                </tr>
            </thead>
            <tbody>
                <%
                    if (users != null && !users.isEmpty()) {
                        for (UserModel user : users) {
                %>
                    <tr>
                        <td><%= user.getUserId() %></td>
                        <td><%= user.getFirstName() %></td>
                        <td><%= user.getLastName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getMobile() %></td>
                        <td><%= user.getStatus() == 1 ? "Active" : "Inactive" %></td>
                        <td>
                            <form action="DeleteUserServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="7" class="text-center">No users found.</td>
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
