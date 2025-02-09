<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Species - Wildlife Conservation System</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        h2 {
            color: #4CAF50;
            text-align: center;
            margin-top: 20px;
        }

        /* Table Styling */
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        /* Add Species Button */
        .add-button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            font-size: 18px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin: 10px auto;
            text-align: center;
            transition: background-color 0.3s;
        }

        .add-button:hover {
            background-color: #45a049;
        }

        /* Back to Dashboard Button */
        .back-button {
            background-color: #4CAF50;
            color: white;
            padding: 14px 40px;
            font-size: 18px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin: 20px auto;
            text-align: center;
            transition: background-color 0.3s;
            border: 2px solid #4CAF50; /* Border around button */
            width: 200px; /* Fixed width for button */
        }

        .back-button:hover {
            background-color: white;
            color: #4CAF50;
            border: 2px solid #4CAF50;
        }

        /* Footer Styles */
        footer {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 20px 0;
            position: relative;
            bottom: 0;
            width: 100%;
            margin-top: auto;
        }

    </style>
</head>
<body>

    <h2>Species List</h2>

    <% 
    String message = (String) request.getAttribute("message");
    if (message != null) {
    %>
    <div class="message" style="color: green; text-align: center;">
        <p><%= message %></p>
    </div>
    <% 
    }
    %>

    <% 
        // Database connection and query
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String query = "SELECT species_name, scientific_name, endangered_status, habitat, species_id FROM species";

        // Establish the connection using JDBC
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife_conservation?zeroDateTimeBehavior=convertToNull", "root", "");
        stmt = conn.prepareStatement(query);
        rs = stmt.executeQuery();
    %>

    <% if ("admin".equals(session.getAttribute("role"))) { %>
        <a href="add_species.jsp" class="add-button">Add New Species</a><br><br>
    <% } %>

    <!-- Species Table -->
    <table>
        <tr>
            <th>Species Name</th>
            <th>Scientific Name</th>
            <th>Endangered Status</th>
            <th>Habitat</th>
            <th>Actions</th>
        </tr>

        <% 
            // Loop through the result set and display data
            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString("species_name") %></td>
                <td><%= rs.getString("scientific_name") %></td>
                <td><%= rs.getString("endangered_status") %></td>
                <td><%= rs.getString("habitat") %></td>
                <td>
                    <% if ("admin".equals(session.getAttribute("role"))) { %>
                        <a href="edit_species.jsp?species_id=<%= rs.getInt("species_id") %>">Edit</a> |
                        
                        <!-- Delete button redirects to delete_species.jsp for confirmation -->
                        <a href="delete_species.jsp?species_id=<%= rs.getInt("species_id") %>" class="cta-button">Delete</a>
                    <% } else { %>
                        <span>Not Authorized</span>
                    <% } %>
                </td>
            </tr>
        <% } %>
    </table>

    <a href="dashboard.jsp" class="back-button">Back to Dashboard</a>

    <footer>
        <p>&copy; 2024 Wildlife Conservation System | All Rights Reserved</p>
    </footer>

    <% 
        // Clean up resources
        if (rs != null) { rs.close(); }
        if (stmt != null) { stmt.close(); }
        if (conn != null) { conn.close(); }
    %>

</body>
</html>
