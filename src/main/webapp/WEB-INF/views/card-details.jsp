<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <title>Card Details - Fitness Membership System</title>
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

                button {
                    padding: 12px;
                    background: linear-gradient(45deg, #388e3c, #2e7d32);
                    color: #fff;
                    border: none;
                    border-radius: 25px;
                    cursor: pointer;
                    font-weight: 600;
                    transition: all 0.3s ease;
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
                    color: #ff4444;
                    margin-top: 15px;
                    background: rgba(255, 255, 255, 0.1);
                    padding: 5px 10px;
                    border-radius: 5px;
                    animation: fadeIn 0.5s ease-out;
                }

                a {
                    display: inline-block;
                    margin-top: 15px;
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
            </style>
        </head>

        <body>
            <div class="container">
                <h2>Enter Card Details</h2>
                <c:if test="${not empty error}">
                    <div class="message">${error}</div>
                </c:if>
                <form action="/users/process-card-payment" method="post">
                    <input type="hidden" name="amount" value="${param.amount}">
                    <input type="hidden" name="method" value="${param.method}">
                    <input type="hidden" name="planId" value="${param.planId}">
                    <input type="hidden" name="userId" value="${param.userId}">
                    <label for="cardNumber">Card Number:</label>
                    <input type="text" id="cardNumber" name="cardNumber" required placeholder="1234 5678 9012 3456"
                        pattern="\d{16}" title="Card number must be 16 digits">
                    <label for="expiryDate">Expiry Date (MM/YY):</label>
                    <input type="text" id="expiryDate" name="expiryDate" required placeholder="MM/YY"
                        pattern="(0[1-9]|1[0-2])\/\d{2}" title="Format: MM/YY">
                    <label for="cvv">CVV:</label>
                    <input type="text" id="cvv" name="cvv" required placeholder="123" pattern="\d{3}"
                        title="CVV must be 3 digits">
                    <button type="submit"><i class="fas fa-credit-card"></i> Pay Now</button>
                </form>
                <a href="/users/payment"><i class="fas fa-arrow-left"></i> Back to Payment Options</a>
            </div>
            <script>
                document.querySelector("form").addEventListener("submit", function (event) {
                    const cardNumber = document.getElementById("cardNumber").value;
                    const expiryDate = document.getElementById("expiryDate").value;
                    const cvv = document.getElementById("cvv").value;

                    if (!/^\d{16}$/.test(cardNumber)) {
                        event.preventDefault();
                        alert("Please enter a valid 16-digit card number.");
                        return;
                    }

                    const expiryMatch = expiryDate.match(/^(0[1-9]|1[0-2])\/(\d{2})$/);
                    if (!expiryMatch) {
                        event.preventDefault();
                        alert("Please enter a valid expiry date in MM/YY format.");
                        return;
                    }
                    const month = parseInt(expiryMatch[1], 10);
                    const year = parseInt(expiryMatch[2], 10) + 2000;
                    const currentDate = new Date();
                    const expiry = new Date(year, month - 1);
                    if (expiry < currentDate) {
                        event.preventDefault();
                        alert("The card has expired.");
                        return;
                    }

                    if (!/^\d{3}$/.test(cvv)) {
                        event.preventDefault();
                        alert("Please enter a valid 3-digit CVV.");
                        return;
                    }
                });
            </script>
        </body>

        </html>