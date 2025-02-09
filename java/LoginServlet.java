
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check if username and password are provided
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Both fields are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Authenticate user from database
        String role = authenticateUser(username, password);

        if (role != null) {
            // Successful authentication
            HttpSession session = request.getSession();
            session.setAttribute("username", username);  // Store the username in the session
            session.setAttribute("role", role);  // Store the role in the session

            // Set success message and redirect to the dashboard
            session.setAttribute("successMessage", "Login Successful!");
            response.sendRedirect("dashboard.jsp");
        } else {
            // Authentication failed
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Method to authenticate user from the database
    private String authenticateUser(String username, String password) {
        String role = null;
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection conn = dbconnector.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username);  // Set username
            stmt.setString(2, password);  // Set password

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // User found, and password matched
                    role = rs.getString("role"); // Get the role from the database
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Log the error for debugging
        }

        return role; // Return the role of the user
    }
}
