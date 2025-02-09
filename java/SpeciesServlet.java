import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/SpeciesServlet")
public class SpeciesServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data from the request
        String speciesId = request.getParameter("species_id"); // If updating, species_id will be used
        String speciesName = request.getParameter("species_name");
        String scientificName = request.getParameter("scientific_name");
        String endangeredStatus = request.getParameter("endangered_status");
        String habitat = request.getParameter("habitat");
        
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Establish a connection to the database
            conn = dbconnector.getConnection();

            // Check if speciesId is empty for new species or not (for update or insert)
            if (speciesId == null || speciesId.isEmpty()) {
                // Insert new species
                String insertQuery = "INSERT INTO species (species_name, scientific_name, endangered_status, habitat) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(insertQuery);
                stmt.setString(1, speciesName);
                stmt.setString(2, scientificName);
                stmt.setString(3, endangeredStatus);
                stmt.setString(4, habitat);
                
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    request.setAttribute("message", "Species added successfully!");
                } else {
                    request.setAttribute("message", "Failed to add species.");
                }
            } else {
                // Update existing species
                String updateQuery = "UPDATE species SET species_name = ?, scientific_name = ?, endangered_status = ?, habitat = ? WHERE species_id = ?";
                stmt = conn.prepareStatement(updateQuery);
                stmt.setString(1, speciesName);
                stmt.setString(2, scientificName);
                stmt.setString(3, endangeredStatus);
                stmt.setString(4, habitat);
                stmt.setInt(5, Integer.parseInt(speciesId));
                
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    request.setAttribute("message", "Species updated successfully!");
                } else {
                    request.setAttribute("message", "Failed to update species.");
                }
            }

            // Forward to the page with a success or error message
            request.getRequestDispatcher("species_list.jsp").forward(request, response);

        } catch (SQLException e) {
            // Handle database error
            request.setAttribute("message", "Database error: " + e.getMessage());
            request.getRequestDispatcher("species_list.jsp").forward(request, response);
        } finally {
            // Close resources
            dbconnector.close(conn, stmt, null);
        }
    }
}
