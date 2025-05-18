<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Delivery Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9;
            margin: 0;
            padding: 0;
            color: #333;
            min-height: 100vh;
        }

        /* Header Section */
        .dashboard-header {
            background-color: #1b5e20;
            color: white;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            margin: 0;
            font-size: 28px;
        }

        /* Main Container */
        .dashboard-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* Navigation Grid */
        .nav-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        /* Card Style */
        .dashboard-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 120px;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* Navigation Links */
        .dashboard-link {
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            color: #1b5e20;
            font-size: 18px;
            font-weight: bold;
            width: 100%;
            height: 100%;
            transition: color 0.3s;
        }

        .dashboard-link:hover {
            color: #2196f3;
        }

        /* Top Navigation */
        .top-nav {
            background-color: white;
            padding: 15px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            text-align: center;
        }

        .top-nav a {
            display: inline-block;
            padding: 8px 16px;
            margin: 0 10px;
            color: white;
            background-color: #2196f3;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .top-nav a:hover {
            background-color: #1976d2;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .nav-grid {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 15px;
            }

            .dashboard-card {
                min-height: 100px;
            }

            h1 {
                font-size: 24px;
            }

            .dashboard-link {
                font-size: 16px;
            }
        }

        @media (max-width: 480px) {
            .dashboard-container {
                padding: 0 10px;
            }

            .top-nav a {
                display: block;
                margin: 10px auto;
                max-width: 200px;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-header">
        <h1>Delivery Dashboard</h1>
    </div>

    <div class="top-nav">
        <a href="../LogoutServlet">Logout</a>
        <a href="../Profile.jsp">Profile</a>
    </div>

    <div class="dashboard-container">
        <div class="nav-grid">
            <div class="dashboard-card">
                <a href="MyDeliveries.jsp" class="dashboard-link">My Deliveries</a>
            </div>
        </div>
    </div>
</body>
</html>