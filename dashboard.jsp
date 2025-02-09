<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Wildlife Conservation System</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            padding-bottom: 100px; /* Added space at the bottom for footer */
        }

        /* Header Styles */
        header {
            background-color: #4CAF50;
            color: white;
            padding: 20px 0;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        header img {
            max-width: 150px;
            margin-bottom: 20px;
        }

        /* Navigation Bar Styles */
        nav {
            background-color: #333;
            overflow: hidden;
            position: relative;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            display: flex;
            justify-content: center;
            padding: 14px 0; /* Added padding to the navbar */
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

        /* Logout Button Style */
        .logout-button {
            background-color: #d9534f; /* Red color for logout button */
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 18px;
            transition: background-color 0.3s;
        }
        .logout-button:hover {
            background-color: #c9302c;
        }

        /* Main Content */
        .container {
            padding: 30px;
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-bottom: 50px; /* Added bottom margin to provide space for the footer */
        }

        .container h2 {
            margin-bottom: 20px;
        }
        .container p {
            font-size: 16px;
            line-height: 1.6;
        }

        /* CTA Button */
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

        /* Section Styling */
        .content-section {
            display: flex;
            margin-bottom: 40px;
            justify-content: space-between;
            align-items: center;
        }
        .content-section img {
            width: 45%;
            border-radius: 8px;
        }
        .content-section div {
            width: 50%;
        }
        .content-section h3 {
            font-size: 24px;
            color: #4CAF50;
        }
        .content-section p {
            font-size: 16px;
        }

        /* Footer Styles */
        footer {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            padding: 30px 0;
            position: relative;
            bottom: 0;
            width: 100%;
            z-index: 10;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            header img {
                width: 100px;
            }
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
            .content-section {
                flex-direction: column;
                text-align: center;
            }
            .content-section img {
                width: 70%;
                margin: 0 auto 20px auto;
            }
            .content-section div {
                width: 100%;
            }
        }
    </style>
</head>
<body>

    <!-- Header Section with Logo -->
    <header>
        <img src="image/logo.png" alt="Wildlife Conservation System Logo">
    </header>

    <!-- Navigation Bar -->
    <nav>
        <a href="species_list.jsp">Species List</a>
        <% if ("admin".equals(session.getAttribute("role"))) { %>
            <a href="project_list.jsp">Project List</a> <!-- For Admin: Project List -->
            <a href="donation_list.jsp">Donation List</a> <!-- For Admin: Donation List -->
        <% } else { %>
            <a href="add_donation.jsp">Donate</a> <!-- For User: Donate -->
        <% } %>
        <a href="Logout" class="logout-button">Logout</a>
    </nav>

    <!-- Main Content Section -->
    <div class="container">
        <h2>Welcome to the Wildlife Conservation System</h2>

        <%-- Display the username of the logged-in user --%>
        <%
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");

            if (username == null) {
                // If no user is found in session, redirect to login page
                response.sendRedirect("login.jsp");
                return;
            }

            // Display success message if exists in session
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
                out.println("<h3>" + successMessage + "</h3>");
                session.removeAttribute("successMessage"); // Clear after displaying
            }

            // Display the username of the logged-in user
            out.println("<p>Welcome, " + username + "!</p>");
        %>

        <%-- Show content based on role --%>
        <% if ("admin".equals(role)) { %>
            <h3>Admin Dashboard</h3>
            <ul>
                <li><strong>Manage Projects:</strong> Admins can create, manage, and monitor the progress of wildlife conservation projects globally.</li>
                <li><strong>Species Information Management:</strong> Admins can update species data, including endangered species, their habitats, and conservation status, ensuring accurate and up-to-date information.</li>
                <li><strong>Donation List Management:</strong> Admins can view and manage the list of donations made for wildlife conservation efforts.</li>
            </ul>
        <% } else { %>
            <h3>User Dashboard</h3>
            <p>You have limited access as a user. You can view species information and donate to conservation efforts.</p>
            <ul>
                <li><strong>Track and Learn About Endangered Species:</strong> Users can explore species data and learn about endangered animals and the threats they face.</li>
                <li><strong>Support Conservation Projects:</strong> Users can donate directly to ongoing wildlife conservation projects, making an immediate impact.</li>
            </ul>
        <% } %>

        <!-- About Us Section -->
        <div class="content-section">
            <img src="image/about-us.jpg" alt="About Us">
            <div>
                <h3>About Us</h3>
                <p>We are committed to conserving wildlife around the globe. Our system is designed to help raise awareness and support the protection of endangered species through community engagement, donations, and the effective management of conservation projects. Together, we can make a difference.</p>
            </div>
        </div>

        <!-- Why Choose Us Section -->
        <div class="content-section">
            <img src="image/why-choose-us.jpg" alt="Why Choose Us">
            <div>
                <h3>Why Choose Us?</h3>
                <ul>
                    <li><strong>Global Impact:</strong> We focus on wildlife protection globally, ensuring that we’re contributing to efforts that span continents.</li>
                    <li><strong>Transparency:</strong> Every donation is tracked, and reports are generated to show the impact of every contribution.</li>
                    <li><strong>Education:</strong> We offer educational resources to help users and communities better understand the importance of conservation efforts.</li>
                    <li><strong>Hands-On Involvement:</strong> Both users and admins can actively participate in projects, contributing directly to wildlife conservation.</li>
                </ul>
            </div>
        </div>

        <!-- What We Do Section -->
        <div class="content-section">
            <img src="image/what-we-do.jpg" alt="What We Do">
            <div>
                <h3>What We Do</h3>
                <p>Our platform connects you with wildlife conservation projects, helping you track the progress of species conservation, provide donations, and become an active part of the efforts to save endangered species. Whether you're an admin managing projects or a user supporting them, your contributions matter.</p>
            </div>
        </div>

        <!-- Events & Programs Section -->
        <div class="content-section">
            <img src="image/events-programs.jpg" alt="Events and Programs">
            <div>
                <h3>Events & Programs</h3>
                <p>Our system organizes and promotes various events aimed at raising awareness about wildlife conservation. From fundraising campaigns to educational programs, we provide opportunities for everyone to get involved. Stay tuned for upcoming events where you can directly contribute and make a difference!</p>
            </div>
        </div>

    </div>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2024 Wildlife Conservation System | All Rights Reserved</p>
    </footer>

</body>
</html>
