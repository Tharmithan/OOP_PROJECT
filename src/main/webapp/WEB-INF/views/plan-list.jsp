<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Membership Plans - Fitness Membership System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background: linear-gradient(135deg, #1e3c72, #2a5298); color: #fff; line-height: 1.6; padding: 20px; min-height: 100vh; }
        .container { max-width: 800px; margin: 0 auto; background: rgba(255, 255, 255, 0.1); padding: 30px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); animation: fadeIn 0.5s ease-in; }
        h2 { color: #fff; margin-bottom: 20px; font-weight: 600; }
        .cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; }
        .card { background: rgba(255, 255, 255, 0.15); padding: 20px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); text-align: center; transition: transform 0.3s ease; }
        .card:hover { transform: translateY(-5px); }
        .card h3 { font-size: 20px; margin-bottom: 10px; }
        .card p { color: #e0e0e0; margin-bottom: 10px; }
        .action-button { display: inline-block; padding: 10px 20px; text-decoration: none; color: #fff; background: linear-gradient(45deg, #388e3c, #2e7d32); border-radius: 25px; transition: all 0.3s ease; font-weight: 600; }
        .action-button:hover { background: linear-gradient(45deg, #2e7d32, #1b5e20); transform: translateY(-2px); box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4); }
        a { display: inline-block; margin-top: 20px; padding: 10px 20px; text-decoration: none; color: #fff; background: linear-gradient(45deg, #388e3c, #2e7d32); border-radius: 25px; transition: all 0.3s ease; }
        a:hover { background: linear-gradient(45deg, #2e7d32, #1b5e20); transform: translateY(-2px); box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4); }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    </style>
</head>
<body>
<div class="container">
    <h2>Available Membership Plans</h2>
    <div class="cards">
        <c:forEach var="plan" items="${plans}">
            <div class="card">
                <h3>${plan.name} Plan</h3>
                <p>Price: $${plan.price}</p>
                <p>Duration: ${plan.durationMonths} Months</p>
                <p>Access: ${plan.accessRights}</p>
                <a href="/membership/upgrade" class="action-button">Upgrade Now</a>
            </div>
        </c:forEach>
    </div>
    <a href="/users/profile">Back to Profile</a>
</div>
</body>
</html>