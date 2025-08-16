package com.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.model.ItemModel;

public class ItemDao {
    private Connection conn;

    public ItemDao(Connection conn) {
        this.conn = conn;
    }

    // Method to add a new item
    public boolean addItem(ItemModel item) {
        boolean isSuccess = false;
        String query = "INSERT INTO inventory (itemName, description, price, quantity, status, imgURL) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, item.getItemName());
            pstmt.setString(2, item.getDescription());
            pstmt.setDouble(3, item.getPrice());
            pstmt.setInt(4, item.getQuantity());
            pstmt.setInt(5, item.getStatus());
            pstmt.setString(6, item.getImgURL());
            isSuccess = pstmt.executeUpdate() > 0; // Returns true if a row was affected
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // Method to get all items from the inventory
    public List<ItemModel> getAllItems() {
        List<ItemModel> itemList = new ArrayList<>();
        String query = "SELECT * FROM inventory";
        
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                ItemModel item = new ItemModel();
                item.setInventoryId(rs.getInt("inventoryId"));
                item.setItemName(rs.getString("itemName"));
                item.setDescription(rs.getString("description"));
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setStatus(rs.getInt("status"));
                item.setImgURL(rs.getString("imgURL"));
                itemList.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return itemList;
    }

    // Method to delete an item by ID
    public boolean deleteItem(int itemId) {
        boolean result = false;
        String query = "DELETE FROM inventory WHERE inventoryId = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, itemId);
            result = ps.executeUpdate() > 0; // returns true if row is deleted
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Method to get an item by ID
    public ItemModel getItemById(int itemId) {
        ItemModel item = null;
        String query = "SELECT * FROM inventory WHERE inventoryId = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, itemId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    item = new ItemModel();
                    item.setInventoryId(rs.getInt("inventoryId"));
                    item.setItemName(rs.getString("itemName"));
                    item.setDescription(rs.getString("description"));
                    item.setPrice(rs.getDouble("price"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setStatus(rs.getInt("status"));
                    item.setImgURL(rs.getString("imgURL"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return item;
    }

    // Method to update an item
    public boolean updateItem(ItemModel item) {
        boolean isSuccess = false;
        String query = "UPDATE inventory SET itemName = ?, description = ?, price = ?, quantity = ?, imgURL = ? WHERE inventoryId = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, item.getItemName());
            pstmt.setString(2, item.getDescription());
            pstmt.setDouble(3, item.getPrice());
            pstmt.setInt(4, item.getQuantity());
            pstmt.setString(5, item.getImgURL());
            pstmt.setInt(6, item.getInventoryId());
            isSuccess = pstmt.executeUpdate() > 0; // Returns true if a row was updated
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // Method to update an item's status
    public boolean updateItemStatus(int itemId, int newStatus) {
        boolean isSuccess = false;
        String query = "UPDATE inventory SET status = ? WHERE inventoryId = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, newStatus);
            pstmt.setInt(2, itemId);
            isSuccess = pstmt.executeUpdate() > 0; // Returns true if a row was updated
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // Additional methods can be added here if needed
}
