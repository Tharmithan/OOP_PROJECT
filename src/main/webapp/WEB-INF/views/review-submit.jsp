<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Submit Review - Fitness Membership System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            overflow-x: hidden;
            animation: gradientShift 10s ease infinite;
            padding: 20px;
        }

        .card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            width: 450px;
            text-align: center;
            animation: slideUp 0.5s ease-out;
        }

        h2 {
            color: #fff;
            margin-bottom: 20px;
            font-weight: 600;
            font-size: 28px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
            animation: bounceIn 1s ease-out;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            display: block;
            text-align: left;
            color: #fff;
            font-weight: 500;
            margin-bottom: 5px;
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.2);
            color: #000000;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s ease;
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: #388e3c;
        }

        input::placeholder,
        textarea::placeholder {
            color: #e0e0e0;
            opacity: 0.7;
        }

        textarea {
            resize: none;
            height: 100px;
        }

        button {
            padding: 12px;
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            color: #fff;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        button i {
            margin-right: 8px;
        }

        button:hover {
            background: linear-gradient(45deg, #2e7d32, #1b5e20);
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
        }

        a {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            text-decoration: none;
            color: #fff;
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            border-radius: 25px;
            transition: all 0.3s ease;
            font-weight: 600;
        }

        a i {
            margin-right: 8px;
        }

        a:hover {
            background: linear-gradient(45deg, #2e7d32, #1b5e20);
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
        }

        #trainerField,
        #facilityField {
            display: none;
            animation: fadeIn 0.5s ease-out;
        }

        .error-message {
            color: #ff4444;
            background: rgba(255, 68, 68, 0.1);
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }

        .success-message {
            color: #4CAF50;
            background: rgba(76, 175, 80, 0.1);
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }

        @media (max-width: 480px) {
            .card {
                padding: 20px;
                width: 100%;
            }
            h2 {
                font-size: 24px;
            }
            input,
            select,
            textarea,
            button,
            a {
                font-size: 14px;
            }
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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
    </style>
</head>
<body>
<div class="card">
    <h2>Submit Review</h2>
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="success-message">${message}</div>
    </c:if>
    <form action="/review/submit" method="post">
        <input type="hidden" name="userId" value="${userId}">
        <label for="type">Review Type:</label>
        <select id="type" name="type" onchange="toggleFields()">
            <option value="Trainer">Trainer</option>
            <option value="Facility">Facility</option>
        </select>
        <div id="trainerField">
            <label for="trainerName">Trainer Name:</label>
            <input type="text" id="trainerName" name="trainerName" placeholder="Enter trainer name">
        </div>
        <div id="facilityField">
            <label for="facilityArea">Facility Area:</label>
            <input type="text" id="facilityArea" name="facilityArea" placeholder="Enter facility area">
        </div>
        <label for="content">Feedback:</label>
        <textarea id="content" name="content" rows="4" required placeholder="Write your feedback here..."></textarea>
        <label for="rating">Rating (1-5):</label>
        <input type="number" id="rating" name="rating" min="1" max="5" required placeholder="Enter rating (1-5)">
        <button type="submit"><i class="fas fa-paper-plane"></i> Submit Review</button>
    </form>
    <a href="/users/profile"><i class="fas fa-arrow-left"></i> Back to Profile</a>
</div>
<script>
    function toggleFields() {
        const type = document.getElementById("type").value;
        const trainerField = document.getElementById("trainerField");
        const facilityField = document.getElementById("facilityField");
        const trainerInput = document.getElementById("trainerName");
        const facilityInput = document.getElementById("facilityArea");

        if (type === "Trainer") {
            trainerField.style.display = "block";
            facilityField.style.display = "none";
            trainerInput.required = true;
            facilityInput.required = false;
            facilityInput.value = "";
        } else {
            trainerField.style.display = "none";
            facilityField.style.display = "block";
            trainerInput.required = false;
            facilityInput.required = true;
            trainerInput.value = "";
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        toggleFields();
    });
</script>
</body>
</html>