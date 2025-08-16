package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.PaymentModel;

public class PaymentDao {
    private Connection conn;

    public PaymentDao(Connection conn) {
        this.conn = conn;
    }

    // Add a new payment
    public boolean addPayment(PaymentModel payment) {
        String query = "INSERT INTO payment (cardNumber, cvv, expireDate, user_userId) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, payment.getCardNumber());
            pstmt.setString(2, payment.getCvv());
            pstmt.setString(3, payment.getExpireDate());
            pstmt.setInt(4, payment.getUserUserId());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // Return true if the payment was added successfully
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false in case of an error
        }
    }

    // Get a list of payments by user ID
    public List<PaymentModel> getPaymentsByUserId(int userId) {
        List<PaymentModel> paymentList = new ArrayList<>();
        String query = "SELECT * FROM payment WHERE user_userId = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                PaymentModel payment = new PaymentModel();
                payment.setPaymentId(rs.getInt("paymentId"));
                payment.setCardNumber(rs.getString("cardNumber"));
                payment.setCvv(rs.getString("cvv"));
                payment.setExpireDate(rs.getString("expireDate"));
                // Add other fields if necessary

                paymentList.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentList; // Return the list of payments
    }

 // Method to delete payment by ID
    public boolean deletePaymentById(String paymentId) {
        boolean isDeleted = false;
        String sql = "DELETE FROM payment WHERE paymentId = ?"; // Adjust the table name as per your schema

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, paymentId);
            int rowsAffected = stmt.executeUpdate();
            isDeleted = (rowsAffected > 0); // If at least one row was affected, deletion was successful
        } catch (SQLException e) {
            e.printStackTrace(); // Log exception
        }

        return isDeleted;
    }

    // Update an existing payment
    public boolean updatePayment(PaymentModel payment) {
        String query = "UPDATE payment SET cardNumber = ?, cvv = ?, expireDate = ? WHERE paymentId = ? AND user_userId = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, payment.getCardNumber());
            stmt.setString(2, payment.getCvv());
            stmt.setString(3, payment.getExpireDate());
            stmt.setInt(4, payment.getPaymentId());
            stmt.setInt(5, payment.getUserUserId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Returns true if a row was updated
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
            return false; // Return false if there was an exception
        }
    }

    // Get a payment by ID
    public PaymentModel getPaymentById(int paymentId) {
        PaymentModel payment = null;
        String query = "SELECT * FROM payment WHERE paymentId = ?"; // Adjust table name if necessary

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, paymentId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                payment = new PaymentModel();
                payment.setPaymentId(rs.getInt("paymentId")); // Assuming paymentId is your primary key
                payment.setCardNumber(rs.getString("cardNumber"));
                payment.setCvv(rs.getString("cvv"));
                payment.setExpireDate(rs.getString("expireDate"));
                payment.setUserUserId(rs.getInt("user_userId")); // Ensure this field is set
                // Add other fields if necessary
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
        }
        return payment; // Return the retrieved payment or null if not found
    }
    
 // Get payment methods (card number only) by user ID
    public List<PaymentModel> getPaymentMethodsByUserId(int userId) {
        List<PaymentModel> paymentList = new ArrayList<>();
        String query = "SELECT paymentId, cardNumber FROM payment WHERE user_userId = ?";
        
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                PaymentModel payment = new PaymentModel();
                payment.setPaymentId(rs.getInt("paymentId"));

                // Mask the card number except the last 4 digits
                String cardNumber = rs.getString("cardNumber");
                if (cardNumber.length() >= 4) {
                    cardNumber = "**** **** **** " + cardNumber.substring(cardNumber.length() - 4);
                }
                payment.setCardNumber(cardNumber);
                
                paymentList.add(payment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentList; // Return the list of payment methods (card numbers)
    }
}
