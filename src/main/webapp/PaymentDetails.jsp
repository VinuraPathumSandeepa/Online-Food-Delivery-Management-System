<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modal.*, utils.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        h1, h2, h3 {
            color: #1b5e20;
            text-align: center;
            margin-bottom: 20px;
        }

        h2 {
            margin-top: 30px;
            color: #2e7d32;
        }

        h3 {
            color: #388e3c;
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

        /* Order Summary Container */
        .order-summary {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .order-summary p {
            margin: 10px 0;
            padding: 8px;
            border-bottom: 1px solid #e0e0e0;
        }

        .order-summary p strong {
            color: #1b5e20;
            display: inline-block;
            width: 150px;
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
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

        /* Payment Form */
        .payment-form {
            max-width: 500px;
            margin: 30px auto;
            background-color: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        select {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #2196f3;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 20px;
        }

        input[type="submit"]:hover {
            background-color: #1976d2;
        }

        /* Error Message */
        .error-message {
            color: #d32f2f;
            text-align: center;
            padding: 20px;
            background-color: #ffebee;
            border-radius: 8px;
            margin: 20px auto;
            max-width: 500px;
        }

        /* Price Display */
        .price {
            font-weight: bold;
            color: #1b5e20;
        }
    </style>
</head>
<body>
    <h1>Payment Details</h1>
    <div class="nav-links">
        <a href="LogoutServlet">Logout</a>
        <a href="Profile.jsp">Profile</a>
        <a href="MyOrders.jsp">My Orders</a>
    </div>

    <%
    String orderId = request.getParameter("orderId");
    String paymentId = request.getParameter("paymentId");
    Order order = OrderHandle.findOrderById(orderId);
    Payment payment = PaymentHandle.findPaymentById(paymentId);

    if (order == null || payment == null) {
    %>
    <div class="error-message">
        <p>Error: Order or Payment not found.</p>
    </div>
    <%
    } else {
    %>
    <div class="order-summary">
        <h2>Order Summary</h2>
        <p><strong>Order ID:</strong> <%= order.getOrderId() %></p>
        <p><strong>Restaurant:</strong> <%= order.getRestaurant().getName() %></p>
        <p><strong>Delivery Address:</strong> <%= order.getDeliveryAddress() %></p>
        <p><strong>Total Amount:</strong> <span class="price"><%= order.getTotalAmount() %></span></p>
        
        <h3>Items:</h3>
        <table>
            <tr>
                <th>Name</th>
                <th>Price</th>
            </tr>
            <% for (MenuItem item : order.getItems()) { %>
            <tr>
                <td><%= item.getName() %></td>
                <td class="price"><%= item.getPrice() %></td>
            </tr>
            <% } %>
        </table>
    </div>

    <div class="payment-form">
        <h2>Confirm Payment</h2>
        <form action="PaymentServlet" method="post">
            <input type="hidden" name="action" value="processPayment">
            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
            <p>
                <label for="paymentMethod">Payment Method:</label>
                <select name="paymentMethod" id="paymentMethod" required>
                    <option value="cod" <%= payment.getPaymentMethod().equals("cod") ? "selected" : "" %>>Cash on Delivery</option>
                    <option value="card" <%= payment.getPaymentMethod().equals("card") ? "selected" : "" %>>Card</option>
                    <option value="upi" <%= payment.getPaymentMethod().equals("upi") ? "selected" : "" %>>UPI</option>
                </select>
            </p>
            <input type="submit" value="Process Payment">
        </form>
    </div>
    <%
    }
    %>
</body>
</html>