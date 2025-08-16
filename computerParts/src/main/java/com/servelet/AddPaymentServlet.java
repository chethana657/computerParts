package com.servelet;

import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.PaymentDao;
import com.connection.DBConnect;
import com.model.PaymentModel;

@WebServlet("/AddPaymentServlet")
public class AddPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve payment details from the request
        String cardNumber = request.getParameter("cardNumber");
        String cvv = request.getParameter("cvv");
        String expireDate = request.getParameter("expireDate");
        int userId = Integer.parseInt(request.getParameter("user_userId")); // User ID from the session

        // Create a PaymentModel object
        PaymentModel payment = new PaymentModel();
        payment.setCardNumber(cardNumber);
        payment.setCvv(cvv);
        payment.setExpireDate(expireDate);
        payment.setUserUserId(userId); // Set user ID in the payment model

        // Initialize database connection
        Connection conn = DBConnect.getConnection();
        PaymentDao paymentDao = new PaymentDao(conn);

        // Add payment to the database
        boolean isAdded = paymentDao.addPayment(payment);

        // Redirect based on the result of the addition
        if (isAdded) {
            // Redirect to success page or home with success message
            response.sendRedirect("profile.jsp");
        } else {
            // Redirect back to the payment page with an error message
            response.sendRedirect("addPaymentMethod.jsp");
        }
    }
}
