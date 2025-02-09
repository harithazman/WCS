import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditSpecies")
public class EditSpecies extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String speciesIdStr = request.getParameter("species_id");
        String speciesName = request.getParameter("species_name");
        String scientificName = request.getParameter("scientific_name");
        String endangeredStatus = request.getParameter("endangered_status");
        String habitat = request.getParameter("habitat");

        // Validate species_id
        if (speciesIdStr == null || speciesIdStr.isEmpty()) {
            request.setAttribute("errorMessage", "Species ID is missing.");
            request.getRequestDispatcher("species_list.jsp").forward(request, response);
            return;
        }

        int speciesId = Integer.parseInt(speciesIdStr);
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        // SQL query to update species information
        String updateQuery = "UPDATE species SET species_name = ?, scientific_name = ?, endangered_status = ?, habitat = ? WHERE species_id = ?";

        try {
            // Get database connection
            conn = dbconnector.getConnection();

            // Prepare statement and set parameters
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, speciesName);
            stmt.setString(2, scientificName);
            stmt.setString(3, endangeredStatus);
            stmt.setString(4, habitat);
            stmt.setInt(5, speciesId);

            // Execute update
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Clean up database resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Redirect to species list page upon successful update
        if (success) {
            response.sendRedirect("species_list.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to update species.");
            request.getRequestDispatcher("edit_species.jsp").forward(request, response);
        }
    }
}
