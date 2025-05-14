<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Home - Fitness Membership System</title>
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
            min-height: 100vh;
            overflow-x: hidden;
            animation: gradientShift 10s ease infinite;
        }

        .navbar {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 15px 30px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo i {
            color: #388e3c;
        }

        .nav-links {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .nav-link {
            color: #fff;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        .user-profile {
            position: relative;
            cursor: pointer;
        }

        .profile-button {
            background: rgba(255, 255, 255, 0.1);
            border: none;
            color: #fff;
            padding: 8px 15px;
            border-radius: 20px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
        }

        .profile-button:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .profile-dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            padding: 15px;
            margin-top: 10px;
            min-width: 250px;
            display: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            animation: slideDown 0.3s ease-out;
        }

        .profile-header {
            padding-bottom: 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 15px;
        }

        .profile-name {
            font-weight: 600;
            font-size: 18px;
            margin-bottom: 5px;
        }

        .profile-email {
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
        }

        .profile-menu {
            list-style: none;
        }

        .profile-menu li {
            margin-bottom: 10px;
        }

        .profile-menu a {
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .profile-menu a:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .main-content {
            padding: 100px 30px 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .welcome-section {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            animation: slideUp 0.5s ease-out;
        }

        .welcome-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 15px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .welcome-text {
            font-size: 18px;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 20px;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .action-card {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
            cursor: pointer;
            animation: fadeIn 0.5s ease-out backwards;
            animation-delay: calc(var(--order) * 0.1s);
        }

        .action-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .action-icon {
            font-size: 24px;
            margin-bottom: 15px;
            color: #388e3c;
        }

        .action-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .action-description {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.8);
        }

        @media (max-width: 768px) {
            .navbar {
                padding: 15px;
            }

            .nav-links {
                display: none;
            }

            .main-content {
                padding: 80px 15px 15px;
            }

            .welcome-section {
                padding: 20px;
            }

            .welcome-title {
                font-size: 24px;
            }

            .welcome-text {
                font-size: 16px;
            }
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
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

        @keyframes slideDown {
            from {
                transform: translateY(-10px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .auth-links {
            display: flex;
            gap: 10px;
            align-items: center;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="http://localhost:8080/" class="logo">
            <i class="fas fa-dumbbell"></i>
            Fitness Club
        </a>
        <c:choose>
            <c:when test="${not empty user}">
                <div class="nav-links">
                    <a href="http://localhost:8080/workout/list" class="nav-link">Workouts</a>
                    <a href="http://localhost:8080/workout/book" class="nav-link">Classes</a>
                    <a href="http://localhost:8080/trainers" class="nav-link">Trainers</a>
                    <a href="http://localhost:8080/membership/plans" class="nav-link">Membership</a>
                </div>
                <div class="user-profile">
                    <button class="profile-button" id="profileBtn" type="button">
                        <i class="fas fa-user-circle"></i>
                        ${user.name}
                    </button>
                    <div class="profile-dropdown" id="profileDropdown">
                        <div class="profile-header">
                            <div class="profile-name">${user.name}</div>
                            <div class="profile-email">${user.email}</div>
                        </div>
                        <ul class="profile-menu">
                            <li>
                                <a href="http://localhost:8080/users/profile">
                                    <i class="fas fa-user"></i>
                                    My Profile
                                </a>
                            </li>
                            <li>
                                <a href="http://localhost:8080/membership/plans">
                                    <i class="fas fa-crown"></i>
                                    My Membership
                                </a>
                            </li>
                            <li>
                                <a href="http://localhost:8080/checkin/history">
                                    <i class="fas fa-calendar"></i>
                                    My Schedule
                                </a>
                            </li>
                            <li>
                                <a href="http://localhost:8080/users/logout">
                                    <i class="fas fa-sign-out-alt"></i>
                                    Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="auth-links">
                    <a href="http://localhost:8080/users/login" class="nav-link">Login</a>
                    <a href="http://localhost:8080/users/register" class="nav-link">Register</a>
                </div>
            </c:otherwise>
        </c:choose>
    </nav>

    <main class="main-content">
        <section class="welcome-section">
            <h1 class="welcome-title">Welcome back, ${user.name}!</h1>
            <p class="welcome-text">Track your fitness journey and achieve your goals with us.</p>
        </section>

        <div class="quick-actions">
            <div class="action-card" style="--order: 1" >
                <i class="fas fa-dumbbell action-icon"></i>
                <h3 class="action-title">Start Workout</h3>
                <p class="action-description">Begin your daily workout routine</p>
            </div>
            <div class="action-card" style="--order: 2">
                <i class="fas fa-calendar-check action-icon"></i>
                <h3 class="action-title">Book Class</h3>
                <p class="action-description">Schedule your next fitness class</p>
            </div>
            <div class="action-card" style="--order: 3">
                <i class="fas fa-chart-line action-icon"></i>
                <h3 class="action-title">View Progress</h3>
                <p class="action-description">Track your fitness achievements</p>
            </div>
            <div class="action-card" style="--order: 4" onclick="window.location.href='http://localhost:8080/trainers'">
                <i class="fas fa-user-friends action-icon"></i>
                <h3 class="action-title">Find Trainer</h3>
                <p class="action-description">Connect with professional trainers</p>
            </div>
        </div>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const btn = document.getElementById('profileBtn');
            const dropdown = document.getElementById('profileDropdown');
            if (btn && dropdown) {
                btn.addEventListener('click', function(e) {
                    e.stopPropagation();
                    dropdown.style.display = (dropdown.style.display === 'block') ? 'none' : 'block';
                });
                document.addEventListener('click', function() {
                    dropdown.style.display = 'none';
                });
                dropdown.addEventListener('click', function(e) {
                    e.stopPropagation();
                });
            }
        });
    </script>
</body>
</html> 