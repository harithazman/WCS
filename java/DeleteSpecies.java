import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/DeleteSpecies")
public class DeleteSpecies extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String speciesId = request.getParameter("species_id");

        // Check if speciesId is valid
        if (speciesId == null || speciesId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Species ID is missing.");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            // Establish the database connection
            conn = dbconnector.getConnection();

            // SQL query to delete the species
            String deleteQuery = "DELETE FROM species WHERE species_id = ?";
            stmt = conn.prepareStatement(deleteQuery);
            stmt.setInt(1, Integer.parseInt(speciesId)); // Set the species_id for deletion

            // Execute the delete query
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;  // Check if any rows were affected
        } catch (SQLException e) {
// Log the error (Optional, for debugging purposes)
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred while deleting species.");
            return;
        } finally {
            // Clean up the database resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
            }
        }

        // Redirect based on the success of the operation
        if (success) {
            request.setAttribute("message", "Species deleted successfully.");
            response.sendRedirect("species_list.jsp");
        } else {
            // Send an error response if deletion was unsuccessful
            request.setAttribute("message", "Failed to delete species.");
            response.sendRedirect("species_list.jsp");
        }
    }

    // Optionally, you can add a fallback for GET requests:
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not allowed for deletion.");
    }
}
