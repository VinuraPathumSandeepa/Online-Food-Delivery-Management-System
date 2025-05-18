<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modal.*, utils.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Menu</title>
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

        form {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            max-width: 600px;
            margin-bottom: 30px;
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

        select, input[type="text"], input[type="number"], textarea {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
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
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-top: 30px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #2196f3;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .menu-actions {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
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

        .category-veg {
            color: #388e3c;
            font-weight: bold;
        }

        .category-non-veg {
            color: #d32f2f;
            font-weight: bold;
        }

        .availability {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .available-yes {
            background-color: #e8f5e9;
            color: #388e3c;
        }

        .available-no {
            background-color: #ffebee;
            color: #d32f2f;
        }

        @media screen and (max-width: 768px) {
            .table-container {
                margin: 10px;
                padding: 10px;
            }

            form {
                margin: 10px;
            }

            .nav-links a {
                display: block;
                margin-bottom: 10px;
            }

            td {
                min-width: 120px;
            }

            .menu-actions form {
                margin: 0;
            }
        }
    </style>
</head>
<body>
<h1>Manage Menu</h1>
<div class="nav-links">
    <a href="../LogoutServlet">Logout</a>
    <a href="Dashboard.jsp">Back to Dashboard</a>
</div>

<h2>Add Menu Item</h2>
<form action="../MenuItemServlet" method="post">
    <input type="hidden" name="action" value="add">
    <div class="form-group">
        <label for="restaurantId">Restaurant:</label>
        <select name="restaurantId" id="restaurantId" required>
            <% for (Restaurant restaurant : RestaurantHandle.getRestaurants()) { %>
            <% if (restaurant.getStatus().equals("active")) { %>
            <option value="<%= restaurant.getRestaurantId() %>"><%= restaurant.getName() %></option>
            <% } %>
            <% } %>
        </select>
    </div>
    <div class="form-group">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
    </div>
    <div class="form-group">
        <label for="category">Category:</label>
        <select name="category" id="category" required>
            <option value="veg">Vegetarian</option>
            <option value="non-veg">Non-Vegetarian</option>
        </select>
    </div>
    <div class="form-group">
        <label for="cuisineType">Cuisine Type:</label>
        <input type="text" id="cuisineType" name="cuisineType" required>
    </div>
    <div class="form-group">
        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01" required>
    </div>
    <div class="form-group">
        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea>
    </div>
    <div class="form-group">
        <input type="submit" value="Add Item">
    </div>
</form>

<div class="table-container">
    <h2>Menu Items</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Cuisine</th>
                <th>Price</th>
                <th>Description</th>
                <th>Available</th>
                <th>Restaurant</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% User user = (User) session.getAttribute("USER"); %>
            <% for (MenuItem item : MenuItemHandle.getMenuItems()) { %>
            <% Restaurant restaurant = RestaurantHandle.findRestaurantById(item.getRestaurantId()); %>
            <% if (restaurant != null && restaurant.getStatus().equals("active")) { %>
            <tr>
                <td><%= item.getItemId() %></td>
                <td><%= item.getName() %></td>
                <td><span class="category-<%= item.getCategory() %>"><%= item.getCategory() %></span></td>
                <td><%= item.getCuisineType() %></td>
                <td><%= item.getPrice() %></td>
                <td><%= item.getDescription() %></td>
                <td><span class="availability available-<%= item.isAvailable() ? "yes" : "no" %>">
                    <%= item.isAvailable() ? "Yes" : "No" %>
                </span></td>
                <td><%= restaurant.getName() %></td>
                <td>
                    <div class="menu-actions">
                        <form action="../MenuItemServlet" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                            <div class="form-group">
                                <label for="name-<%= item.getItemId() %>">Name:</label>
                                <input type="text" id="name-<%= item.getItemId() %>" name="name" value="<%= item.getName() %>">
                            </div>
                            <div class="form-group">
                                <label for="category-<%= item.getItemId() %>">Category:</label>
                                <select name="category" id="category-<%= item.getItemId() %>">
                                    <option value="veg" <%= item.getCategory().equals("veg") ? "selected" : "" %>>Vegetarian</option>
                                    <option value="non-veg" <%= item.getCategory().equals("non-veg") ? "selected" : "" %>>Non-Vegetarian</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="cuisine-<%= item.getItemId() %>">Cuisine:</label>
                                <input type="text" id="cuisine-<%= item.getItemId() %>" name="cuisineType" value="<%= item.getCuisineType() %>">
                            </div>
                            <div class="form-group">
                                <label for="price-<%= item.getItemId() %>">Price:</label>
                                <input type="number" id="price-<%= item.getItemId() %>" name="price" step="0.01" value="<%= item.getPrice() %>">
                            </div>
                            <div class="form-group">
                                <label for="description-<%= item.getItemId() %>">Description:</label>
                                <textarea id="description-<%= item.getItemId() %>" name="description"><%= item.getDescription() %></textarea>
                            </div>
                            <div class="form-group">
                                <label>
                                    <input type="checkbox" name="isAvailable" <%= item.isAvailable() ? "checked" : "" %>>
                                    Available
                                </label>
                            </div>
                            <div class="form-group">
                                <input type="submit" value="Update">
                            </div>
                        </form>
                        <a href="../MenuItemServlet?action=delete&itemId=<%= item.getItemId() %>" class="delete-btn">Delete</a>
                    </div>
                </td>
            </tr>
            <% } %>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>