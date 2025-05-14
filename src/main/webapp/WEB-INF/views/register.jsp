<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
        <title>Register - Fitness Membership System</title>
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
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                overflow: hidden;
                animation: gradientShift 10s ease infinite;
                position: relative;
            }

            body::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Cpath d='M0 50 Q 25 75, 50 50 T 100 50' fill='none' stroke='%23FFFFFF' stroke-opacity='0.1' stroke-width='1'/%3E%3C/svg%3E");
                background-size: 20px 20px;
                opacity: 0.1;
            }

            .register-card {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
                width: 100%;
                max-width: 400px;
                text-align: center;
                animation: slideUp 0.5s ease-out;
                position: relative;
                z-index: 1;
            }

            .register-header {
                background: linear-gradient(45deg, #388e3c, #2e7d32);
                color: #fff;
                padding: 20px;
                border-radius: 10px 10px 0 0;
                margin: -30px -30px 20px -30px;
            }

            .register-header h2 {
                font-size: 24px;
                font-weight: 600;
                margin-bottom: 5px;
                animation: bounceIn 1s ease-out;
            }

            .register-header p {
                font-size: 12px;
                opacity: 0.8;
            }

            .avatar {
                width: 80px;
                height: 80px;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 50%;
                margin: -40px auto 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 4px solid #388e3c;
                transition: transform 0.3s ease;
            }

            .avatar i {
                font-size: 40px;
                color: #fff;
            }

            .avatar:hover {
                transform: rotate(360deg);
            }

            .register-form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .form-group label {
                display: block;
                text-align: left;
                color: #fff;
                margin-bottom: 5px;
                font-weight: 500;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 10px;
                border: 2px solid rgba(255, 255, 255, 0.3);
                border-radius: 5px;
                background: rgba(255, 255, 255, 0.2);
                color: #fff;
                font-size: 14px;
                outline: none;
                transition: border-color 0.3s ease;
            }

            .form-group input:focus,
            .form-group select:focus {
                border-color: #388e3c;
            }

            .form-group input::placeholder,
            .form-group select::placeholder {
                color: #e0e0e0;
                opacity: 0.7;
            }

            .register-button {
                padding: 12px;
                background: linear-gradient(45deg, #388e3c, #2e7d32);
                color: #fff;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .register-button:hover {
                background: linear-gradient(45deg, #2e7d32, #1b5e20);
                transform: translateY(-2px) scale(1.05);
                box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
            }

            .form-footer {
                margin-top: 20px;
            }

            .form-footer a {
                color: #fff;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .form-footer a:hover {
                color: #388e3c;
                text-decoration: underline;
            }

            @media (max-width: 480px) {
                .register-card {
                    padding: 20px;
                    max-width: 100%;
                }

                .register-header {
                    padding: 15px;
                    margin: -20px -20px 20px -20px;
                }

                .avatar {
                    width: 60px;
                    height: 60px;
                    border: 3px solid #388e3c;
                }

                .avatar i {
                    font-size: 30px;
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
        <div class="register-card">
            <div class="register-header">
                <h2>Join Our Fitness Community</h2>
                <p>Create your account and start your fitness journey</p>
            </div>
            <div class="avatar"><i class="fas fa-user-circle"></i></div>
            <form action="/users/register" method="post" class="register-form">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required placeholder="Choose a username">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required
                        placeholder="Create a strong password">
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required placeholder="Enter your email">
                </div>
                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="tel" id="phone" name="phone" required placeholder="Enter your phone number">
                </div>
                <div class="form-group">
                    <label for="membershipType">Membership Type</label>
                    <select id="membershipType" name="membershipType">
                        <option value="Regular">Regular Membership</option>
                        <option value="Premium">Premium Membership</option>
                    </select>
                </div>
                <button type="submit" class="register-button">CREATE ACCOUNT</button>
            </form>
            <div class="form-footer">
                <p>Already have an account? <a href="/users/login">Login here</a></p>
            </div>
        </div>
    </body>

    </html>