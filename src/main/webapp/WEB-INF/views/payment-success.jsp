<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <head>
        <title>Payment Successful - Fitness Membership System</title>
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
                text-align: center;
                max-width: 400px;
                width: 100%;
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

            p {
                color: #e0e0e0;
                margin-bottom: 20px;
                font-size: 16px;
            }

            a {
                display: inline-block;
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

            @media (max-width: 480px) {
                .card {
                    padding: 20px;
                    max-width: 100%;
                }

                h2 {
                    font-size: 24px;
                }

                p {
                    font-size: 14px;
                }

                a {
                    font-size: 14px;
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
            <h2>Payment Successful!</h2>
            <p>Your payment has been processed. Thank you!</p>
            <form action="/membership/submit-upgrade" method="post">
                <input type="hidden" name="planId" value="${param.planId}">
                <input type="hidden" name="userId" value="${param.userId}">
                <button type="submit" style="margin-top: 20px; padding: 10px 20px; border-radius: 25px; background: linear-gradient(45deg, #388e3c, #2e7d32); color: #fff; border: none; font-weight: 600; cursor: pointer;">Submit Upgrade Request</button>
            </form>
            <a href="/users/profile/${sessionScope.user.id}"><i class="fas fa-arrow-left"></i> Back to Profile</a>
        </div>
    </body>

    </html>