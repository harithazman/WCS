<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Wildlife Conservation System</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        h1, h2, h3, h4 {
            color: #4CAF50;
        }

        /* Header Styles */
        header {
            background-color: #4CAF50;
            color: white;
            padding: 20px 0;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        header h1 {
            font-size: 36px;
        }
        header p {
            font-size: 18px;
        }

        /* Logo Styling */
        .logo {
            max-width: 150px;
            margin-bottom: 20px;
        }

        /* Navigation Bar Styles */
        nav {
            background-color: #333;
            overflow: hidden;
            position: sticky;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: center;
        }
        nav a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        nav a:hover {
            background-color: #575757;
        }
        nav a.active {
            background-color: #4CAF50;
            font-weight: bold;
        }

        /* Main Content */
        .container {
            padding: 30px;
            max-width: 400px; /* Limit width for the login box */
            margin: 100px auto; /* Center the login box on the page */
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
        }

        .container h2 {
            margin-bottom: 20px;
        }
        .container label {
            display: block;
            text-align: left;
            margin-bottom: 10px;
        }

        .container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .container .cta-button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 18px;
            display: inline-block;
            transition: background-color 0.3s;
        }
        .container .cta-button:hover {
            background-color: #45a049;
        }

        /* Footer */
        footer {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            header h1 {
                font-size: 28px;
            }
            header p {
                font-size: 16px;
            }
            nav a {
                padding: 10px 15px;
            }
            .container {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

    <!-- Header Section with Logo -->
    <header>
        <img src="image/logo.png" alt="Wildlife Conservation System Logo" class="logo">
    </header>

    <!-- Main Content Section (Centered Login Box) -->
    <div class="container">
        <h2>Login</h2>

        <form action="LoginServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required><br><br>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br><br>

            <button type="submit" class="cta-button">Login</button>
        </form>

        <%-- Display error message if any --%>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
                out.println("<p style='color: red;'>" + errorMessage + "</p>");
            }
        %>
    </div>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2024 Wildlife Conservation System | All Rights Reserved</p>
    </footer>

</body>
</html>
