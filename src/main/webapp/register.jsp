<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9;
            margin: 0;
            padding: 20px;
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            color: #1b5e20;
            text-align: center;
            margin-bottom: 30px;
        }

        /* Form Container */
        .register-container {
            width: 100%;
            max-width: 400px;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #1b5e20;
            font-weight: bold;
        }

        /* Input Fields */
        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 12px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus,
        select:focus {
            outline: none;
            border-color: #2196f3;
            box-shadow: 0 0 5px rgba(33, 150, 243, 0.3);
        }

        /* Register Button */
        .register-btn {
            width: 100%;
            padding: 12px;
            background-color: #2196f3;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .register-btn:hover {
            background-color: #1976d2;
        }

        /* Links */
        .links-container {
            text-align: center;
            margin-top: 20px;
        }

        .links-container a {
            display: inline-block;
            color: #2196f3;
            text-decoration: none;
            margin: 5px 0;
            transition: color 0.3s;
        }

        .links-container a:hover {
            color: #1976d2;
            text-decoration: underline;
        }

        /* Role Select */
        .role-group {
            margin-bottom: 20px;
        }

        .role-group label {
            display: block;
            margin-bottom: 5px;
            color: #1b5e20;
            font-weight: bold;
        }

        select {
            background-color: white;
            cursor: pointer;
        }

        select:hover {
            border-color: #2196f3;
        }

        /* Error Message (if needed) */
        .error-message {
            color: #f44336;
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 4px;
            display: none; /* Show when needed */
        }

        /* Responsive Design */
        @media (max-width: 480px) {
            .register-container {
                padding: 20px;
                margin: 0 10px;
            }

            h1 {
                font-size: 24px;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            select,
            .register-btn {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <h1>Register</h1>
    <div class="register-container">
        <form action="RegisterServlet" method="post">
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" required>
            </div>

            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="role-group">
                <label for="role">Role:</label>
                <select id="role" name="role" required>
                    <option value="customer">Customer</option>
                    <option value="restaurant">Restaurant</option>
                    <option value="delivery">Delivery</option>
                </select>
            </div>

            <input type="submit" value="Register" class="register-btn">
        </form>
    </div>

    <div class="links-container">
        <a href="login.jsp">Already have an account? Login</a>
        <br>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>