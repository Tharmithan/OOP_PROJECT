<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin Workout Management - Fitness Membership System</title>
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
            line-height: 1.6;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
            animation: gradientShift 10s ease infinite;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            animation: slideUp 0.5s ease-out;
            transition: transform 0.3s ease;
        }

        h2, h3 {
            color: #fff;
            margin-bottom: 25px;
            font-weight: 600;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
            animation: bounceIn 1s ease-out;
        }

        h2 {
            font-size: 28px;
            text-align: center;
        }

        h3 {
            font-size: 22px;
            margin-top: 30px;
        }

        form {
            background: rgba(255, 255, 255, 0.1);
            padding: 25px;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 30px;
            animation: fadeIn 0.5s ease-out;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #fff;
            font-weight: 500;
        }

        input, select {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            color: #000000;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        input:focus, select:focus {
            border-color: #388e3c;
            outline: none;
            box-shadow: 0 0 0 2px rgba(56, 142, 60, 0.2);
        }

        button {
            padding: 12px 25px;
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            color: #fff;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-top: 10px;
            box-shadow: 0 4px 15px rgba(46, 125, 50, 0.3);
        }

        button:hover {
            background: linear-gradient(45deg, #2e7d32, #1b5e20);
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 6px 20px rgba(46, 125, 50, 0.4);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: left;
            transition: all 0.3s ease;
        }

        th {
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            color: #fff;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        tr {
            transition: transform 0.3s ease, background 0.3s ease;
            animation: fadeIn 0.5s ease-out backwards;
            animation-delay: calc(var(--order) * 0.1s);
        }

        tr:hover {
            background: rgba(56, 142, 60, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .action-links {
            display: flex;
            gap: 10px;
        }

        .action-link {
            display: inline-block;
            padding: 8px 15px;
            text-decoration: none;
            color: #fff;
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            border-radius: 20px;
            transition: all 0.3s ease;
            font-weight: 500;
            font-size: 14px;
        }

        .action-link:hover {
            background: linear-gradient(45deg, #2e7d32, #1b5e20);
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 4px 10px rgba(46, 125, 50, 0.4);
        }

        .delete-link {
            background: linear-gradient(45deg, #d32f2f, #b71c1c);
        }

        .delete-link:hover {
            background: linear-gradient(45deg, #b71c1c, #7f0000);
        }

        .back-link {
            display: inline-block;
            padding: 12px 25px;
            margin-top: 20px;
            text-decoration: none;
            color: #fff;
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            border-radius: 25px;
            transition: all 0.3s ease;
            font-weight: 600;
        }

        .back-link:hover {
            background: linear-gradient(45deg, #2e7d32, #1b5e20);
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 6px 20px rgba(46, 125, 50, 0.4);
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            form {
                padding: 20px;
            }

            th, td {
                padding: 10px;
                font-size: 14px;
            }

            .action-links {
                flex-direction: column;
                gap: 5px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 15px;
            }

            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }

            tr {
                margin-bottom: 15px;
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 10px;
            }

            td {
                border: none;
                position: relative;
                padding-left: 50%;
                text-align: right;
            }

            td:before {
                content: attr(data-label);
                position: absolute;
                left: 10px;
                font-weight: 600;
                color: #fff;
                text-transform: uppercase;
                letter-spacing: 0.5px;
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
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes bounceIn {
            0% {
                transform: scale(0.9);
                opacity: 0;
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Admin Workout Management</h2>
    
    <h3>Add/Edit Workout</h3>
    <form action="${workout.id == null ? '/workout/admin/workouts/add' : '/workout/admin/workouts/edit'}" method="post">
        <input type="hidden" name="id" value="${workout.id}">
        <label>Name:</label>
        <input type="text" name="name" value="${workout.name}" required>
        <label>Description:</label>
        <input type="text" name="description" value="${workout.description}" required>
        <label>Duration (Minutes):</label>
        <input type="number" name="durationMinutes" value="${workout.durationMinutes}" required>
        <label>Trainer:</label>
        <select name="trainerId" required>
            <c:forEach var="trainer" items="${trainers}">
                <option value="${trainer.id}" ${workout.trainerId == trainer.id ? 'selected' : ''}>${trainer.name}</option>
            </c:forEach>
        </select>
        <label>Type:</label>
        <select name="type" required>
            <option value="Cardio" ${workout.type == 'Cardio' ? 'selected' : ''}>Cardio</option>
            <option value="Strength" ${workout.type == 'Strength' ? 'selected' : ''}>Strength</option>
        </select>
        <button type="submit">
            <i class="fas ${workout.id == null ? 'fa-plus' : 'fa-save'}"></i>
            ${workout.id == null ? 'Add Workout' : 'Update Workout'}
        </button>
    </form>

    <h3>Workout List</h3>
    <table>
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Duration</th>
            <th>Type</th>
            <th>Trainer ID</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="workout" items="${workouts}" varStatus="loop">
            <tr style="--order: ${loop.count}">
                <td data-label="Name">${workout.name}</td>
                <td data-label="Description">${workout.description}</td>
                <td data-label="Duration">${workout.durationMinutes}</td>
                <td data-label="Type">${workout.type}</td>
                <td data-label="Trainer ID">${workout.trainerId}</td>
                <td>
                    <div class="action-links">
                        <a href="/workout/admin/workouts/edit/${workout.id}" class="action-link">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a href="/workout/admin/workouts/delete/${workout.id}" class="action-link delete-link" onclick="return confirm('Are you sure you want to delete this workout?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </table>

    <h3>Add/Edit Trainer</h3>
    <form action="${trainer.id == null ? '/workout/admin/trainers/add' : '/workout/admin/trainers/edit'}" method="post">
        <input type="hidden" name="id" value="${trainer.id}">
        <label>Name:</label>
        <input type="text" name="name" value="${trainer.name}" required>
        <label>Specialization:</label>
        <input type="text" name="specialization" value="${trainer.specialization}" required>
        <label>Availability:</label>
        <input type="text" name="availability" value="${trainer.availability}" required>
        <button type="submit">
            <i class="fas ${trainer.id == null ? 'fa-plus' : 'fa-save'}"></i>
            ${trainer.id == null ? 'Add Trainer' : 'Update Trainer'}
        </button>
    </form>

    <h3>Trainer List</h3>
    <table>
        <tr>
            <th>Name</th>
            <th>Specialization</th>
            <th>Availability</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="trainer" items="${trainers}" varStatus="loop">
            <tr style="--order: ${loop.count}">
                <td data-label="Name">${trainer.name}</td>
                <td data-label="Specialization">${trainer.specialization}</td>
                <td data-label="Availability">${trainer.availability}</td>
                <td>
                    <div class="action-links">
                        <a href="/workout/admin/trainers/edit/${trainer.id}" class="action-link">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a href="/workout/admin/trainers/delete/${trainer.id}" class="action-link delete-link" onclick="return confirm('Are you sure you want to delete this trainer?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </table>

    <a href="/users/admin/dashboard" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Admin Dashboard
    </a>
</div>
</body>
</html>