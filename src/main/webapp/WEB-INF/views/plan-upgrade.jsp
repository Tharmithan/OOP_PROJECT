<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Upgrade Membership - Fitness Membership System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body { background: linear-gradient(135deg, #1e3c72, #2a5298); color: #fff; line-height: 1.6; padding: 20px; min-height: 100vh; }
        .container { max-width: 800px; margin: 0 auto; background: rgba(255, 255, 255, 0.1); padding: 30px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); animation: fadeIn 0.5s ease-in; }
        h2 { color: #fff; margin-bottom: 20px; font-weight: 600; }
        form { display: flex; flex-direction: column; gap: 15px; }
        select { padding: 10px; border: none; border-radius: 5px; background: rgba(255, 255, 255, 0.2); color: #fff; font-size: 16px; }
        select option { background: #2a5298; color: #fff; }
        button { padding: 10px 20px; background: linear-gradient(45deg, #388e3c, #2e7d32); color: #fff; border: none; border-radius: 25px; cursor: pointer; transition: all 0.3s ease; font-weight: 600; }
        button:hover { background: linear-gradient(45deg, #2e7d32, #1b5e20); transform: translateY(-2px); box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4); }
        a { display: inline-block; margin-top: 20px; padding: 10px 20px; text-decoration: none; color: #fff; background: linear-gradient(45deg, #388e3c, #2e7d32); border-radius: 25px; transition: all 0.3s ease; }
        a:hover { background: linear-gradient(45deg, #2e7d32, #1b5e20); transform: translateY(-2px); box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4); }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    </style>
</head>
<body>
<div class="container">
    <h2>Upgrade Your Membership</h2>
    <form action="/users/payment" method="get">
        <input type="hidden" name="userId" value="${userId}">
        <label for="planId" style="font-weight: 500;">Select a Plan:</label>
        <select name="planId" id="planId" required>
            <c:forEach var="plan" items="${plans}">
                <option value="${plan.id}">${plan.name} - $${plan.price} for ${plan.durationMonths} Months</option>
            </c:forEach>
        </select>
        <button type="submit">Pay Now</button>
    </form>
    <a href="/membership/plans">Back to Plans</a>
</div>
</body>
</html>