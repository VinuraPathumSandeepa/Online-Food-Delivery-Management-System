<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modal.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        h1, h2 {
            color: #1b5e20;
            text-align: center;
            margin-bottom: 20px;
        }

        h2 {
            color: #2e7d32;
            margin-top: 30px;
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

        /* Form Container */
        .form-container {
            max-width: 500px;
            margin: 0 auto 20px;
            background-color: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #1b5e20;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #2196f3;
            box-shadow: 0 0 5px rgba(33, 150, 243, 0.3);
        }

        /* Update Button */
        .update-btn {
            width: 100%;
            padding: 12px;
            background-color: #2196f3;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .update-btn:hover {
            background-color: #1976d2;
        }

        /* Delete Account Button */
        .delete-btn {
            width: 100%;
            padding: 12px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .delete-btn:hover {
            background-color: #d32f2f;
        }

        /* Responsive Design */
        @media (max-width: 600px) {
            .form-container {
                margin: 0 10px;
                padding: 15px;
            }

            .nav-links a {
                display: block;
                margin: 10px auto;
                max-width: 200px;
            }
        }
    </style>
</head>
<body>
    <h1>Profile</h1>
    <div class="nav-links">
        <a href="LogoutServlet">Logout</a>
        <% User user = (User) session.getAttribute("USER"); %>
        <% if (user.isCustomer()) { %>
        <a href="MenuList.jsp">Browse Menu</a>
        <a href="MyOrders.jsp">My Orders</a>
        <% } %>
    </div>

    <div class="form-container">
        <h2>Update Profile</h2>
        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
            
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" value="<%= user.getFirstName() %>" required>
            </div>

            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" value="<%= user.getLastName() %>" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phoneNumber" value="<%= user.getPhoneNumber() %>" required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" value="<%= user.getPassword() %>" required>
            </div>

            <input type="submit" value="Update Profile" class="update-btn">
        </form>
    </div>

    <div class="form-container">
        <form action="UserServlet" method="post">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="userId" value="<%= user.getUserId() %>">
            <input type="submit" value="Delete Account" class="delete-btn">
        </form>
    </div>
</body>
</html>