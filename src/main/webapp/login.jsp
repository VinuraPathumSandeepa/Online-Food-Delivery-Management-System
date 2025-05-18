<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        h1 {
            color: #1b5e20;
            margin-bottom: 30px;
        }
        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        p {
            margin: 15px 0;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            margin-top: 5px;
        }
        input[type="submit"] {
            background-color: #2196f3;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #1976d2;
        }
        a {
            display: inline-block;
            color: #2196f3;
            text-decoration: none;
            margin: 5px;
            transition: color 0.3s;
        }
        a:hover {
            color: #1976d2;
            text-decoration: underline;
        }
        /* Style for error message */
        p:first-of-type {
            color: #f44336;
            font-weight: bold;
        }
    </style>
</head>
<body>
<h1>Login</h1>
<% String error = (String) request.getAttribute("error"); %>
<% if (error != null) { %>
<p><%= error %></p>
<% } %>
<form action="LoginServlet" method="post">
    <p>Email: <input type="text" name="email" required></p>
    <p>Password: <input type="password" name="password" required></p>
    <p><input type="submit" value="Login"></p>
</form>
<p><a href="register.jsp">Register</a></p>
<p><a href="index.jsp">Back to Home</a></p>
</body>
</html>