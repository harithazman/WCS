import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/getSpeciesData")
public class GetSpeciesDataServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type to JSON
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Database connection setup
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        // SQL query to retrieve species data
        String query = "SELECT species_name, scientific_name, endangered_status, habitat FROM species";

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_db", "username", "password");
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);

            // Create a JSON array to store the species data
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("[");

            while (rs.next()) {
                jsonResponse.append("{")
                            .append("\"species_name\":\"").append(rs.getString("species_name")).append("\",")
                            .append("\"scientific_name\":\"").append(rs.getString("scientific_name")).append("\",")
                            .append("\"endangered_status\":\"").append(rs.getString("endangered_status")).append("\",")
                            .append("\"habitat\":\"").append(rs.getString("habitat")).append("\"")
                            .append("},");
            }
            jsonResponse.deleteCharAt(jsonResponse.length() - 1); // Remove the trailing comma
            jsonResponse.append("]");

            // Send the JSON response
            out.write(jsonResponse.toString());

        } catch (SQLException e) {
            e.printStackTrace();
            out.write("{\"error\":\"Failed to retrieve data\"}");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
