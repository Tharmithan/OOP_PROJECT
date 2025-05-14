<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Profile - Fitness Membership System</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            overflow-x: hidden;
            animation: gradientShift 10s ease infinite;
            padding: 20px;
        }

        .container {
            max-width: 450px;
            margin: 0 auto;
            animation: fadeIn 0.5s ease-in;
        }

        .profile-wrapper {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            animation: slideUp 0.5s ease-out;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-avatar {
            font-size: 80px;
            color: #fff;
            margin-bottom: 10px;
            animation: bounceIn 1s ease-out;
        }

        h2 {
            color: #fff;
            font-weight: 600;
            font-size: 28px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .membership-badge {
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            color: #fff;
            padding: 8px 15px;
            border-radius: 20px;
            margin-top: 10px;
            display: inline-block;
            font-weight: 500;
        }

        .membership-badge i {
            margin-right: 5px;
        }

        .profile-content {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .profile-card {
            background: rgba(255, 255, 255, 0.15);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.5s ease-out;
        }

        .info-group {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .info-group i {
            font-size: 20px;
            color: #fff;
            transition: transform 0.3s ease;
        }

        .info-group:hover i {
            transform: scale(1.2);
        }

        .info-content label {
            font-weight: 500;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-content p {
            color: #e0e0e0;
        }

        .profile-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
        }

        .action-button {
            padding: 10px 20px;
            text-decoration: none;
            color: #fff;
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            border-radius: 25px;
            transition: all 0.3s ease;
            font-weight: 600;
            animation: slideIn 0.5s ease-out backwards;
            animation-delay: calc(var(--order) * 0.2s);
        }

        .action-button i {
            margin-right: 8px;
        }

        .action-button:hover {
            background: linear-gradient(45deg, #2e7d32, #1b5e20);
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
        }

        @media (max-width: 480px) {
            .container {
                max-width: 100%;
                padding: 15px;
            }

            .profile-wrapper {
                padding: 20px;
            }

            .profile-avatar {
                font-size: 60px;
            }

            h2 {
                font-size: 24px;
            }

            .action-button {
                width: 100%;
                text-align: center;
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

        @keyframes slideIn {
            from {
                transform: translateX(-20px);
                opacity: 0;
            }

            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-wrapper">
            <div class="profile-header">
                <div class="profile-avatar"><i class="fas fa-user-circle"></i></div>
                <h2>Welcome, ${user.username}</h2>
                <p class="membership-badge"><i class="fas fa-crown"></i> ${user.membershipType} Member</p>
            </div>
            <div class="profile-content">
                <div class="profile-card">
                    <div class="info-group">
                        <i class="fas fa-id-badge"></i>
                        <div class="info-content">
                            <label>User ID</label>
                            <p>${user.id}</p>
                        </div>
                    </div>
                    <div class="info-group">
                        <i class="fas fa-user"></i>
                        <div class="info-content">
                            <label>Username</label>
                            <p>${user.username}</p>
                        </div>
                    </div>
                    <div class="info-group">
                        <i class="fas fa-envelope"></i>
                        <div class="info-content">
                            <label>Email</label>
                            <p>${user.email}</p>
                        </div>
                    </div>
                    <div class="info-group">
                        <i class="fas fa-phone"></i>
                        <div class="info-content">
                            <label>Phone</label>
                            <p>${user.phone}</p>
                        </div>
                    </div>
                    <div class="info-group">
                        <i class="fas fa-id-card"></i>
                        <div class="info-content">
                            <label>Membership Type</label>
                            <p>${user.membershipType}</p>
                        </div>
                    </div>
                </div>
                <div class="profile-actions">
                    <a href="/users/edit/${user.id}" class="action-button" style="--order: 1;"><i class="fas fa-edit"></i> Edit Profile</a>
                    <a href="/users/payment" class="action-button" style="--order: 2;"><i class="fas fa-money-bill-wave"></i> Make a Payment</a>
                    <a href="/checkin?userId=${user.id}" class="action-button" style="--order: 3;"><i class="fas fa-calendar-check"></i> Check-In</a>
                    <a href="/checkin/history" class="action-button" style="--order: 4;"><i class="fas fa-history"></i> Attendance History</a>
                    <a href="/review/submit" class="action-button" style="--order: 5;"><i class="fas fa-comment-dots"></i> Submit Review</a>
                    <a href="/review/view?userId=${user.id}" class="action-button" style="--order: 6;"><i class="fas fa-comments"></i> View My Reviews</a>
                    <a href="/membership/plans" class="action-button" style="--order: 7;"><i class="fas fa-file-alt"></i> View Membership Plans</a>
                    <a href="/users/logout" class="action-button" style="--order: 8;"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>
    <script>
        // Store user ID in localStorage after login
        window.addEventListener('DOMContentLoaded', function() {
            var userId = '${user.id}';
            if (userId) {
                localStorage.setItem('userId', userId);
                console.log('User ID stored in localStorage:', userId);
            }
        });
    </script>
</body>
</html>