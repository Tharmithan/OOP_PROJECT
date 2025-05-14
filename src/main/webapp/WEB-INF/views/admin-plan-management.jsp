<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin Plan Management - Fitness Membership System</title>
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
            color: #000000;
            line-height: 1.6;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
            animation: gradientShift 10s ease infinite;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            animation: slideUp 0.5s ease-out;
            transition: transform 0.3s ease;
        }

        h2 {
            color: #fff;
            margin-bottom: 25px;
            font-weight: 600;
            font-size: 28px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
            text-align: center;
            animation: bounceIn 1s ease-out;
        }

        h3 {
            color: #fff;
            margin-bottom: 20px;
            font-weight: 500;
            font-size: 22px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-bottom: 30px;
            background: rgba(255, 255, 255, 0.1);
            padding: 25px;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        label {
            color: #fff;
            font-weight: 500;
            margin-bottom: 5px;
        }

        input, select, textarea {
            padding: 12px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            font-size: 16px;
            background: rgba(255, 255, 255, 0.1);
            color: #000000;
            transition: all 0.3s ease;
        }

        input:focus, select:focus, textarea:focus {
            border-color: #388e3c;
            outline: none;
            box-shadow: 0 0 0 2px rgba(56, 142, 60, 0.2);
        }

        textarea {
            min-height: 100px;
            resize: vertical;
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

        .bottom-links {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .bottom-link {
            display: inline-block;
            padding: 12px 25px;
            text-decoration: none;
            color: #fff;
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            border-radius: 25px;
            transition: all 0.3s ease;
            font-weight: 600;
        }

        .bottom-link:hover {
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

            .bottom-links {
                flex-direction: column;
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
    <h2>Manage Membership Plans</h2>
    <c:if test="${plan != null}">
        <h3>${plan.id == '' ? 'Add New Plan' : 'Edit Plan'}</h3>
        <form action="${plan.id == '' ? '/membership/admin/plans/add' : '/membership/admin/plans/edit'}" method="post">
            <c:if test="${plan.id != ''}">
                <input type="hidden" name="id" value="${plan.id}">
            </c:if>
            <label for="name">Plan Type:</label>
            <select name="name" id="name" required>
                <option value="Basic" ${plan.name == 'Basic' ? 'selected' : ''}>Basic</option>
                <option value="Standard" ${plan.name == 'Standard' ? 'selected' : ''}>Standard</option>
                <option value="Premium" ${plan.name == 'Premium' ? 'selected' : ''}>Premium</option>
            </select>
            <label for="price">Price:</label>
            <input type="number" step="0.01" name="price" id="price" value="${plan.price}" required>
            <label for="durationMonths">Duration (Months):</label>
            <input type="number" name="durationMonths" id="durationMonths" value="${plan.durationMonths}" required>
            <label for="accessRights">Access Rights:</label>
            <textarea name="accessRights" id="accessRights" required>${plan.accessRights}</textarea>
            <button type="submit">
                <i class="fas ${plan.id == '' ? 'fa-plus' : 'fa-save'}"></i>
                ${plan.id == '' ? 'Add Plan' : 'Update Plan'}
            </button>
        </form>
    </c:if>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Duration</th>
            <th>Access Rights</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="plan" items="${plans}" varStatus="loop">
            <tr style="--order: ${loop.count}">
                <td>${plan.id}</td>
                <td>${plan.name}</td>
                <td>$${plan.price}</td>
                <td>${plan.durationMonths} Months</td>
                <td>${plan.accessRights}</td>
                <td>
                    <div class="action-links">
                        <a href="/membership/admin/plans/edit/${plan.id}" class="action-link">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a href="/membership/admin/plans/delete/${plan.id}" class="action-link delete-link" onclick="return confirm('Are you sure you want to delete this plan?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </table>
    <div class="bottom-links">
        <a href="/membership/admin/plans/add" class="bottom-link">
            <i class="fas fa-plus"></i> Add New Plan
        </a>
        <a href="/users/admin/dashboard" class="bottom-link">
            <i class="fas fa-arrow-left"></i> Back to Admin Dashboard
        </a>
    </div>
</div>
</body>
</html>