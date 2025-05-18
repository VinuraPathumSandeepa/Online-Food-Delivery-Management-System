<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Delicious Food Drop</title>
    <!-- Add Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow-x: hidden;
        }

        .corner-icon {
            position: absolute;
            top: 20px;
            font-size: 2.5em;
            color: #1b5e20;
            opacity: 0.9;
        }

        .corner-icon.left {
            left: 20px;
            animation: float 3s ease-in-out infinite;
        }

        .corner-icon.right {
            right: 20px;
            animation: float 3s ease-in-out infinite;
        }

        .plate-container {
            position: relative;
            display: inline-block;
        }

        .plate-container .fa-circle {
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            font-size: 1.2em;
            color: #e0e0e0;
            z-index: 1;
        }

        .plate-container .fa-utensils {
            position: relative;
            z-index: 2;
        }

        @keyframes float {
            0% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-10px);
            }
            100% {
                transform: translateY(0px);
            }
        }

        .container {
            text-align: center;
            padding: 40px 20px;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            max-width: 600px;
            width: 90%;
            margin: 20px;
        }

        h1 {
            color: #1b5e20;
            margin-bottom: 20px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .tagline {
            color: #2e7d32;
            font-size: 1.2em;
            margin-bottom: 40px;
        }

        .nav-links {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .nav-button {
            display: inline-block;
            padding: 12px 30px;
            background-color: #2196f3;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-size: 1.1em;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(33, 150, 243, 0.3);
        }

        .nav-button:hover {
            background-color: #1976d2;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(33, 150, 243, 0.4);
        }

        .nav-button.register {
            background-color: #4caf50;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
        }

        .nav-button.register:hover {
            background-color: #388e3c;
            box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
        }

        .features {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 40px;
            flex-wrap: wrap;
        }

        .feature {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            flex: 1;
            min-width: 200px;
            max-width: 300px;
            transition: transform 0.3s ease;
        }

        .feature:hover {
            transform: translateY(-5px);
        }

        .feature h3 {
            color: #1976d2;
            margin-bottom: 10px;
        }

        .feature p {
            color: #666;
            font-size: 0.9em;
            line-height: 1.5;
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 15px;
            }

            h1 {
                font-size: 2em;
            }

            .nav-links {
                flex-direction: column;
                gap: 15px;
            }

            .nav-button {
                width: 100%;
                text-align: center;
            }

            .features {
                flex-direction: column;
                align-items: center;
            }

            .feature {
                width: 100%;
                max-width: none;
            }

            .corner-icon {
                font-size: 2em;
            }

            .corner-icon.left {
                left: 10px;
            }

            .corner-icon.right {
                right: 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Corner Icons -->
    <div class="corner-icon left">
        <div class="plate-container">
            <i class="fas fa-circle"></i>
            <i class="fas fa-utensils"></i>
        </div>
    </div>
    <div class="corner-icon right">
        <i class="fas fa-motorcycle"></i>
    </div>

    <div class="container">
        <h1>Delicious Food Drop</h1>
        <div class="tagline">Your favorite meals, delivered to your doorstep</div>
        
        <div class="features">
            <div class="feature">
                <h3>Quick Delivery</h3>
                <p>Fast and reliable delivery service to satisfy your cravings</p>
            </div>
            <div class="feature">
                <h3>Wide Selection</h3>
                <p>Choose from hundreds of restaurants and cuisines</p>
            </div>
            <div class="feature">
                <h3>Trustful Good Service</h3>
                <p>Reliable and professional service you can count on</p>
            </div>
        </div>

        <div class="nav-links">
            <a href="login.jsp" class="nav-button">Login</a>
            <a href="register.jsp" class="nav-button register">Register</a>
        </div>
    </div>
</body>
</html>