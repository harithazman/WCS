import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/Donation")
public class Donation extends HttpServlet {

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Get donation details from form
    String donorName = request.getParameter("donor_name");
    double amount = Double.parseDouble(request.getParameter("donation_amount"));
    String donationDate = request.getParameter("donation_date");
    String paymentMethod = request.getParameter("payment_method");

    // Check if user is logged in (session user_id exists)
    int userId = 0; // Default for guest users
    if (request.getSession().getAttribute("user_id") != null) {
        userId = (int) request.getSession().getAttribute("user_id");
    }

    // Debugging output to verify userId before inserting donation
    System.out.println("Debug: user_id for donation = " + userId);

    // Insert the donation
    boolean success = addDonation(userId, donorName, amount, donationDate, paymentMethod);

    // Redirect based on success
    if (success) {
        if (userId == 0) { // Guest user
            response.sendRedirect("thank_you.jsp");
        } else { // Logged-in user
            response.sendRedirect("donation_list.jsp");
        }
    } else {
        request.setAttribute("errorMessage", "Error processing donation.");
        request.getRequestDispatcher("add_donation.jsp").forward(request, response);
    }
}


    // Method to insert donation into the database
    private boolean addDonation(int userId, String donorName, double amount, String donationDate, String paymentMethod) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement stmt = null;

        // SQL query to insert data into the donations table
        String query = "INSERT INTO donations (user_id, donor_name, amount, donation_date, payment_method) VALUES (?, ?, ?, ?, ?)";

        try {
            // Establish the connection using dbconnector
            conn = dbconnector.getConnection();

            // Create a PreparedStatement to execute the SQL query
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);  // Set user_id (0 for guest users)
            stmt.setString(2, donorName);  // Set donor name
            stmt.setDouble(3, amount);     // Set donation amount
            stmt.setString(4, donationDate); // Set donation date
            stmt.setString(5, paymentMethod); // Set payment method

            // Execute the query and check if the insertion was successful
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                success = true;  // Donation inserted successfully
            }
        } catch (SQLException e) {
            // Log the error
            
        } finally {
            // Clean up the database resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
            }
        }

        return success;
    }
}


