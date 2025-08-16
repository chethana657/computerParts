package com.servelet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.OrderDao;
import com.connection.DBConnect;
import com.model.OrderModel;
import com.model.UserModel;

@WebServlet("/CreateOrderServlet")
public class CreateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel currentUser = (UserModel) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection conn = null; // Initialize connection variable
        try {
            // Get request parameters
            int inventoryId = Integer.parseInt(request.getParameter("itemId"));
            int userId = currentUser.getUserId();
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            int quantity = Integer.parseInt(request.getParameter("quantity")); // Get quantity
            double totalPrice = Double.parseDouble(request.getParameter("totalPrice")); // Get total price

            // Create an OrderModel instance
            OrderModel order = new OrderModel();
            order.setInventoryInventoryId(inventoryId);
            order.setUserUserId(userId);
            order.setAddress(address);
            order.setEmail(email);
            order.setMobile(mobile);
            order.setStatus(1);  // Set status (you may want to define what this means in your context)
            order.setDate(new Timestamp(System.currentTimeMillis())); // Set current timestamp as order date
            order.setQuantity(quantity); // Set quantity
            order.setTotalPrice(totalPrice); // Set total price

            // Database connection
            conn = DBConnect.getConnection();
            OrderDao orderDao = new OrderDao(conn);

            // Save the order to the database
            boolean isOrderCreated = orderDao.addOrder(order);

            if (isOrderCreated) {
                session.setAttribute("orderSuccess", "Order placed successfully.");
                response.sendRedirect("home.jsp"); // Redirect to a success page
            } else {
                session.setAttribute("orderError", "Failed to place order. Please try again.");
                response.sendRedirect("buyItem.jsp?id=" + inventoryId); // Redirect back to the buy item page
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("orderError", "Something went wrong. Please try again.");
            response.sendRedirect("buyItem.jsp");
        } finally {
            // Close the connection if it was opened
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
