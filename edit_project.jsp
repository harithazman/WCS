<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Project - Wildlife Conservation System</title>
    <style>
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

        form {
            padding: 20px;
            margin: 20px auto;
            width: 700px;
            height: 700px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        label {
            font-size: 16px;
            margin-bottom: 5px;
            display: block;
            text-align: center;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            text-align: center;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            width: 100%;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        button:hover {
            background-color: #45a049;
        }

        /* Adjusted Back Button */
        a.back-button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            font-size: 18px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-top: 10px;
            text-align: center;
            transition: background-color 0.3s;
            width: auto; /* Adjust width to fit content */
            margin-left: auto;
            margin-right: auto; /* Center the button */
        }

        a.back-button:hover {
            background-color: white;
            color: #4CAF50;
            border: 2px solid #4CAF50;
        }

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

    <h2>Edit Project</h2>

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

    <!-- Edit Project Form -->
    <form action="EditProject" method="post">
        <input type="hidden" name="project_id" value="<%= rs.getInt("project_id") %>">

        <label for="project_name">Project Name:</label>
        <input type="text" id="project_name" name="project_name" value="<%= rs.getString("project_name") %>" required><br><br>

        <label for="start_date">Start Date:</label>
        <input type="date" id="start_date" name="start_date" value="<%= rs.getString("start_date") %>" required><br><br>

        <label for="end_date">End Date:</label>
        <input type="date" id="end_date" name="end_date" value="<%= rs.getString("end_date") %>" required><br><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" required><%= rs.getString("description") %></textarea><br><br>

        <button type="submit">Save Changes</button>
    </form>

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

    <a href="project_list.jsp" class="back-button">Back to Project List</a>

    <footer>
        <p>&copy; 2024 Wildlife Conservation System | All Rights Reserved</p>
    </footer>

</body>
</html>
