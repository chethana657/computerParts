<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.DAO.PaymentDao" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>

<%
    // Get the paymentId from the request
    String paymentId = request.getParameter("paymentId");

    // Initialize PaymentDao and establish a database connection
    PaymentDao paymentDao = null;
    Connection conn = null;

    try {
        // Get a connection using the DBConnect class
        conn = DBConnect.getConnection();
        paymentDao = new PaymentDao(conn);
        
        // Delete the payment method using the paymentId
        boolean isDeleted = paymentDao.deletePaymentById(paymentId);

        // Redirect based on the deletion status
        if (isDeleted) {
            response.sendRedirect("myPaymentMethod.jsp?message=Payment method deleted successfully.");
        } else {
            response.sendRedirect("myPaymentMethod.jsp?error=Failed to delete payment method.");
        }
    } catch (Exception e) {
        e.printStackTrace(); // Log the exception
        response.sendRedirect("myPaymentMethod.jsp?error=An error occurred while deleting the payment method.");
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
%>
