<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <title>Member List - Fitness Membership System</title>
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
                    display: flex;
                    min-height: 100vh;
                    overflow-x: hidden;
                    animation: gradientShift 10s ease infinite;
                    padding: 20px;
                }

                .member-list-wrapper {
                    max-width: 900px;
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

                td a {
                    display: inline-block;
                    padding: 8px 15px;
                    margin: 5px;
                    text-decoration: none;
                    color: #fff;
                    background: linear-gradient(45deg, #388e3c, #2e7d32);
                    border-radius: 20px;
                    transition: all 0.3s ease;
                    font-weight: 500;
                }

                td a:hover {
                    background: linear-gradient(45deg, #2e7d32, #1b5e20);
                    transform: translateY(-2px) scale(1.05);
                    box-shadow: 0 4px 10px rgba(46, 125, 50, 0.4);
                }

                .back-button {
                    display: inline-block;
                    padding: 10px 20px;
                    margin-top: 20px;
                    text-decoration: none;
                    color: #fff;
                    background: linear-gradient(45deg, #388e3c, #2e7d32);
                    border-radius: 25px;
                    transition: all 0.3s ease;
                    font-weight: 600;
                    text-align: center;
                }

                .back-button:hover {
                    background: linear-gradient(45deg, #2e7d32, #1b5e20);
                    transform: translateY(-2px) scale(1.05);
                    box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
                }

                @media (max-width: 768px) {
                    .member-list-wrapper {
                        padding: 20px;
                    }

                    th,
                    td {
                        padding: 10px;
                        font-size: 14px;
                    }

                    table {
                        font-size: 14px;
                    }
                }

                @media (max-width: 480px) {
                    .member-list-wrapper {
                        padding: 15px;
                    }

                    table,
                    thead,
                    tbody,
                    th,
                    td,
                    tr {
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

                    td:nth-of-type(1):before {
                        content: "Username";
                    }

                    td:nth-of-type(2):before {
                        content: "Email";
                    }

                    td:nth-of-type(3):before {
                        content: "Phone";
                    }

                    td:nth-of-type(4):before {
                        content: "Membership Type";
                    }

                    td:nth-of-type(5):before {
                        content: "Actions";
                    }
                }

                @keyframes gradientShift {
                    0% {
                        background-position: 0% 50%;
                    }

                    50% {
                        background-position: 100% 50%;
                    }

                    100% {
                        background-position: 0% 50%;
                    }
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                    }

                    to {
                        opacity: 1;
                    }
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
            <div class="member-list-wrapper">
                <h2>Member Directory</h2>
                <table>
                    <tr>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Membership Type</th>
                        <th>Actions</th>
                    </tr>
                    <c:forEach var="member" items="${members}" varStatus="loop">
                        <tr style="--order: ${loop.count}">
                            <td data-label="Username">${member.username}</td>
                            <td data-label="Email">${member.email}</td>
                            <td data-label="Phone">${member.phone}</td>
                            <td data-label="Membership Type">${member.membershipType}</td>
                            <td data-label="Actions">
                                <a href="/users/edit/${member.id}">Edit</a>
                                <a href="/users/delete/${member.id}"
                                    onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <a href="/users/admin/dashboard" class="back-button">Back to Admin Hub</a>
            </div>
        </body>

        </html>