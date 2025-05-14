<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Book Training Session</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: #fff;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            overflow-x: hidden;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            animation: slideUp 0.5s ease-out;
            text-align: center;
        }
        h2 {
            color: #fff;
            margin-bottom: 25px;
            font-weight: 600;
            font-size: 28px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 18px;
            align-items: stretch;
        }
        label {
            margin-bottom: 5px;
            color: #fff;
            font-weight: 500;
            text-align: left;
        }
        input, select {
            padding: 12px;
            border: 2px solid rgba(255,255,255,0.3);
            border-radius: 8px;
            background: rgba(255,255,255,0.2);
            color: #fff;
            font-size: 16px;
            outline: none;
            transition: border-color 0.3s ease;
        }
        input:focus, select:focus {
            border-color: #388e3c;
        }
        button {
            padding: 12px 0;
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            color: #fff;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            margin-top: 10px;
            box-shadow: 0 4px 15px rgba(46,125,50,0.3);
        }
        button:hover {
            background: linear-gradient(45deg, #2e7d32, #1b5e20);
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 6px 20px rgba(46,125,50,0.4);
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 28px;
            text-decoration: none;
            color: #fff;
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
        @media (max-width: 600px) {
            .container { padding: 20px 5px; }
            h2 { font-size: 20px; }
            input, select, button, a { font-size: 14px; }
        }
        @keyframes slideUp { from { transform: translateY(20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
    </style>
</head>
<body>
<div class="container">
    <h2>Book Training Session</h2>
    <form action="/workout/book" method="post" onsubmit="return validateBookingForm()">
        <label>User ID:</label>
        <input type="text" name="userId" value="123" required>
        <label>Workout:</label>
        <select name="workoutId" required>
            <c:forEach var="workout" items="${workouts}">
                <option value="${workout.id}">${workout.name} (${workout.type})</option>
            </c:forEach>
        </select>
        <label>Trainer:</label>
        <select name="trainerId" required>
            <c:forEach var="trainer" items="${trainers}">
                <option value="${trainer.id}">${trainer.name}</option>
            </c:forEach>
        </select>
        <label>Session Time:</label>
        <input type="datetime-local" name="sessionTime" value="2025-05-07T19:47" required>
        <button type="submit"><i class="fas fa-calendar-check"></i> Book Session</button>
    </form>
    <a href="/workout/list"><i class="fas fa-arrow-left"></i> Back to Workouts</a>
</div>
<script src="/resources/js/script.js"></script>
</body>
</html>