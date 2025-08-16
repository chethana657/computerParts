package com.DAO;

import com.model.UserModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDao {

    private Connection DBConnect;

    // Constructor to initialize the database connection
    public UserDao(Connection DBConnect) {
        this.DBConnect = DBConnect;
    }

    // Register a new user with raw password and integer status
    public boolean registerUser(UserModel user) {
        String query = "INSERT INTO user (firstName, lastName, email, mobile, status, password) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = DBConnect.prepareStatement(query)) {
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getMobile());
            ps.setInt(5, user.getStatus());  // Status is now an integer
            ps.setString(6, user.getPassword()); // Save the raw password

            int result = ps.executeUpdate();
            return result > 0;  // If a row was inserted, return true

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, "Error during user registration", ex);
        }
        return false;  // If an error occurs or no rows were inserted, return false
    }

    // Login validation (check if user exists with given email and password)
    public UserModel loginUser(String email, String password) {
        String query = "SELECT * FROM user WHERE email = ? AND password = ?";
        try (PreparedStatement ps = DBConnect.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, password); // Use raw password for login check

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Get user data
                UserModel user = new UserModel();
                user.setUserId(rs.getInt("userId"));
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                user.setStatus(rs.getInt("status"));  // Status is now an integer
                user.setPassword(rs.getString("password")); // Raw password is fetched

                return user;  // Return the found user
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, "Error during user login", ex);
        }
        return null;  // Return null if no user is found or password doesn't match
    }

    // Update user details, excluding password
    public boolean updateUser(UserModel user) {
        String query = "UPDATE user SET firstName = ?, lastName = ?, email = ?, mobile = ? WHERE userId = ?";
        try (PreparedStatement ps = DBConnect.prepareStatement(query)) {
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getMobile());
            ps.setInt(5, user.getUserId());

            int result = ps.executeUpdate();
            return result > 0;  // If the row was updated, return true

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, "Error updating user", ex);
        }
        return false;  // Return false if no rows were updated
    }

    // Fetch user details by userId
    public UserModel getUserById(int userId) {
        String query = "SELECT * FROM user WHERE userId = ?";
        try (PreparedStatement ps = DBConnect.prepareStatement(query)) {
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                UserModel user = new UserModel();
                user.setUserId(rs.getInt("userId"));
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                user.setStatus(rs.getInt("status"));  // Status is now an integer
                user.setPassword(rs.getString("password")); // Raw password is fetched
                return user;  // Return the found user
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, "Error fetching user by ID", ex);
        }
        return null;  // Return null if no user is found
    }

    // Update user password
    public boolean updateUserPassword(int userId, String newPassword) {
        String query = "UPDATE user SET password = ? WHERE userId = ?";
        try (PreparedStatement ps = DBConnect.prepareStatement(query)) {
            ps.setString(1, newPassword); // Set the new raw password
            ps.setInt(2, userId); // Set the userId for the update

            int result = ps.executeUpdate();
            return result > 0; // Return true if the row was updated
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, "Error updating user password", ex);
        }
        return false; // Return false if no rows were updated
    }
    
    // Fetch all users
    public List<UserModel> getAllUsers() {
        List<UserModel> users = new ArrayList<>();
        String query = "SELECT * FROM user"; // Adjust the table name as needed

        try (PreparedStatement pstmt = DBConnect.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                UserModel user = new UserModel();
                user.setUserId(rs.getInt("userId"));
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                user.setStatus(rs.getInt("status"));
                users.add(user);
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, "Error fetching all users", e);
        }

        return users; // Return the list of users
    }
    
    // Delete a user by userId
    public boolean deleteUser(int userId) {
        String query = "DELETE FROM user WHERE userId = ?";
        try (PreparedStatement pstmt = DBConnect.prepareStatement(query)) {
            pstmt.setInt(1, userId); // Use int for userId
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // Return true if a user was deleted
        } catch (SQLException e) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, "Error deleting user", e);
        }
        return false; // Return false if no rows were deleted
    }
}
