<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Donation - Wildlife Conservation System</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            padding-bottom: 150px; /* Added space at the bottom for footer */
        }

        h2 {
            color: #4CAF50;
            text-align: center;
            margin-top: 20px;
        }

        /* Container and Form Styles */
        .container {
            padding: 30px;
            max-width: 500px;
            margin: 20px auto;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-bottom: 50px; /* Added bottom margin to provide space for the footer */
        }

        label {
            font-size: 16px;
            margin-bottom: 8px;
            display: block;
        }

        input, select, textarea {
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
            width: 100%;  /* Ensure full width for buttons */
        }

        button:hover {
            background-color: #45a049;
        }

        /* Smaller Back to Donation List button */
        .cta-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;  /* Reduced padding for smaller button */
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
            text-align: center;
            display: block;
            width: 50%;  /* Reduced width */
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto;
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
            z-index: 10;
        }

        /* Center the QR code */
        #qr-code-frame {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }

        #qr-code-frame img {
            width: 500px; /* Adjust the width of the QR code */
            height: auto; /* Keep aspect ratio intact */
            max-width: 100%; /* Ensure it doesn't overflow its container */
        }

    </style>

    <script>
        // Function to toggle visibility of payment-related fields
        function togglePaymentFields() {
            var paymentMethod = document.getElementById("payment_method").value;
            var cardNumberField = document.getElementById("credit_card_number");
            var qrCodeField = document.getElementById("qr-code-frame");

            // Hide both fields by default
            cardNumberField.style.display = "none";
            qrCodeField.style.display = "none";

            // Show the respective field based on selected payment method
            if (paymentMethod === "credit_card" || paymentMethod === "debit_card") {
                cardNumberField.style.display = "block";  // Show Credit/Debit Card number input field
            } else if (paymentMethod === "duitnow" || paymentMethod === "touch_n_go" || paymentMethod === "shopeepay") {
                qrCodeField.style.display = "block";  // Show QR code for DuitNow, Touch 'n Go, ShopeePay
            }
        }
    </script>
</head>
<body>

    <h2>Add New Donation</h2>

    <div class="container">
        <% 
            // Check if the user is logged in
            String username = (String) session.getAttribute("username");
            boolean isGuest = (username == null);

            if (isGuest) { 
        %>
            <!-- If the user is a guest, show the form and the message only after donation -->
            <% if(request.getAttribute("thankYouMessage") != null) { %>
                <p>Thank you for your donation, and have a nice day!</p>
                <script>redirectToHomePage();</script>
            <% } else { %>
                <form action="Donation" method="post">
                    <input type="hidden" name="donor_name" value="Guest">
                    <label for="donation_amount">Donation Amount:</label>
                    <input type="number" id="donation_amount" name="donation_amount" required><br>

                    <label for="donation_date">Donation Date:</label>
                    <input type="date" id="donation_date" name="donation_date" required><br>

                    <label for="payment_method">Payment Method:</label>
                    <select id="payment_method" name="payment_method" required onchange="togglePaymentFields()">
                        <option value="">Select Payment Method</option>
                        <option value="credit_card">Credit Card</option>
                        <option value="debit_card">Debit Card</option>
                        <option value="touch_n_go">Touch 'n Go E-Wallet</option>
                        <option value="shopeepay">ShopeePay E-Wallet</option>
                        <option value="duitnow">DuitNow Pay (QR Code)</option>
                    </select><br>

                    <div id="credit_card_number" style="display:none;">
                        <label for="credit_card_number">Credit/Debit Card Number:</label>
                        <input type="text" id="credit_card_number" name="credit_card_number" placeholder="Enter card number" maxlength="16"><br>
                    </div>

                    <div id="qr-code-frame" style="display:none;">
                        <img src="image/duitnow-qr-placeholder.png" alt="DuitNow QR Code">
                        <p>Scan this QR code to donate via DuitNow, Touch 'n Go, or ShopeePay</p>
                    </div><br>

                    <button type="submit">Add Donation</button>

                    <a href="index.html" class="cta-button">Back to Homepage</a>
                </form>
            <% } %>
        <% 
            } else { // For logged-in users 
        %>
            <form action="Donation" method="post">
                <input type="hidden" name="donation_id" value="<%= request.getAttribute("donation_id") %>">

                <label for="donor_name">Donor Name:</label>
                <input type="text" id="donor_name" name="donor_name" required value="<%= username %>"><br>

                <label for="donation_amount">Donation Amount:</label>
                <input type="number" id="donation_amount" name="donation_amount" required><br>

                <label for="donation_date">Donation Date:</label>
                <input type="date" id="donation_date" name="donation_date" required><br>

                <label for="payment_method">Payment Method:</label>
                <select id="payment_method" name="payment_method" required onchange="togglePaymentFields()">
                    <option value="">Select Payment Method</option>
                    <option value="credit_card">Credit Card</option>
                    <option value="debit_card">Debit Card</option>
                    <option value="touch_n_go">Touch 'n Go E-Wallet</option>
                    <option value="shopeepay">ShopeePay E-Wallet</option>
                    <option value="duitnow">DuitNow Pay (QR Code)</option>
                </select><br>

                <div id="credit_card_number" style="display:none;">
                    <label for="credit_card_number">Credit/Debit Card Number:</label>
                    <input type="text" id="credit_card_number" name="credit_card_number" placeholder="Enter card number" maxlength="16"><br>
                </div>

                <div id="qr-code-frame" style="display:none;">
                    <img src="image/duitnow-qr-placeholder.png" alt="DuitNow QR Code">
                    <p>Scan this QR code to donate via DuitNow, Touch 'n Go, or ShopeePay</p>
                </div><br>

                <button type="submit">Add Donation</button>

                <a href="dashboard.jsp" class="cta-button">Back to Dashboard</a>
            </form>
        <% 
            }
        %>
    </div>

    <footer>
        <p>&copy; 2024 Wildlife Conservation System | All Rights Reserved</p>
    </footer>

</body>
</html>
