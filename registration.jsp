<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - Wildlife Conservation System</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            background-image: url('web/image/your-background-image.jpg'); /* Add your background image here */
            background-size: cover; /* Make the background cover the entire page */
            background-position: center;
        }

        /* Center Title */
        h2 {
            color: #4CAF50;
            text-align: center;
            padding-top: 50px;
        }

        /* Form Styles */
        form {
            padding: 20px;
            margin: 50px auto;
            max-width: 500px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            opacity: 0.9; /* To make the background image visible */
        }

        input, select {
    width: 100%;
    padding: 10px;
    margin: 8px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
}


        button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%; /* Make button full-width */
        }

        button:hover {
            background-color: #45a049;
        }

        /* Centering the Already have an account text */
        .already-have-account {
            text-align: center;
            font-size: 14px;
        }

        /* Error Message Styling */
        .error {
            color: red;
            text-align: center;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            form {
                width: 90%;
            }
        }
    </style>
</head>
<body>

    <!-- Center the Registration Title -->
    <h2>Registration</h2>

    <!-- Registration Form -->
    <form action="RegistrationServlet" method="post">
    <!-- Username Field -->
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required><br><br>

    <!-- Password Field -->
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br><br>

    <!-- Role Field -->
    <label for="role">Role:</label>
    <select id="role" name="role" required>
        <option value="admin">Admin</option>
        <option value="user">User</option>
    </select><br><br>

    <button type="submit">Register</button>
</form>


    <!-- Error Message (If any) -->
    <c:if test="${not empty errorMessage}">
        <p class="error">${errorMessage}</p>
    </c:if>

    <!-- Center the "Already have an account?" link -->
    <p class="already-have-account">Already have an account? <a href="login.jsp">Login here</a></p>

</body>
</html>
