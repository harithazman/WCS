<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add/Edit Species - Wildlife Conservation System</title>
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

        /* Form Styling */
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

        a {
            display: inline-block;
            background-color: #f4f4f9;
            color: #4CAF50;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            margin-top: 20px;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #45a049;
            color: white;
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

        .message {
            font-size: 16px;
            color: #4CAF50;
            text-align: center;
            margin-top: 20px;
        }

    </style>
</head>
<body>

    <!-- Title Section -->
    <h2>Add/Edit Species</h2>

    <!-- Display message -->
    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
    <div class="message">
        <p><%= message %></p>
    </div>
    <% } %>

    <!-- Add/Edit Species Form -->
    <form action="SpeciesServlet" method="post">
        <input type="hidden" name="species_id" value="${species.species_id}">

        <label for="species_name">Species Name:</label>
        <input type="text" id="species_name" name="species_name" value="${species.species_name}" required><br><br>

        <label for="scientific_name">Scientific Name:</label>
        <input type="text" id="scientific_name" name="scientific_name" value="${species.scientific_name}" required><br><br>

        <label for="endangered_status">Endangered Status:</label>
        <input type="text" id="endangered_status" name="endangered_status" value="${species.endangered_status}" required><br><br>

        <label for="habitat">Habitat:</label>
        <input type="text" id="habitat" name="habitat" value="${species.habitat}" required><br><br>

        <button type="submit">Save</button>
    </form>

    <!-- Back to Species List Button -->
    <a href="species_list.jsp">Back to Species List</a>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2024 Wildlife Conservation System | All Rights Reserved</p>
    </footer>

</body>
</html>
