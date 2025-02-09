import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/EditProject")
public class EditProject extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String projectId = request.getParameter("project_id");
        String projectName = request.getParameter("project_name");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String description = request.getParameter("description");

        // Validation (optional)
        if (projectName == null || startDate == null || endDate == null || description == null || projectId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing data");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = dbconnector.getConnection();

            // Update SQL query
            String updateQuery = "UPDATE projects SET project_name = ?, start_date = ?, end_date = ?, description = ? WHERE project_id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, projectName);
            stmt.setString(2, startDate);
            stmt.setString(3, endDate);
            stmt.setString(4, description);
            stmt.setInt(5, Integer.parseInt(projectId));

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbconnector.closeConnection(conn, stmt, null);
        }

        if (success) {
            // Redirect back to the project list with a success message
            request.setAttribute("message", "Project updated successfully!");
            response.sendRedirect("project_list.jsp");
        } else {
            // Send an error message if the update failed
            request.setAttribute("message", "Failed to update project.");
            response.sendRedirect("edit_project.jsp?project_id=" + projectId); // Stay on the edit page if it fails
        }
    }
}
