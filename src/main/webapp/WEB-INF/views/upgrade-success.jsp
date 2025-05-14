<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upgrade Request Submitted - Fitness Membership System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: 'Poppins', sans-serif;
            overflow-x: hidden;
            padding: 20px;
        }
        .card {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            text-align: center;
            max-width: 400px;
            width: 100%;
            animation: slideUp 0.5s ease-out;
        }
        h2 {
            color: #fff;
            margin-bottom: 20px;
            font-weight: 600;
            font-size: 28px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            animation: bounceIn 1s ease-out;
        }
        p {
            color: #4caf50;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 25px;
        }
        .message {
            color: #ffffff;
            background: rgba(255,255,255,0.1);
            padding: 8px 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 16px;
            animation: fadeIn 0.5s ease-out;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 28px;
            text-decoration: none;
            color: #000000;
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            border-radius: 25px;
            transition: all 0.3s ease;
            font-weight: 600;
            font-size: 16px;
            box-shadow: 0 4px 10px rgba(46,125,50,0.2);
        }
        a:hover {
            background: linear-gradient(45deg, #2e7d32, #1b5e20);
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 6px 15px rgba(46,125,50,0.4);
        }
        @media (max-width: 480px) {
            .card {
                padding: 20px 10px;
                max-width: 100%;
            }
            h2 {
                font-size: 22px;
            }
            p, .message, a {
                font-size: 14px;
            }
        }
        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        @keyframes bounceIn {
            0% { transform: scale(0.9); opacity: 0; }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); opacity: 1; }
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>Request Submitted!</h2>
        <p>Your request has been successfully submitted!</p>
        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>
        <a href="/membership/plans"><i class="fas fa-arrow-left"></i> Back to Plans</a>
    </div>
</body>
</html> 