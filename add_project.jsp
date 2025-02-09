<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Project - Wildlife Conservation System</title>
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
            width: 500px; /* Set form width to 500px */
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

        /* Adjusted input and textarea styles */
        input, textarea {
            width: 90%; /* Reduce the width of the textboxes slightly */
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            text-align: center; /* Center the text inside input fields */
            margin-left: 5%; /* Adjust the left margin to move the input slightly to the right */
        }

        /* Date input styling */
        input[type="date"] {
            text-align: left; /* Align date input to the left */
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
            width: 100%; /* Make button full width */
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        button:hover {
            background-color: #45a049;
        }

        /* Back to Project List button same size as Add Project */
        a.back-button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            font-size: 18px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-top: 20px;
            text-align: center;
            transition: background-color 0.3s;
            width: auto; /* Match the width of the Add Project button */
            margin-left: auto;
            margin-right: auto;
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

    <!-- Title Section -->
    <h2>Add Project</h2>

    <!-- Add Project Form -->
    <form action="ProjectServlet" method="post">
        <label for="project_name">Project Name:</label>
        <input type="text" id="project_name" name="project_name" required><br><br>

        <label for="start_date">Start Date:</label>
        <input type="date" id="start_date" name="start_date" required><br><br>

        <label for="end_date">End Date:</label>
        <input type="date" id="end_date" name="end_date" required><br><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" required></textarea><br><br>

        <button type="submit">Add Project</button>
    </form>

    <!-- Back to Project List Button -->
    <a href="project_list.jsp" class="back-button">Back to Project List</a>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2024 Wildlife Conservation System | All Rights Reserved</p>
    </footer>

</body>
</html>
