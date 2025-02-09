import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/EditDonation")
public class EditDonation extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String donationIdStr = request.getParameter("donation_id");

        if (donationIdStr == null || donationIdStr.isEmpty()) {
            // If donation_id is missing or null, handle the error
            request.setAttribute("errorMessage", "Donation ID is missing.");
            request.getRequestDispatcher("donation_list.jsp").forward(request, response);
            return;
        }

        // Parse donationId as Integer
        int donationId = Integer.parseInt(donationIdStr); // this is safe now
        double donationAmount = Double.parseDouble(request.getParameter("donation_amount"));
        String donationDate = request.getParameter("donation_date");
        String paymentMethod = request.getParameter("payment_method");

        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        // SQL query to update donation record
        String updateQuery = "UPDATE donations SET amount = ?, donation_date = ?, payment_method = ? WHERE donation_id = ?";

        try {
            // Establish the connection to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife_conservation", "root", "");

            // Prepare the statement and set the parameters
            stmt = conn.prepareStatement(updateQuery);
            stmt.setDouble(1, donationAmount);
            stmt.setString(2, donationDate);
            stmt.setString(3, paymentMethod);
            stmt.setInt(4, donationId);

            // Execute the update query
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

        // Redirect to donation list page upon successful update
        if (success) {
            response.sendRedirect("donation_list.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to update donation details.");
            request.getRequestDispatcher("edit_donation.jsp").forward(request, response);
        }
    }
}
