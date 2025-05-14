<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <title>Admin Dashboard - Fitness Membership System</title>
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
                }

                .sidebar {
                    width: 250px;
                    background: rgba(46, 125, 50, 0.9);
                    backdrop-filter: blur(10px);
                    color: #fff;
                    padding: 20px;
                    position: fixed;
                    height: 100%;
                    overflow-y: auto;
                    transition: transform 0.3s ease, width 0.3s ease;
                    box-shadow: 5px 0 15px rgba(0, 0, 0, 0.2);
                }

                .sidebar h2 {
                    color: #fff;
                    font-size: 24px;
                    margin-bottom: 30px;
                    text-align: center;
                    text-transform: uppercase;
                    letter-spacing: 2px;
                    animation: bounceIn 1s ease-out;
                }

                .sidebar ul {
                    list-style: none;
                }

                .sidebar ul li {
                    margin-bottom: 15px;
                }

                .sidebar ul li a {
                    color: #fff;
                    text-decoration: none;
                    display: flex;
                    align-items: center;
                    padding: 12px 15px;
                    border-radius: 8px;
                    transition: all 0.3s ease;
                    font-weight: 500;
                }

                .sidebar ul li a i {
                    margin-right: 12px;
                    font-size: 18px;
                    transition: transform 0.3s ease;
                }

                .sidebar ul li a:hover {
                    background: rgba(56, 142, 60, 0.9);
                    transform: translateX(10px);
                }

                .sidebar ul li a:hover i {
                    transform: rotate(20deg) scale(1.2);
                }

                .main-content {
                    margin-left: 250px;
                    flex: 1;
                    padding: 30px;
                    transition: margin-left 0.3s ease;
                }

                .header {
                    background: rgba(255, 255, 255, 0.1);
                    backdrop-filter: blur(10px);
                    padding: 20px 40px;
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                    border-radius: 15px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 30px;
                    animation: slideDown 0.5s ease-out;
                }

                .header h2 {
                    color: #fff;
                    font-weight: 600;
                    font-size: 28px;
                    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
                }

                .content {
                    padding: 20px;
                }

                .cards {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                    gap: 25px;
                    perspective: 1000px;
                }

                .card {
                    background: rgba(255, 255, 255, 0.1);
                    backdrop-filter: blur(10px);
                    padding: 25px;
                    border-radius: 15px;
                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
                    text-align: center;
                    transition: all 0.4s ease;
                    transform-style: preserve-3d;
                    animation: flipIn 0.8s ease-out backwards;
                    animation-delay: calc(var(--order) * 0.1s);
                }

                .card i {
                    font-size: 40px;
                    color: #fff;
                    margin-bottom: 15px;
                    transition: transform 0.3s ease;
                }

                .card h3 {
                    color: #fff;
                    font-size: 20px;
                    margin-bottom: 15px;
                    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
                }

                .card a {
                    display: inline-block;
                    padding: 10px 20px;
                    text-decoration: none;
                    color: #fff;
                    background: linear-gradient(45deg, #388e3c, #2e7d32);
                    border-radius: 25px;
                    transition: all 0.3s ease;
                    font-weight: 600;
                }

                .card a:hover {
                    background: linear-gradient(45deg, #2e7d32, #1b5e20);
                    transform: translateY(-5px) scale(1.05);
                    box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
                }

                .card:hover {
                    transform: rotateX(5deg) translateY(-5px);
                }

                .card:hover i {
                    transform: scale(1.2);
                }

                @media (max-width: 768px) {
                    .sidebar {
                        width: 200px;
                    }

                    .main-content {
                        margin-left: 200px;
                    }
                }

                @media (max-width: 576px) {
                    .sidebar {
                        width: 100%;
                        height: auto;
                        position: relative;
                        transform: translateX(0);
                    }

                    .main-content {
                        margin-left: 0;
                        padding: 15px;
                    }

                    .header {
                        padding: 15px;
                    }

                    .cards {
                        grid-template-columns: 1fr;
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

                @keyframes slideDown {
                    from {
                        transform: translateY(-20px);
                        opacity: 0;
                    }

                    to {
                        transform: translateY(0);
                        opacity: 1;
                    }
                }

                @keyframes flipIn {
                    from {
                        transform: rotateY(90deg);
                        opacity: 0;
                    }

                    to {
                        transform: rotateY(0);
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
            <div class="sidebar">
                <h2>Admin Hub</h2>
                <ul>
                    <li><a href="/users/list"><i class="fas fa-users"></i> Manage Members</a></li>
                    <li><a href="/admin/payment-management"><i class="fas fa-money-bill-wave"></i> Manage Payments</a>
                    </li>
                    <li><a href="/membership/admin/plans"><i class="fas fa-file-alt"></i> Manage Plans</a></li>
                    <li><a href="/membership/admin/renewal-queue"><i class="fas fa-clock"></i> Manage Renewal Queue</a>
                    </li>
                    <li><a href="/membership/admin/sorted-renewals"><i class="fas fa-sort"></i> View Sorted Renewals</a>
                    </li>
                    <li><a href="/workout/admin/workouts"><i class="fas fa-dumbbell"></i> Manage Workouts & Trainers</a>
                    </li>
                    <li><a href="/checkin/admin"><i class="fas fa-calendar-check"></i> Manage Attendance</a></li>
                    <li><a href="/review/admin"><i class="fas fa-comments"></i> Moderate Reviews</a></li>
                    <li><a href="/users/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
            </div>
            <div class="main-content">
                <div class="header">
                    <h2>Welcome, Admin ${user.username}</h2>
                </div>
                <div class="content">
                    <p class="lead">Take control of the fitness ecosystem with these powerful tools.</p>
                    <div class="cards">
                        <div class="card" style="--order: 1;">
                            <i class="fas fa-users"></i>
                            <h3>Manage Members</h3>
                            <a href="/users/list">Go</a>
                        </div>
                        <div class="card" style="--order: 2;">
                            <i class="fas fa-money-bill-wave"></i>
                            <h3>Manage Payments</h3>
                            <a href="/admin/payment-management">Go</a>
                        </div>
                        <div class="card" style="--order: 3;">
                            <i class="fas fa-file-alt"></i>
                            <h3>Manage Plans</h3>
                            <a href="/membership/admin/plans">Go</a>
                        </div>
                        <div class="card" style="--order: 4;">
                            <i class="fas fa-clock"></i>
                            <h3>Manage Renewal Queue</h3>
                            <a href="/membership/admin/renewal-queue">Go</a>
                        </div>
                        <div class="card" style="--order: 5;">
                            <i class="fas fa-sort"></i>
                            <h3>View Sorted Renewals</h3>
                            <a href="/membership/admin/sorted-renewals">Go</a>
                        </div>
                        <div class="card" style="--order: 6;">
                            <i class="fas fa-dumbbell"></i>
                            <h3>Manage Workouts & Trainers</h3>
                            <a href="/workout/admin/workouts">Go</a>
                        </div>
                        <div class="card" style="--order: 7;">
                            <i class="fas fa-calendar-check"></i>
                            <h3>Manage Attendance</h3>
                            <a href="/checkin/admin">Go</a>
                        </div>
                        <div class="card" style="--order: 8;">
                            <i class="fas fa-comments"></i>
                            <h3>Moderate Reviews</h3>
                            <a href="/review/admin">Go</a>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>