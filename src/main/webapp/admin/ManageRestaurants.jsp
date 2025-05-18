<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modal.*, utils.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Restaurants</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #e8f5e9;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        h1, h2 {
            color: #1976d2;
            margin-bottom: 20px;
        }

        .nav-links {
            margin-bottom: 30px;
        }

        .nav-links a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #2196f3;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 10px;
            transition: background-color 0.3s;
        }

        .nav-links a:hover {
            background-color: #1976d2;
        }

        .content-section {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        form {
            max-width: 600px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }

        input[type="text"], select {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #2196f3;
            color: white;
            white-space: nowrap;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .restaurant-actions {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            margin-top: 10px;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .delete-btn {
            display: inline-block;
            background-color: #ffebee;
            color: #f44336;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .delete-btn:hover {
            background-color: #ffcdd2;
        }

        .approve-btn {
            display: inline-block;
            background-color: #e8f5e9;
            color: #4caf50;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .approve-btn:hover {
            background-color: #c8e6c9;
        }

        .status-active {
            background-color: #e8f5e9;
            color: #388e3c;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .status-pending {
            background-color: #fff3e0;
            color: #f57c00;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .status-inactive {
            background-color: #ffebee;
            color: #d32f2f;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        @media screen and (max-width: 768px) {
            .content-section {
                margin: 10px;
                padding: 15px;
            }

            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            .nav-links a {
                display: block;
                margin-bottom: 10px;
            }

            td {
                min-width: 120px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .restaurant-actions form {
                margin: 0;
            }
        }
    </style>
</head>
<body>
<h1>Manage Restaurants</h1>
<div class="nav-links">
    <a href="../LogoutServlet">Logout</a>
    <a href="Dashboard.jsp">Back to Dashboard</a>
</div>

<div class="content-section">
    <h2>Add Restaurant</h2>
    <form action="../RestaurantServlet" method="post">
        <input type="hidden" name="action" value="add">
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="location">Location:</label>
            <input type="text" id="location" name="location" required>
        </div>
        <div class="form-group">
            <label for="cuisineType">Cuisine Type:</label>
            <input type="text" id="cuisineType" name="cuisineType" required>
        </div>
        <div class="form-group">
            <label for="operatingHours">Operating Hours:</label>
            <input type="text" id="operatingHours" name="operatingHours" required>
        </div>
        <div class="form-group">
            <label for="contactInfo">Contact Info:</label>
            <input type="text" id="contactInfo" name="contactInfo" required>
        </div>
        <div class="form-group">
            <input type="submit" value="Add Restaurant">
        </div>
    </form>
</div>

<div class="content-section">
    <h2>Restaurants List</h2>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Location</th>
                    <th>Cuisine</th>
                    <th>Hours</th>
                    <th>Contact</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Restaurant restaurant : RestaurantHandle.getRestaurants()) { %>
                <tr>
                    <td><%= restaurant.getRestaurantId() %></td>
                    <td><%= restaurant.getName() %></td>
                    <td><%= restaurant.getLocation() %></td>
                    <td><%= restaurant.getCuisineType() %></td>
                    <td><%= restaurant.getOperatingHours() %></td>
                    <td><%= restaurant.getContactInfo() %></td>
                    <td><span class="status-<%= restaurant.getStatus().toLowerCase() %>"><%= restaurant.getStatus() %></span></td>
                    <td>
                        <div class="restaurant-actions">
                            <form action="../RestaurantServlet" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="restaurantId" value="<%= restaurant.getRestaurantId() %>">
                                <div class="form-group">
                                    <label for="name-<%= restaurant.getRestaurantId() %>">Name:</label>
                                    <input type="text" id="name-<%= restaurant.getRestaurantId() %>" name="name" value="<%= restaurant.getName() %>">
                                </div>
                                <div class="form-group">
                                    <label for="location-<%= restaurant.getRestaurantId() %>">Location:</label>
                                    <input type="text" id="location-<%= restaurant.getRestaurantId() %>" name="location" value="<%= restaurant.getLocation() %>">
                                </div>
                                <div class="form-group">
                                    <label for="cuisine-<%= restaurant.getRestaurantId() %>">Cuisine:</label>
                                    <input type="text" id="cuisine-<%= restaurant.getRestaurantId() %>" name="cuisineType" value="<%= restaurant.getCuisineType() %>">
                                </div>
                                <div class="form-group">
                                    <label for="hours-<%= restaurant.getRestaurantId() %>">Hours:</label>
                                    <input type="text" id="hours-<%= restaurant.getRestaurantId() %>" name="operatingHours" value="<%= restaurant.getOperatingHours() %>">
                                </div>
                                <div class="form-group">
                                    <label for="contact-<%= restaurant.getRestaurantId() %>">Contact:</label>
                                    <input type="text" id="contact-<%= restaurant.getRestaurantId() %>" name="contactInfo" value="<%= restaurant.getContactInfo() %>">
                                </div>
                                <div class="form-group">
                                    <label for="status-<%= restaurant.getRestaurantId() %>">Status:</label>
                                    <select id="status-<%= restaurant.getRestaurantId() %>" name="status">
                                        <option value="active" <%= restaurant.getStatus().equals("active") ? "selected" : "" %>>Active</option>
                                        <option value="pending" <%= restaurant.getStatus().equals("pending") ? "selected" : "" %>>Pending</option>
                                        <option value="inactive" <%= restaurant.getStatus().equals("inactive") ? "selected" : "" %>>Inactive</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <input type="submit" value="Update">
                                </div>
                            </form>
                            <div class="action-buttons">
                                <a href="../RestaurantServlet?action=delete&restaurantId=<%= restaurant.getRestaurantId() %>" class="delete-btn">Delete</a>
                                <% if (restaurant.getStatus().equals("pending")) { %>
                                <a href="../RestaurantServlet?action=approve&restaurantId=<%= restaurant.getRestaurantId() %>" class="approve-btn">Approve</a>
                                <% } %>
                            </div>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>