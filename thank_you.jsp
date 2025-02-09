<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You for Your Donation - Wildlife Conservation System</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            padding-bottom: 150px; /* Added space at the bottom for footer */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h2 {
            color: #4CAF50;
            text-align: center;
        }

        .container {
            padding: 30px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
        }

        .cta-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
            text-align: center;
            display: block;
            width: 50%;
            margin: 20px auto;
        }

        .cta-button:hover {
            background-color: #45a049;
        }

        footer {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>

    <script>
        // Redirect to homepage after 2 seconds
        function redirectToHomePage() {
            setTimeout(function() {
                window.location.href = "index.html"; // Redirect to homepage
            }, 2000);
        }

        // Call the function to redirect
        redirectToHomePage();
    </script>
</head>
<body>

    <div class="container">
        <h2>Thank You for Your Donation!</h2>
        <p>We appreciate your support in conserving wildlife. You will be redirected to the homepage shortly.</p>
    </div>

    <footer>
        <p>&copy; 2024 Wildlife Conservation System | All Rights Reserved</p>
    </footer>

</body>
</html>
