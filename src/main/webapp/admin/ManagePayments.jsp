<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modal.*, utils.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Payments</title>
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

        .action-buttons {
            display: flex;
            gap: 10px;
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

        .refund-btn {
            display: inline-block;
            background-color: #e3f2fd;
            color: #1976d2;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .refund-btn:hover {
            background-color: #bbdefb;
        }

        .status-paid {
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

        .status-failed {
            background-color: #ffebee;
            color: #d32f2f;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .status-refunded {
            background-color: #f3e5f5;
            color: #7b1fa2;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .payment-method {
            display: inline-block;
            background-color: #f5f5f5;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9em;
            color: #555;
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

            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<h1>Manage Payments</h1>
<div class="nav-links">
    <a href="../LogoutServlet">Logout</a>
    <a href="Dashboard.jsp">Back to Dashboard</a>
</div>

<div class="table-container">
    <h2>Payments List</h2>
    <table>
        <thead>
            <tr>
                <th>Payment ID</th>
                <th>User</th>
                <th>Amount</th>
                <th>Method</th>
                <th>Status</th>
                <th>Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Payment payment : PaymentHandle.getPayments()) { %>
            <tr>
                <td><%= payment.getPaymentId() %></td>
                <td><%= payment.getUser().getFirstName() %> <%= payment.getUser().getLastName() %></td>
                <td><%= payment.getAmount() %></td>
                <td><span class="payment-method"><%= payment.getPaymentMethod() %></span></td>
                <td><span class="status-<%= payment.getStatus().toLowerCase() %>"><%= payment.getStatus() %></span></td>
                <td><%= payment.getPaymentDate() %></td>
                <td>
                    <div class="action-buttons">
                        <% if (!payment.getStatus().equals("refunded")) { %>
                        <a href="../PaymentServlet?action=refund&paymentId=<%= payment.getPaymentId() %>" class="refund-btn">Refund</a>
                        <% } %>
                        <a href="../PaymentServlet?action=delete&paymentId=<%= payment.getPaymentId() %>" class="delete-btn">Delete</a>
                    </div>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>