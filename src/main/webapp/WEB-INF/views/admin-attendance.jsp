<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <head>
            <title>Admin Attendance Dashboard - Fitness Membership System</title>
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
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
                    justify-content: center;
                    align-items: center;
                    overflow-x: hidden;
                    animation: gradientShift 10s ease infinite;
                }

                .card {
                    background: rgba(255, 255, 255, 0.1);
                    backdrop-filter: blur(10px);
                    padding: 30px;
                    border-radius: 15px;
                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
                    width: 1000px;
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

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin: 20px 0;
                    background: rgba(255, 255, 255, 0.15);
                    border-radius: 10px;
                    overflow: hidden;
                }

                th,
                td {
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

                form {
                    display: inline;
                }

                input,
                select {
                    padding: 12px;
                    margin: 5px;
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
                    box-shadow: 0 4px 15px rgba(46, 125, 50, 0.3);
                }

                button:hover {
                    background: linear-gradient(45deg, #2e7d32, #1b5e20);
                    transform: translateY(-2px) scale(1.05);
                    box-shadow: 0 6px 20px rgba(46, 125, 50, 0.4);
                }

                .delete-button {
                    background: linear-gradient(45deg, #d32f2f, #b71c1c);
                }

                .delete-button:hover {
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
                    .card {
                        padding: 20px;
                        width: 95%;
                    }

                    th, td {
                        padding: 10px;
                        font-size: 14px;
                    }

                    input, select {
                        padding: 8px;
                        font-size: 14px;
                    }
                }

                @media (max-width: 480px) {
                    .card {
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
            <div class="card">
                <h2>Admin Attendance Dashboard</h2>
                <table>
                    <tr>
                        <th>Check-In ID</th>
                        <th>User ID</th>
                        <th>Type</th>
                        <th>Check-In Date</th>
                        <th>Virtual Class ID</th>
                        <th>Actions</th>
                    </tr>
                    <c:forEach var="checkIn" items="${checkIns}" varStatus="loop">
                        <tr style="--order: ${loop.count}">
                            <td data-label="Check-In ID">${checkIn.checkInId}</td>
                            <td data-label="User ID">
                                <form action="/checkin/admin" method="post">
                                    <input type="hidden" name="checkInId" value="${checkIn.checkInId}">
                                    <input type="hidden" name="action" value="update">
                                    <input type="text" name="userId" value="${checkIn.userId}" required>
                            </td>
                            <td data-label="Type">
                                <select name="type" required>
                                    <option value="Gym" ${checkIn.type=='Gym' ? 'selected' : ''}>Gym</option>
                                    <option value="Virtual" ${checkIn.type=='Virtual' ? 'selected' : ''}>Virtual</option>
                                </select>
                            </td>
                            <td data-label="Check-In Date">
                                <input type="datetime-local" name="checkInDate" 
                                    value="${checkIn.checkInDate.toString().replace(' ', 'T').substring(0, 16)}" required>
                            </td>
                            <td data-label="Virtual Class ID">
                                <input type="number" name="virtualClassId" 
                                    value="${checkIn.type == 'Virtual' ? checkIn.virtualClassId : ''}">
                            </td>
                            <td data-label="Actions">
                                <button type="submit">
                                    <i class="fas fa-save"></i> Update
                                </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <form action="/checkin/admin" method="post">
                    <input type="hidden" name="action" value="deleteOld">
                    <button type="submit" class="delete-button">
                        <i class="fas fa-trash"></i> Delete Old Records (Older than 6 Months)
                    </button>
                </form>
                <a href="/users/admin/dashboard" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Admin Dashboard
                </a>
            </div>
        </body>

        </html>