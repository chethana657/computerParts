<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.ItemModel" %>
<%@ page import="com.DAO.ItemDao" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Inventory</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f9f9f9; /* Light grey background */
            font-family: 'Arial', sans-serif;
        }
        h2 {
            color: #dc3545; /* Red color for the heading */
            font-weight: bold;
        }
        .navbar {
            background-color: #dc3545; /* Red navbar */
        }
        .navbar-brand, .nav-link {
            color: white !important; /* White text */
        }
        .navbar-brand:hover, .nav-link:hover {
            color: #c82333 !important; /* Darker red on hover */
        }
        .hero {
            background: url('./upload/hero.png') no-repeat center center/cover; /* Replace with your image URL */
            height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            margin-bottom: 30px;
        }
        .hero h1 {
            font-size: 3rem;
            margin: 0;
        }
        .hero p {
            font-size: 1.5rem;
        }
        .card {
            margin: 15px;
            border: 1px solid #dc3545; /* Red border for the cards */
            border-radius: 10px; /* Rounded corners for the cards */
            transition: transform 0.2s; /* Smooth scaling on hover */
        }
        .card:hover {
            transform: scale(1.05); /* Scale up on hover */
        }
        .card img {
            border-radius: 10px 10px 0 0; /* Round the top corners of the image */
        }
        .card-body {
            background-color: #fff; /* White background for card body */
        }
        .btn-primary {
            background-color: #dc3545; /* Red button */
            border: none;
        }
        .btn-primary:hover {
            background-color: #c82333; /* Darker red on hover */
        }
        .banner {
            background-color: #f8d7da; /* Light red banner background */
            padding: 15px;
            margin-bottom: 20px;
            text-align: center;
            border-radius: 5px;
        }
        .category-title {
            margin-bottom: 15px;
            font-weight: bold;
        }
        .footer {
            background-color: #dc3545; /* Footer color */
            color: white;
            padding: 15px;
            text-align: center;
            position: relative;
            bottom: 0;
            width: 100%;
            margin-top: 30px;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container">
        <a class="navbar-brand" href="#">Computer Parts Shop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="about.jsp">About Us</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="contact.jsp">Contact</a>
                </li>
                <%
                    // Check if a user is logged in
                    if (session.getAttribute("currentUser") != null) {
                %>
                    <li class="nav-item">
                        <a class="nav-link" href="profile.jsp">Profile</a>
                    </li>
                <%
                    } else {
                %>
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</nav>


<!-- Hero Section -->
<div class="hero">
    <div>
        <h1>Welcome to Our Shop!</h1>
        <p>Your one-stop destination for computer parts.</p>
    </div>
</div>

<div class="container mt-5">
    <h2 class="text-center mb-4">Explore Our Products!</h2>
    
    <div class="banner">
        <h4>🎉 Limited Time Offer: Get 20% off on all graphics cards! 🎉</h4>
    </div>
    
    <div class="row category">
        <h3 class="category-title text-center">Shop by Category</h3>
        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Processors</h5>
                    <p class="card-text">Find the latest CPUs for your computer.</p>
                    <a href="processors.jsp" class="btn btn-primary">Shop Now</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Graphics Cards</h5>
                    <p class="card-text">Upgrade your gaming experience.</p>
                    <a href="graphicsCards.jsp" class="btn btn-primary">Shop Now</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Motherboards</h5>
                    <p class="card-text">Explore our range of motherboards.</p>
                    <a href="motherboards.jsp" class="btn btn-primary">Shop Now</a>
                </div>
            </div>
        </div>
    </div>

    <h3 class="text-center mb-4">Available Items</h3>
    
    <div class="row">
        <%
            // Get database connection
            Connection con = DBConnect.getConnection();
            ItemDao itemDao = new ItemDao(con);
            List<ItemModel> itemList = itemDao.getAllItems(); // Fetch all items

            // Check if there are any items
            if (itemList != null && !itemList.isEmpty()) {
                for (ItemModel item : itemList) {
                    // Filter items with status = 0 (available)
                    if (item.getStatus() == 0) {
        %>
                        <div class="col-md-4">
                            <div class="card">
                                <img src="<%= item.getImgURL() %>" class="card-img-top" alt="<%= item.getItemName() %>" style="height: 200px; object-fit: cover;">
                                <div class="card-body">
                                    <h5 class="card-title"><%= item.getItemName() %></h5>
                                    <p class="card-text"><%= item.getDescription() %></p>
                                    <p class="card-text"><strong>Price:</strong> $<%= item.getPrice() %></p>
                                    <p class="card-text"><strong>Quantity:</strong> <%= item.getQuantity() %></p>
                                    <a href="buyItem.jsp?id=<%= item.getInventoryId() %>" class="btn btn-primary">Buy</a> <!-- Buy button -->
                                </div>
                            </div>
                        </div>
        <%
                    }
                }
            } else {
        %>
                <div class="col-12">
                    <p class="text-center">No available items found.</p>
                </div>
        <%
            }
            // Close the connection after use
            if (con != null) {
                con.close();
            }
        %>
    </div>
</div>

<div class="footer">
    <p>&copy; 2024 Computer Parts Shop | All rights reserved.</p>
    <p>Follow us on social media!</p>
    <p><a href="admin_dashboard.jsp" class="text-white">Admin Dashboard</a></p> <!-- Admin Dashboard link -->
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
