package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.model.OrderModel;

public class OrderDao {
    private Connection conn;

    public OrderDao(Connection conn) {
        this.conn = conn;
    }

    public boolean addOrder(OrderModel order) {
        String query = "INSERT INTO `order` (date, status, user_userId, inventory_inventoryId, address, email, mobile, quantity, totalPrice) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            if (order.getDate() != null) {
                pstmt.setTimestamp(1, new Timestamp(order.getDate().getTime()));
            } else {
                pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
            }

            pstmt.setInt(2, order.getStatus());
            pstmt.setInt(3, order.getUserUserId());
            pstmt.setInt(4, order.getInventoryInventoryId());
            pstmt.setString(5, order.getAddress());
            pstmt.setString(6, order.getEmail());
            pstmt.setString(7, order.getMobile());
            pstmt.setInt(8, order.getQuantity());
            pstmt.setDouble(9, order.getTotalPrice());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<OrderModel> getOrdersByUserId(int userId) {
        List<OrderModel> orderList = new ArrayList<>();
        String query = "SELECT * FROM `order` WHERE user_userId = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    OrderModel order = new OrderModel();
                    order.setOrderId(rs.getInt("orderId"));
                    order.setDate(rs.getTimestamp("date"));
                    order.setStatus(rs.getInt("status"));
                    order.setUserUserId(rs.getInt("user_userId"));
                    order.setInventoryInventoryId(rs.getInt("inventory_inventoryId"));
                    order.setAddress(rs.getString("address"));
                    order.setEmail(rs.getString("email"));
                    order.setMobile(rs.getString("mobile"));
                    order.setQuantity(rs.getInt("quantity"));
                    order.setTotalPrice(rs.getDouble("totalPrice"));
                    orderList.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    public List<OrderModel> getAllOrders() {
        List<OrderModel> orderList = new ArrayList<>();
        String query = "SELECT * FROM `order`";

        try (PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                OrderModel order = new OrderModel();
                order.setOrderId(rs.getInt("orderId"));
                order.setDate(rs.getTimestamp("date"));
                order.setStatus(rs.getInt("status"));
                order.setUserUserId(rs.getInt("user_userId"));
                order.setInventoryInventoryId(rs.getInt("inventory_inventoryId"));
                order.setAddress(rs.getString("address"));
                order.setEmail(rs.getString("email"));
                order.setMobile(rs.getString("mobile"));
                order.setQuantity(rs.getInt("quantity"));
                order.setTotalPrice(rs.getDouble("totalPrice"));
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderList;
    }

    public OrderModel getOrderById(int orderId) {
        OrderModel order = null;
        String query = "SELECT * FROM `order` WHERE orderId = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, orderId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    order = new OrderModel();
                    order.setOrderId(rs.getInt("orderId"));
                    order.setDate(rs.getTimestamp("date"));
                    order.setStatus(rs.getInt("status"));
                    order.setUserUserId(rs.getInt("user_userId"));
                    order.setInventoryInventoryId(rs.getInt("inventory_inventoryId"));
                    order.setAddress(rs.getString("address"));
                    order.setEmail(rs.getString("email"));
                    order.setMobile(rs.getString("mobile"));
                    order.setQuantity(rs.getInt("quantity"));
                    order.setTotalPrice(rs.getDouble("totalPrice"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order; // Return the order object or null if not found
    }

    public boolean updateOrder(String orderId, String email, String mobile, String address) {
        boolean isUpdated = false;
        String query = "UPDATE `order` SET email = ?, mobile = ?, address = ? WHERE orderId = ? AND status = 1";

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, email);
            pstmt.setString(2, mobile);
            pstmt.setString(3, address);
            pstmt.setString(4, orderId);

            int rowsAffected = pstmt.executeUpdate();
            isUpdated = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isUpdated;
    }

    public boolean updateOrderStatus(int orderId, int newStatus) {
        boolean isUpdated = false;
        String query = "UPDATE `order` SET status = ? WHERE orderId = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, newStatus); // Set the new status
            pstmt.setInt(2, orderId); // Set the order ID for the update

            int rowsAffected = pstmt.executeUpdate();
            isUpdated = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isUpdated; // Return true if the status was updated successfully
    }
    
 // Method to delete an order by its ID
    public boolean deleteOrder(String orderId) {
        boolean result = false;
        String query = "DELETE FROM `order` WHERE orderId = ?"; // Change 'orders' to your actual table name
        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, orderId);
            int rowsAffected = stmt.executeUpdate();
            result = rowsAffected > 0; // Returns true if the order was deleted
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Other methods such as deleteOrder, etc., can be added here as needed
}
