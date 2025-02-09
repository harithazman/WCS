<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Donation - Wildlife Conservation System</title>
    <style>
        /* Styling for the form */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }

        h2 {
            color: #4CAF50;
            text-align: center;
            margin-top: 20px;
        }

        .container {
            padding: 30px;
            max-width: 500px;
            margin: 20px auto;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        label {
            font-size: 16px;
            margin-bottom: 8px;
            display: block;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: #45a049;
        }

        .cta-button {
            background-color: #333;
            color: white;
            padding: 10px 15px;
            font-size: 16px;
            border-radius: 5px;
            text-align: center;
            display: block;
            width: 50%;
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto;
            text-decoration: none;
        }

        .cta-button:hover {
            background-color: #575757;
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
</head>
<body>

    <h2>Edit Donation</h2>

    <div class="container">
        <form action="EditDonation" method="post">
    <input type="hidden" name="donation_id" value="<%= request.getParameter("donation_id") %>"> <!-- Hidden donation_id -->

    <label for="donation_amount">Donation Amount:</label>
    <input type="number" id="donation_amount" name="donation_amount" required><br>

    <label for="donation_date">Donation Date:</label>
    <input type="date" id="donation_date" name="donation_date" required><br>

    <label for="payment_method">Payment Method:</label>
    <select id="payment_method" name="payment_method" required>
        <option value="credit_card">Credit Card</option>
        <option value="debit_card">Debit Card</option>
        <option value="touch_n_go">Touch 'n Go E-Wallet</option>
        <option value="shopeepay">ShopeePay E-Wallet</option>
        <option value="duitnow">DuitNow Pay (QR Code)</option>
    </select><br>

    <button type="submit">Update Donation</button>
</form>

    </div>

    <footer>
        <p>&copy; 2024 Wildlife Conservation System | All Rights Reserved</p>
    </footer>

</body>
</html>
