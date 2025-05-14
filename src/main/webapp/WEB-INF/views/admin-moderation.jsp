<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <head>
            <title>Admin Moderation Panel - Fitness Membership System</title>
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
                    width: 800px;
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

                .review {
                    background: rgba(255, 255, 255, 0.15);
                    margin: 15px 0;
                    padding: 20px;
                    border-radius: 10px;
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    transition: all 0.3s ease;
                    animation: fadeIn 0.5s ease-out backwards;
                    animation-delay: calc(var(--order) * 0.1s);
                }

                .review:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                    background: rgba(255, 255, 255, 0.2);
                }

                .review p {
                    color: #fff;
                    margin-bottom: 15px;
                    font-size: 16px;
                    line-height: 1.6;
                }

                form {
                    display: inline;
                    margin-right: 10px;
                }

                button {
                    padding: 12px 25px;
                    background: linear-gradient(45deg, #d32f2f, #b71c1c);
                    color: #fff;
                    border: none;
                    border-radius: 25px;
                    cursor: pointer;
                    font-weight: 600;
                    transition: all 0.3s ease;
                    box-shadow: 0 4px 15px rgba(211, 47, 47, 0.3);
                }

                button:hover {
                    background: linear-gradient(45deg, #b71c1c, #7f0000);
                    transform: translateY(-2px) scale(1.05);
                    box-shadow: 0 6px 20px rgba(211, 47, 47, 0.4);
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

                    .review {
                        padding: 15px;
                    }

                    button {
                        padding: 10px 20px;
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
                <h2>Admin Moderation Panel</h2>
                <c:forEach var="review" items="${reviews}" varStatus="loop">
                    <div class="review" style="--order: ${loop.count}">
                        <p>${review.displayReview()}</p>
                        <form action="/review/admin" method="post">
                            <input type="hidden" name="reviewId" value="${review.reviewId}">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit">
                                <i class="fas fa-trash"></i> Delete Review
                            </button>
                        </form>
                    </div>
                </c:forEach>
                <a href="/users/admin/dashboard" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Admin Dashboard
                </a>
            </div>
        </body>

        </html>