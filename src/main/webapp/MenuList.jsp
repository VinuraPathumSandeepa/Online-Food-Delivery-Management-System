<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modal.*, utils.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        h1 {
            color: #1b5e20;
            text-align: center;
            margin-bottom: 20px;
        }

        h2 {
            color: #2e7d32;
            margin: 25px 0 15px 0;
        }

        /* Navigation Links */
        .nav-links {
            text-align: center;
            margin-bottom: 30px;
        }

        .nav-links a {
            display: inline-block;
            padding: 10px 20px;
            margin: 0 10px;
            background-color: #2196f3;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .nav-links a:hover {
            background-color: #1976d2;
        }

        /* Sort Options Styling */
        .sort-options {
            margin: 20px 0;
            padding: 15px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .sort-options select {
            padding: 8px 15px;
            margin-left: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
        }

        /* Form Styling */
        form {
            max-width: 1200px;
            margin: 0 auto;
        }

        input[type="text"],
        select {
            width: 100%;
            max-width: 300px;
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            margin: 20px 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #2196f3;
            color: white;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f8f8f8;
        }

        tr:hover {
            background-color: #f0f7ff;
        }

        /* Checkbox Styling */
        input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        /* Submit Button */
        input[type="submit"] {
            background-color: #2196f3;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-top: 20px;
        }

        input[type="submit"]:hover {
            background-color: #1976d2;
        }

        /* Delivery Info Section */
        .delivery-info {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .delivery-info p {
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <h1>Menu</h1>
    <div class="nav-links">
        <a href="LogoutServlet">Logout</a>
        <a href="Profile.jsp">Profile</a>
        <a href="MyOrders.jsp">My Orders</a>
    </div>

    <div class="sort-options">
        <form action="MenuList.jsp" method="get">
            <label for="sortOrder">Sort by Price:</label>
            <select name="sortOrder" id="sortOrder" onchange="this.form.submit()">
                <option value="none" <%= request.getParameter("sortOrder") == null ? "selected" : "" %>>Default</option>
                <option value="asc" <%= "asc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>Low to High</option>
                <option value="desc" <%= "desc".equals(request.getParameter("sortOrder")) ? "selected" : "" %>>High to Low</option>
            </select>
        </form>
    </div>

    <h2>Available Menu Items</h2>
    <form action="OrderServlet" method="post">
        <input type="hidden" name="action" value="createOrder">
        <div class="delivery-info">
            <p>Delivery Address: <input type="text" name="deliveryAddress" required></p>
            <p>Payment Method:
                <select name="paymentMethod" required>
                    <option value="cod">Cash on Delivery</option>
                    <option value="card">Card</option>
                    <option value="upi">UPI</option>
                </select>
            </p>
        </div>
        <table>
            <tr>
                <th>Select</th>
                <th>Name</th>
                <th>Category</th>
                <th>Cuisine</th>
                <th>Price</th>
                <th>Description</th>
                <th>Restaurant</th>
            </tr>
            <%
                String sortOrder = request.getParameter("sortOrder");
                LinkedList<MenuItem> items;
                
                if ("asc".equals(sortOrder)) {
                    items = MenuItemHandle.getAvailableMenuItemsSortedByPrice();
                } else if ("desc".equals(sortOrder)) {
                    items = MenuItemHandle.getAvailableMenuItemsSortedByPriceDescending();
                } else {
                    items = MenuItemHandle.getAvailableMenuItems();
                }
                
                for (MenuItem item : items) {
            %>
            <tr>
                <td><input type="checkbox" name="itemIds" value="<%= item.getItemId() %>"></td>
                <td><%= item.getName() %></td>
                <td><%= item.getCategory() %></td>
                <td><%= item.getCuisineType() %></td>
                <td><%= item.getPrice() %></td>
                <td><%= item.getDescription() %></td>
                <td><%= RestaurantHandle.findRestaurantById(item.getRestaurantId()).getName() %></td>
                <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
            </tr>
            <% } %>
        </table>
        <p style="text-align: center;"><input type="submit" value="Place Order"></p>
    </form>
</body>
</html>