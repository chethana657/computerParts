package com.servelet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.DAO.ItemDao;
import com.connection.DBConnect;
import com.model.ItemModel;

@WebServlet("/UpdateItemServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB threshold
                 maxFileSize = 1024 * 1024 * 10,      // 10MB max file size
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB max request size
public class UpdateItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR = "./upload"; // Folder to store images

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("id"));
        String itemName = request.getParameter("itemName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String currentImageURL = request.getParameter("currentImageURL"); // Get the current image URL

        // Handle file upload
        String imgURL = currentImageURL; // Default to current image URL
        Part filePart = request.getPart("imgFile");

        // Check if a new file was uploaded
        if (filePart.getSize() > 0) {
            String fileName = getFileName(filePart);
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            
            // Check if directory exists and create if not
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // Creates the directory structure
            }

            // Save the file to the specified directory
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath); // Write the uploaded file to disk
            
            // Save the image URL relative to the application context
            imgURL = UPLOAD_DIR + File.separator + fileName; // Update imgURL with the new file path
        }

        // Create a new ItemModel object with the updated item details
        ItemModel updatedItem = new ItemModel();
        updatedItem.setInventoryId(itemId);
        updatedItem.setItemName(itemName);
        updatedItem.setDescription(description);
        updatedItem.setPrice(price);
        updatedItem.setQuantity(quantity);
        updatedItem.setImgURL(imgURL); // Use the new imgURL or keep the existing one

        // Save item details to the database
        Connection conn = DBConnect.getConnection();
        ItemDao itemDao = new ItemDao(conn);
        boolean isUpdated = itemDao.updateItem(updatedItem); // Ensure this method is implemented in ItemDao

        if (isUpdated) {
            request.setAttribute("successMessage", "Item updated successfully.");
        } else {
            request.setAttribute("errorMessage", "Failed to update item.");
        }

        // Redirect back to the inventory page
        request.getRequestDispatcher("inventory.jsp").forward(request, response);
    }

    // Extract the filename from the file part
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 2, content.length() - 1).replace("\"", ""); // Remove quotes
            }
        }
        return "default.jpg"; // Default filename if not provided
    }
}
