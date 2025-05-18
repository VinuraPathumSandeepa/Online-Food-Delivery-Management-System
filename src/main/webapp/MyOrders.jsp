<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modal.*, utils.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
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

        /* Table Styling */
        table {
            width: 100%;
            max-width: 1200px;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: white;
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

        /* Status Styling */
        td:nth-child(5) {  /* Status column */
            font-weight: bold;
        }

        td:nth-child(5)[data-status="pending"] {
            color: #f57c00;
        }

        td:nth-child(5)[data-status="completed"] {
            color: #388e3c;
        }

        td:nth-child(5)[data-status="cancelled"] {
            color: #d32f2f;
        }

        /* Action Buttons */
        .action-links a {
            display: inline-block;
            padding: 6px 12px;
            margin: 2px;
            background-color: #2196f3;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .action-links a:hover {
            background-color: #1976d2;
        }

        .action-links a.cancel {
            background-color: #f44336;
        }

        .action-links a.cancel:hover {
            background-color: #d32f2f;
        }

        /* Payment Status */
        td:nth-child(7) {  /* Payment Status column */
            font-weight: bold;
        }

        td:nth-child(7)[data-payment="paid"] {
            color: #388e3c;
        }

        td:nth-child(7)[data-payment="pending"] {
            color: #f57c00;
        }

        /* Items List */
        .items-list {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .items-list span {
            display: inline-block;
            margin-right: 5px;
            padding: 2px 5px;
            background-color: #e3f2fd;
            border-radius: 3px;
            font-size: 14px;
        }

        /* Price Column */
        td:nth-child(4) {  /* Total Amount column */
            font-weight: bold;
            color: #1b5e20;
        }
    </style>
</head>
<body>
    <h1>My Orders</h1>
    <div class="nav-links">
        <a href="LogoutServlet">Logout</a>
        <a href="Profile.jsp">Profile</a>
        <a href="MenuList.jsp">Browse Menu</a>
    </div>
    <table>
        <tr>
            <th>Order ID</th>
            <th>Restaurant</th>
            <th>Items</th>
            <th>Total Amount</th>
            <th>Status</th>
            <th>Delivery Address</th>
            <th>Payment Status</th>
            <th>Action</th>
        </tr>
        <% User user = (User) session.getAttribute("USER"); %>
        <% for (Order order : OrderHandle.getOrdersByUserId(user.getUserId())) { %>
        <tr>
            <td><%= order.getOrderId() %></td>
            <td><%= order.getRestaurant().getName() %></td>
            <td>
                <div class="items-list">
                <% for (MenuItem item : order.getItems()) { %>
                    <span><%= item.getName() %></span>
                <% } %>
                </div>
            </td>
            <td><%= order.getTotalAmount() %></td>
            <td data-status="<%= order.getStatus().toLowerCase() %>"><%= order.getStatus() %></td>
            <td><%= order.getDeliveryAddress() %></td>
            <td data-payment="<%= order.getPayment() != null ? order.getPayment().getStatus().toLowerCase() : "na" %>">
                <%= order.getPayment() != null ? order.getPayment().getStatus() : "N/A" %>
            </td>
            <td class="action-links">
                <% if (order.getStatus().equals("pending")) { %>
                <a href="OrderServlet?action=cancel&orderId=<%= order.getOrderId() %>" class="cancel">Cancel</a>
                <a href="PaymentServlet?action=pay&orderId=<%= order.getOrderId() %>">Pay</a>
                <% } %>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>