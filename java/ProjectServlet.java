import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/ProjectServlet")
public class ProjectServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form data
        String projectName = request.getParameter("project_name");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String description = request.getParameter("description");

        // Validate inputs
        if (projectName == null || projectName.isEmpty() || startDate == null || startDate.isEmpty() || 
            endDate == null || endDate.isEmpty() || description == null || description.isEmpty()) {
            request.setAttribute("message", "Please fill in all fields.");
            request.getRequestDispatcher("add_project.jsp").forward(request, response);
            return;
        }

        // Database connection and PreparedStatement declaration
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            // Establish database connection using dbconnector
            conn = dbconnector.getConnection();
            
            // SQL query to insert a new project
            String insertQuery = "INSERT INTO projects (project_name, start_date, end_date, description) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertQuery);
            stmt.setString(1, projectName);
            stmt.setString(2, startDate);
            stmt.setString(3, endDate);
            stmt.setString(4, description);

            // Execute the query and check if the insertion is successful
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;

        } catch (SQLException e) { // Log the exception and display a user-friendly message
            // Optionally, log this to a file
            // Optionally, log this to a file
            request.setAttribute("message", "Database error occurred while adding the project.");
            request.getRequestDispatcher("add_project.jsp").forward(request, response);
            return;
        } finally {
            // Ensure resources are properly closed
            dbconnector.closeConnection(conn, stmt, null);
        }

        // Redirect to project list if successful, or return with an error message
        if (success) {
            response.sendRedirect("project_list.jsp");  // Redirect to project list page after successful insert
        } else {
            request.setAttribute("message", "Failed to add project.");
            request.getRequestDispatcher("add_project.jsp").forward(request, response);  // Show error message
        }
    }
}
