package com.servelet;

import com.DAO.PaymentDao;
import com.connection.DBConnect;
import com.model.PaymentModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/updatePaymentMethod")
public class UpdatePaymentMethodServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        int paymentId = Integer.parseInt(request.getParameter("paymentId")); // Ensure paymentId is parsed as int
        String cardNumber = request.getParameter("cardNumber");
        String cvv = request.getParameter("cvv");
        String expireDate = request.getParameter("expireDate");
        int userUserId = Integer.parseInt(request.getParameter("userUserId")); // User ID associated with the payment

        // Initialize PaymentDao and establish a database connection
        PaymentDao paymentDao = null;
        Connection conn = null;

        try {
            // Get a connection using the DBConnect class
            conn = DBConnect.getConnection();
            paymentDao = new PaymentDao(conn);
            
            // Create a PaymentModel object with updated details
            PaymentModel payment = new PaymentModel(paymentId, cardNumber, cvv, expireDate, userUserId);
            
            // Update the payment method
            boolean isUpdated = paymentDao.updatePayment(payment);

            // Redirect based on the update status
            if (isUpdated) {
                response.sendRedirect("myPaymentMethod.jsp?message=Payment method updated successfully.");
            } else {
                response.sendRedirect("myPaymentMethod.jsp?error=Failed to update payment method.");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            response.sendRedirect("myPaymentMethod.jsp?error=An error occurred while updating the payment method.");
        } finally {
            // Close the connection if it's not null
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace(); // Log closing exception
                }
            }
        }
    }
}
