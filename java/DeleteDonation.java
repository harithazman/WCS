import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/DeleteDonation")
public class DeleteDonation extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String donationIdStr = request.getParameter("donation_id");

        if (donationIdStr == null || donationIdStr.isEmpty()) {
            // If donation_id is missing, handle the error
            request.setAttribute("errorMessage", "Donation ID is missing.");
            request.getRequestDispatcher("donation_list.jsp").forward(request, response);
            return;
        }

        // Parse donationId as Integer
        int donationId = Integer.parseInt(donationIdStr);

        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        // SQL query to delete the donation record
        String deleteQuery = "DELETE FROM donations WHERE donation_id = ?";

        try {
            // Establish the connection to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife_conservation", "root", "");

            // Prepare the statement and set the parameter
            stmt = conn.prepareStatement(deleteQuery);
            stmt.setInt(1, donationId);

            // Execute the delete query
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

        // Redirect to donation list page upon successful deletion
        if (success) {
            response.sendRedirect("donation_list.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to delete donation.");
            request.getRequestDispatcher("donation_list.jsp").forward(request, response);
        }
    }
}
