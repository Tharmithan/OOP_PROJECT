<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <title>Make a Payment - Fitness Membership System</title>
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
                    justify-content: center;
                    align-items: center;
                    min-height: 100vh;
                    overflow-x: hidden;
                    animation: gradientShift 10s ease infinite;
                    padding: 20px;
                }

                .container {
                    max-width: 500px;
                    background: rgba(255, 255, 255, 0.1);
                    backdrop-filter: blur(10px);
                    padding: 30px;
                    border-radius: 15px;
                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
                    text-align: center;
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

                form {
                    display: flex;
                    flex-direction: column;
                    gap: 15px;
                }

                label {
                    text-align: left;
                    color: #fff;
                    font-weight: 500;
                }

                input {
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

                input:focus {
                    border-color: #388e3c;
                }

                input::placeholder {
                    color: #e0e0e0;
                    opacity: 0.7;
                }

                .payment-buttons {
                    display: flex;
                    flex-direction: column;
                    gap: 10px;
                }

                button {
                    padding: 12px;
                    background: linear-gradient(45deg, #388e3c, #2e7d32);
                    color: #fff;
                    border: none;
                    border-radius: 25px;
                    cursor: pointer;
                    font-weight: 600;
                    transition: all 0.3s ease;
                    animation: slideIn 0.5s ease-out backwards;
                    animation-delay: calc(var(--order) * 0.2s);
                }

                button i {
                    margin-right: 8px;
                }

                button:hover {
                    background: linear-gradient(45deg, #2e7d32, #1b5e20);
                    transform: translateY(-2px) scale(1.05);
                    box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
                }

                .message {
                    color: #388e3c;
                    margin-top: 15px;
                    background: rgba(255, 255, 255, 0.1);
                    padding: 5px 10px;
                    border-radius: 5px;
                    animation: fadeIn 0.5s ease-out;
                }

                .error {
                    color: #ff4444;
                    margin-top: 15px;
                    background: rgba(255, 255, 255, 0.1);
                    padding: 5px 10px;
                    border-radius: 5px;
                    animation: fadeIn 0.5s ease-out;
                }

                a {
                    display: inline-block;
                    margin-top: 20px;
                    padding: 10px 20px;
                    text-decoration: none;
                    color: #fff;
                    background: linear-gradient(45deg, #388e3c, #2e7d32);
                    border-radius: 25px;
                    transition: all 0.3s ease;
                    font-weight: 600;
                    animation: slideIn 0.5s ease-out backwards;
                    animation-delay: 0.6s;
                }

                a:hover {
                    background: linear-gradient(45deg, #2e7d32, #1b5e20);
                    transform: translateY(-2px) scale(1.05);
                    box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
                }

                @media (max-width: 480px) {
                    .container {
                        padding: 20px;
                        max-width: 100%;
                    }

                    h2 {
                        font-size: 24px;
                    }

                    input,
                    button,
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
                <h2>Make a Payment</h2>
                <c:if test="${not empty message}">
                    <div class="message">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>
                <form id="paymentForm" action="/users/card-details" method="get">
                    <input type="hidden" name="planId" value="${param.planId}">
                    <input type="hidden" name="userId" value="${param.userId}">
                    <label for="amount">Amount ($):</label>
                    <input type="number" id="amount" name="amount" step="0.01" required placeholder="Enter payment amount">
                    <input type="hidden" id="method" name="method" value="">
                    <div class="payment-buttons">
                        <button type="button" onclick="submitPayment('Credit Card')" style="--order: 1;">
                            <i class="fas fa-credit-card"></i> Pay with Credit Card
                        </button>
                        <button type="button" onclick="submitPayment('Debit Card')" style="--order: 2;">
                            <i class="fas fa-credit-card"></i> Pay with Debit Card
                        </button>
                    </div>
                </form>
                <a href="/users/profile/${user.id}">Back to Profile</a>
            </div>
            <script>
                function submitPayment(method) {
                    const amount = document.getElementById('amount').value;
                    if (!amount || amount <= 0) {
                        alert('Please enter a valid amount');
                        return;
                    }
                    document.getElementById('method').value = method;
                    document.getElementById('paymentForm').submit();
                }
            </script>
        </body>

        </html>