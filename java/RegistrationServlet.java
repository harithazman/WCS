import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Validate form fields
        if (username == null || password == null || role == null || username.isEmpty() || password.isEmpty() || role.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("registration.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = dbconnector.getConnection();

            // Step 1: Get the current max user_id
            String maxIdQuery = "SELECT MAX(user_id) FROM users";
            stmt = conn.prepareStatement(maxIdQuery);
            rs = stmt.executeQuery();

            int newUserId = 1; // Default to 1 if no records exist
            if (rs.next()) {
                newUserId = rs.getInt(1) + 1; // Increment max user_id
            }

            // Step 2: Insert the new user with incremented user_id
            String insertQuery = "INSERT INTO users (user_id, username, password, role) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertQuery);
            stmt.setInt(1, newUserId);
            stmt.setString(2, username);
            stmt.setString(3, password); // Use the plain password (or hash it for security)
            stmt.setString(4, role);

            int result = stmt.executeUpdate();
            if (result > 0) {
                // Registration successful, redirect to login page
                response.sendRedirect("login.jsp");
            } else {
                // Registration failed
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("registration.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            // Print detailed SQL error to the log for debugging
            request.setAttribute("errorMessage", "An error occurred while registering. Please try again. " + e.getMessage());
            request.getRequestDispatcher("registration.jsp").forward(request, response);
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
    }
}
