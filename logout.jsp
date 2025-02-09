<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout - Wildlife Conservation System</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            text-align: center;
            padding-top: 50px;
        }

        .message {
            margin-top: 50px;
            font-size: 20px;
            color: #4CAF50;
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
    </style>

    <script>
        // Redirect to index.html after 2 seconds delay
        function redirectToHomePage() {
            setTimeout(function() {
                window.location.href = "index.html";  // Redirect to homepage
            }, 2000);  // Delay of 2 seconds
        }
    </script>
</head>
<body>

    <div class="message">
        <p>You have been successfully logged out.</p>
        <script>redirectToHomePage();</script>
    </div>

    <!-- Optionally you can display a button to manually redirect -->
    <div>
        <a href="index.html" class="cta-button">Back to Homepage</a>
    </div>

</body>
</html>
