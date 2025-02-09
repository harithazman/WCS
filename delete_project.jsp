<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Project - Wildlife Conservation System</title>
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

    <h2>Are you sure you want to delete this project?</h2>

    <% 
        String projectId = request.getParameter("project_id");
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String query = "SELECT * FROM projects WHERE project_id = ?";
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife_conservation", "root", "");
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(projectId));
            rs = stmt.executeQuery();

            if (rs.next()) {
    %>
            <p><strong>Project Name:</strong> <%= rs.getString("project_name") %></p>
            <p><strong>Start Date:</strong> <%= rs.getString("start_date") %></p>
            <p><strong>End Date:</strong> <%= rs.getString("end_date") %></p>
            <p><strong>Description:</strong> <%= rs.getString("description") %></p>

            <form action="DeleteProject" method="POST">
                <input type="hidden" name="project_id" value="<%= projectId %>">
                <button type="submit" class="cta-button">Delete Project</button>
            </form>
            <br>
            <a href="project_list.jsp" class="cancel-button">Cancel</a>
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
