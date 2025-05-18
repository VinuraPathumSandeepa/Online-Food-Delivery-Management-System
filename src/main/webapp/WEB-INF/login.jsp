<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
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