package com.servelet;

import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DAO.ItemDao;
import com.connection.DBConnect;

@WebServlet("/DeleteItemServlet")
public class DeleteItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("id"));
        Connection conn = DBConnect.getConnection();
        ItemDao itemDao = new ItemDao(conn);

        // Delete the item from the database
        boolean isDeleted = itemDao.deleteItem(itemId);

        // Set success or error message
        if (isDeleted) {
            request.setAttribute("successMessage", "Item deleted successfully.");
        } else {
            request.setAttribute("errorMessage", "Failed to delete item.");
        }

        // Redirect back to the inventory page
        request.getRequestDispatcher("inventory.jsp").forward(request, response);
    }
}
