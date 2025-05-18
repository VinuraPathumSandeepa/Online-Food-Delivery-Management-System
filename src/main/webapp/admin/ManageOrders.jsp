<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modal.*, utils.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Orders</title>
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

        .status-cancelled {
            background-color: #ffebee;
            color: #d32f2f;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .payment-paid {
            background-color: #e8f5e9;
            color: #388e3c;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .payment-pending {
            background-color: #fff3e0;
            color: #f57c00;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .payment-failed {
            background-color: #ffebee;
            color: #d32f2f;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .items-list {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .items-list li {
            display: inline-block;
            background-color: #f5f5f5;
            padding: 4px 8px;
            margin: 2px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        @media screen and (max-width: 768px) {
            .table-container {
                margin: 10px;
                padding: 10px;
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
        }
    </style>
</head>
<body>
<h1>Manage Orders</h1>
<div class="nav-links">
    <a href="../LogoutServlet">Logout</a>
    <a href="Dashboard.jsp">Back to Dashboard</a>
</div>

<div class="table-container">
    <h2>Orders List</h2>
    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Restaurant</th>
                <th>Items</th>
                <th>Total Amount</th>
                <th>Status</th>
                <th>Delivery Address</th>
                <th>Payment Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% for (Order order : OrderHandle.getOrders()) { %>
            <tr>
                <td><%= order.getOrderId() %></td>
                <td><%= order.getCustomer().getFirstName() %> <%= order.getCustomer().getLastName() %></td>
                <td><%= order.getRestaurant().getName() %></td>
                <td>
                    <ul class="items-list">
                    <% for (MenuItem item : order.getItems()) { %>
                        <li><%= item.getName() %></li>
                    <% } %>
                    </ul>
                </td>
                <td><%= order.getTotalAmount() %></td>
                <td><span class="status-<%= order.getStatus().toLowerCase() %>"><%= order.getStatus() %></span></td>
                <td><%= order.getDeliveryAddress() %></td>
                <td>
                    <% String paymentStatus = order.getPayment() != null ? order.getPayment().getStatus() : "pending"; %>
                    <span class="payment-<%= paymentStatus.toLowerCase() %>"><%= paymentStatus %></span>
                </td>
                <td>
                    <a href="../OrderServlet?action=delete&orderId=<%= order.getOrderId() %>" class="delete-btn">Delete</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>