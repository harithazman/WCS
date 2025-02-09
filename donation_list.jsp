<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Donation List - Wildlife Conservation System</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        h2 {
            color: #4CAF50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        .cta-button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 18px;
            margin-top: 20px;
            display: inline-block;
            transition: background-color 0.3s;
            text-align: center;
        }

        .cta-button:hover {
            background-color: #45a049;
        }

        .back-button {
            background-color: #333;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 18px;
            margin-top: 20px;
            display: inline-block;
            transition: background-color 0.3s;
            text-align: center;
        }

        .back-button:hover {
            background-color: #575757;
        }

        .donation-table-container {
            margin: 20px;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            flex-grow: 1;
        }

        .table-action-links a {
            color: #4CAF50;
            text-decoration: none;
            margin-right: 10px;
        }

        .table-action-links a:hover {
            text-decoration: underline;
        }

        footer {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 30px 0;
            width: 100%;
            position: static;
        }

        .back-to-dashboard-container {
            margin-top: auto;
            padding: 20px;
        }

        /* Confirmation Message Styles */
        .confirmation-message {
            text-align: center;
            margin-top: 20px;
            font-size: 18px;
            color: #4CAF50;
        }

        .confirmation-buttons {
            text-align: center;
            margin-top: 20px;
        }

        .confirmation-buttons a {
            padding: 12px 20px;
            font-size: 18px;
            text-decoration: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            margin-right: 10px;
        }

        .confirmation-buttons a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <!-- Header Section -->
    <header style="background-color: #4CAF50; padding: 20px; text-align: center; color: white;">
        <h1>Wildlife Conservation System</h1>
    </header>

    <!-- Donation List Table Section -->
    <div class="donation-table-container">
        <h2>Donation List</h2>

        <!-- Displaying confirmation message after deletion -->
        <% 
            String message = (String) request.getAttribute("confirmationMessage");
            if (message != null) {
        %>
            <div class="confirmation-message">
                <p><%= message %></p>
            </div>
            <div class="confirmation-buttons">
                <a href="donation_list.jsp" class="cta-button">Back to Donation List</a>
                <a href="dashboard.jsp" class="cta-button">Back to Dashboard</a>
            </div>
        <% 
            } else { 
        %>

        <!-- Donation Table -->
        <table>
            <tr>
                <th>Donation Date</th>
                <th>Donor Name</th>
                <th>Donation Amount</th>
                <th>Payment Method</th>
                <th>Actions</th>
            </tr>

        <% 
            // Database connection and query for donations table
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String query = "SELECT d.donation_id, d.user_id, d.amount, d.donation_date, d.payment_method, u.username " + 
                           "FROM donations d " +
                           "JOIN users u ON d.user_id = u.user_id " +
                           "ORDER BY d.donation_date DESC"; // Sorting by donation date in descending order

            try {
                // Establish the connection using JDBC
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife_conservation?zeroDateTimeBehavior=convertToNull", "root", "");
                stmt = conn.prepareStatement(query);
                rs = stmt.executeQuery();
                
                // Loop through the result set and display data in the table
                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString("donation_date") %></td> <!-- Donation Date -->
                <td><%= rs.getString("username") %></td> <!-- Donor's Username -->
                <td><%= rs.getString("amount") %></td> <!-- Donation Amount -->
                <td><%= rs.getString("payment_method") %></td> <!-- Payment Method -->
                <td class="table-action-links">
                    <% if ("admin".equals(session.getAttribute("role"))) { %>
                        <a href="edit_donation.jsp?donation_id=<%= rs.getInt("donation_id") %>">Edit</a> |
                        <a href="delete_donation.jsp?donation_id=<%= rs.getInt("donation_id") %>">Delete</a>
                    <% } %>
                </td>
            </tr>
<% 
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Clean up resources
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>

        </table>
        <% } %> <!-- End of else block -->

    </div>

    <!-- Back to Dashboard Button (Aligned at the Bottom) -->
    <div class="back-to-dashboard-container">
        <a href="dashboard.jsp" class="back-button">Back to Dashboard</a>
    </div>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2024 Wildlife Conservation System | All Rights Reserved</p>
    </footer>

</body>
</html>
