import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/DeleteProject")
public class DeleteProject extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String projectId = request.getParameter("project_id");

        // Check if projectId is valid
        if (projectId == null || projectId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Project ID is missing.");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = dbconnector.getConnection();

            // SQL query to delete the project
            String deleteQuery = "DELETE FROM projects WHERE project_id = ?";
            stmt = conn.prepareStatement(deleteQuery);
            stmt.setInt(1, Integer.parseInt(projectId));

            // Execute the delete query
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred while deleting project.");
            return;
        } finally {
            dbconnector.closeConnection(conn, stmt, null);
        }

        if (success) {
            request.setAttribute("message", "Project deleted successfully.");
            response.sendRedirect("project_list.jsp");
        } else {
            request.setAttribute("message", "Failed to delete project.");
            response.sendRedirect("project_list.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not allowed for deletion.");
    }
}
