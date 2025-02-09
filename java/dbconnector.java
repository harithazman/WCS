import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class dbconnector {

    // Database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/wildlife_conservation?zeroDateTimeBehavior=convertToNull";
    private static final String USER = "root";  // Update with your DB username
    private static final String PASSWORD = "";  // Blank password for root
    private static Connection connection;

    // Get database connection
    public static Connection getConnection() throws SQLException {
        // Check if connection is already established or not
        if (connection == null || connection.isClosed()) {
            try {
                // Load MySQL JDBC driver (use 'com.mysql.cj.jdbc.Driver' for modern MySQL versions)
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish the connection to the database
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Connection successful!");

            } catch (ClassNotFoundException e) {
                // JDBC driver not found
                System.err.println("JDBC Driver not found: " + e.getMessage());
                throw new SQLException("Database driver error: " + e.getMessage());
            } catch (SQLException e) {
                // SQL exception handling
                System.err.println("Database connection error: " + e.getMessage());
                throw new SQLException("Database connection error: " + e.getMessage());
            }
        }
        return connection;
    }

    // Close the database connection and other resources
    public static void closeConnection(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            // Close ResultSet
            if (rs != null) {
                rs.close();
                System.out.println("ResultSet closed.");
            }
            // Close PreparedStatement
            if (stmt != null) {
                stmt.close();
                System.out.println("PreparedStatement closed.");
            }
            // Close Connection
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("Connection closed.");
            }
        } catch (SQLException e) {
            System.err.println("Error closing resources: " + e.getMessage());
        }
    }

    // Method to test the connection (optional, for debugging purposes)
    // This can be removed if not needed
    public static void testConnection() {
        try {
            Connection conn = getConnection();
            if (conn != null) {
                System.out.println("Connection is valid!");
            }
        } catch (SQLException e) {
            System.err.println("Failed to test connection: " + e.getMessage());
        }
    }

    // Optional: Close the connection with just the statement
    public static void closeConnection(PreparedStatement stmt) {
        try {
            if (stmt != null) {
                stmt.close();
                System.out.println("PreparedStatement closed.");
            }
        } catch (SQLException e) {
            System.err.println("Error closing PreparedStatement: " + e.getMessage());
        }
    }

    // Optional: Close the connection with just the result set
    public static void closeConnection(ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
                System.out.println("ResultSet closed.");
            }
        } catch (SQLException e) {
            System.err.println("Error closing ResultSet: " + e.getMessage());
        }
    }

    // New method to close a connection without any extra parameters
    public static void closeConnection(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("Connection closed.");
            }
        } catch (SQLException e) {
            System.err.println("Error closing Connection: " + e.getMessage());
        }
    }

    static void close(Connection conn, PreparedStatement stmt, Object object) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
