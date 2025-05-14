<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Trainer Profiles</title>
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
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            animation: fadeIn 0.5s ease-in;
        }
        h2 {
            color: #fff;
            margin-bottom: 25px;
            font-weight: 600;
            font-size: 28px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0 30px 0;
            background: rgba(255,255,255,0.15);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 15px;
            border: 1px solid rgba(255,255,255,0.2);
            text-align: left;
            color: #fff;
            font-size: 16px;
        }
        th {
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            color: #fff;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        tr {
            transition: background 0.3s, transform 0.3s;
        }
        tr:hover {
            background: rgba(56,142,60,0.15);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        a {
            display: inline-block;
            margin: 10px 10px 0 0;
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
        @media (max-width: 900px) {
            .container { padding: 20px 5px; }
            th, td { font-size: 14px; padding: 10px; }
        }
        @media (max-width: 600px) {
            .container { padding: 10px 2px; }
            h2 { font-size: 20px; }
            a { font-size: 14px; padding: 10px 16px; }
        }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    </style>
</head>
<body>
<div class="container">
    <h2>Trainer Profiles</h2>
    <table>
        <tr>
            <th>Name</th>
            <th>Specialization</th>
            <th>Availability</th>
        </tr>
        <c:forEach var="trainer" items="${trainers}">
            <tr>
                <td>${trainer.name}</td>
                <td>${trainer.specialization}</td>
                <td>${trainer.availability}</td>
            </tr>
        </c:forEach>
    </table>
    <a href="/workout/book"><i class="fas fa-calendar-plus"></i> Book a Session</a>
    <a href="/users/profile"><i class="fas fa-arrow-left"></i> Back to Profile</a>
</div>
</body>
</html>