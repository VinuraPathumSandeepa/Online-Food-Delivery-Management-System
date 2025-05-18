<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modal.*, utils.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Deliveries</title>
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

        select, input[type="text"] {
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
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
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

        td a {
            color: #f44336;
            text-decoration: none;
        }

        td a:hover {
            text-decoration: underline;
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

        .table-container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-top: 30px;
        }

        .status-pending {
            background-color: #fff3e0;
            color: #f57c00;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .status-confirmed {
            background-color: #e3f2fd;
            color: #1976d2;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .status-delivered {
            background-color: #e8f5e9;
            color: #388e3c;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .delete-btn {
            background-color: #ffebee;
            color: #f44336;
            padding: 4px 8px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .delete-btn:hover {
            background-color: #ffcdd2;
            text-decoration: none !important;
        }

        @media screen and (max-width: 768px) {
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            form {
                margin: 10px;
            }

            .nav-links a {
                display: block;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
<h1>Manage Deliveries</h1>
<div class="nav-links">
    <a href="../LogoutServlet">Logout</a>
    <a href="Dashboard.jsp">Back to Dashboard</a>
</div>
<h2>Assign Delivery</h2>
<form action="../DeliveryServlet" method="post">
    <input type="hidden" name="action" value="assignDelivery">
    <div class="form-group">
        <label for="orderId">Order:</label>
        <select name="orderId" id="orderId" required>
            <% for (Order order : OrderHandle.getOrders()) { %>
            <% if (order.getDelivery() == null && order.getStatus().equals("confirmed")) { %>
            <option value="<%= order.getOrderId() %>"><%= order.getOrderId() %> - <%= order.getCustomer().getFirstName() %></option>
            <% } %>
            <% } %>
        </select>
    </div>
    <div class="form-group">
        <label for="deliveryPersonnelId">Delivery Personnel:</label>
        <select name="deliveryPersonnelId" id="deliveryPersonnelId" required>
            <% for (User user : UserHandle.getUsers()) { %>
            <% if (user.isDelivery()) { %>
            <option value="<%= user.getUserId() %>"><%= user.getFirstName() %> <%= user.getLastName() %></option>
            <% } %>
            <% } %>
        </select>
    </div>
    <div class="form-group">
        <label for="estimatedDeliveryTime">Estimated Delivery Time:</label>
        <input type="text" id="estimatedDeliveryTime" name="estimatedDeliveryTime" required placeholder="Enter estimated time">
    </div>
    <div class="form-group">
        <input type="submit" value="Assign Delivery">
    </div>
</form>

<div class="table-container">
    <h2>Deliveries List</h2>
    <table>
        <thead>
            <tr>
                <th>Delivery ID</th>
                <th>Order ID</th>
                <th>Personnel</th>
                <th>Status</th>
                <th>Estimated Time</th>
                <th>Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% for (Delivery delivery : DeliveryHandle.getDeliveries()) { %>
            <tr>
                <td><%= delivery.getDeliveryId() %></td>
                <td><%= delivery.getOrder().getOrderId() %></td>
                <td><%= delivery.getDeliveryPersonnel().getFirstName() %> <%= delivery.getDeliveryPersonnel().getLastName() %></td>
                <td><span class="status-<%= delivery.getStatus().toLowerCase() %>"><%= delivery.getStatus() %></span></td>
                <td><%= delivery.getEstimatedDeliveryTime() %></td>
                <td><%= delivery.getDeliveryDate() %></td>
                <td>
                    <a href="../DeliveryServlet?action=delete&deliveryId=<%= delivery.getDeliveryId() %>" class="delete-btn">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>