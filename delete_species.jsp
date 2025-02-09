<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Species - Wildlife Conservation System</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            text-align: center;
            padding-top: 50px;
            padding-bottom: 80px; /* Space for the footer */
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
        }

        .cta-button:hover {
            background-color: #45a049;
        }

        .cancel-button {
            background-color: #d9534f;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 18px;
            margin-top: 20px;
            display: inline-block;
            transition: background-color 0.3s;
        }

        .cancel-button:hover {
            background-color: #c9302c;
        }

        footer {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 20px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

    </style>
</head>
<body>

    <h2>Are you sure you want to delete this species?</h2>

    <% 
        String speciesId = request.getParameter("species_id");
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String query = "SELECT * FROM species WHERE species_id = ?";
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife_conservation", "root", "");
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(speciesId));
            rs = stmt.executeQuery();

            if (rs.next()) {
    %>
            <p><strong>Species Name:</strong> <%= rs.getString("species_name") %></p>
            <p><strong>Scientific Name:</strong> <%= rs.getString("scientific_name") %></p>
            <p><strong>Endangered Status:</strong> <%= rs.getString("endangered_status") %></p>
            <p><strong>Habitat:</strong> <%= rs.getString("habitat") %></p>

            <form action="DeleteSpecies" method="POST">
                <input type="hidden" name="species_id" value="<%= speciesId %>">
                <button type="submit" class="cta-button">Delete Species</button>
            </form>
            <br>
            <a href="species_list.jsp" class="cancel-button">Cancel</a>
    <% 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <footer>
        <p>&copy; 2024 Wildlife Conservation System | All Rights Reserved</p>
    </footer>

</body>
</html>
