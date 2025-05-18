<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modal.*, utils.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Deliveries</title>
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

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            margin-top: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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

        select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-right: 10px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .status-pending {
            background-color: #fff3e0;
            color: #f57c00;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .status-dispatched {
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

        .delivery-address {
            max-width: 200px;
            word-wrap: break-word;
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

            input[type="submit"] {
                width: 100%;
                margin-top: 10px;
            }

            select {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
<h1>My Deliveries</h1>
<div class="nav-links">
    <a href="../LogoutServlet">Logout</a>
    <a href="Dashboard.jsp">Back to Dashboard</a>
</div>
<div class="content-section">
    <h2>Deliveries</h2>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Delivery ID</th>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Restaurant</th>
                    <th>Delivery Address</th>
                    <th>Status</th>
                    <th>Estimated Time</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% User user = (User) session.getAttribute("USER"); %>
                <% for (Delivery delivery : DeliveryHandle.getDeliveriesByPersonnel(user.getUserId())) { %>
                <tr>
                    <td><%= delivery.getDeliveryId() %></td>
                    <td><%= delivery.getOrder().getOrderId() %></td>
                    <td><%= delivery.getOrder().getCustomer().getFirstName() %> <%= delivery.getOrder().getCustomer().getLastName() %></td>
                    <td><%= delivery.getOrder().getRestaurant().getName() %></td>
                    <td class="delivery-address"><%= delivery.getOrder().getDeliveryAddress() %></td>
                    <td><span class="status-<%= delivery.getStatus().toLowerCase() %>"><%= delivery.getStatus() %></span></td>
                    <td><%= delivery.getEstimatedDeliveryTime() %></td>
                    <td>
                        <% if (!delivery.getStatus().equals("delivered")) { %>
                        <form action="../DeliveryServlet" method="post">
                            <input type="hidden" name="action" value="updateStatus">
                            <input type="hidden" name="deliveryId" value="<%= delivery.getDeliveryId() %>">
                            <select name="status">
                                <option value="dispatched">Dispatched</option>
                                <option value="delivered">Delivered</option>
                            </select>
                            <input type="submit" value="Update Status">
                        </form>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>