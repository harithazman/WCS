<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Donation - Wildlife Conservation System</title>
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
    </style>
</head>
<body>

    <h2>Delete Donation</h2>

    <div class="message">
        <p>Are you sure you want to delete this donation?</p>

        <% 
            String donationId = request.getParameter("donation_id");
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String query = "SELECT * FROM donations WHERE donation_id = ?";
            try {
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife_conservation", "root", "");
                stmt = conn.prepareStatement(query);
                stmt.setInt(1, Integer.parseInt(donationId));
                rs = stmt.executeQuery();

                if (rs.next()) {
        %>
                    <p><strong>Donation ID:</strong> <%= rs.getInt("donation_id") %></p>
                    <p><strong>Donor Name:</strong> <%= rs.getString("donor_name") %></p>
                    <p><strong>Donation Amount:</strong> <%= rs.getDouble("amount") %></p>
                    <p><strong>Donation Date:</strong> <%= rs.getString("donation_date") %></p>
                    <p><strong>Payment Method:</strong> <%= rs.getString("payment_method") %></p>

                    <form action="DeleteDonation" method="post">
                        <input type="hidden" name="donation_id" value="<%= rs.getInt("donation_id") %>">
                        <button type="submit" class="cta-button">Delete Donation</button>
                    </form>
                    <br>
                    <a href="donation_list.jsp" class="cancel-button">Cancel</a>
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
    </div>

</body>
</html>
