<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <title>Edit Profile - Fitness Membership System</title>
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

                .profile-edit-wrapper {
                    background: rgba(255, 255, 255, 0.1);
                    backdrop-filter: blur(10px);
                    padding: 30px;
                    border-radius: 15px;
                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
                    max-width: 450px;
                    width: 100%;
                    animation: slideUp 0.5s ease-out;
                    transition: transform 0.3s ease;
                }

                h2 {
                    color: #fff;
                    margin-bottom: 20px;
                    font-weight: 600;
                    font-size: 28px;
                    text-align: center;
                    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
                    animation: bounceIn 1s ease-out;
                }

                form {
                    display: flex;
                    flex-direction: column;
                    gap: 15px;
                }

                label {
                    margin-bottom: 5px;
                    color: #fff;
                    font-weight: 500;
                }

                input,
                select {
                    width: 100%;
                    padding: 10px;
                    border: 2px solid rgba(255, 255, 255, 0.3);
                    border-radius: 5px;
                    background: rgba(255, 255, 255, 0.2);
                    color: #000000;
                    font-size: 14px;
                    outline: none;
                    transition: border-color 0.3s ease;
                }

                input:focus,
                select:focus {
                    border-color: #388e3c;
                }

                input::placeholder,
                select::placeholder {
                    color: #000000;
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

                button:hover {
                    background: linear-gradient(45deg, #2e7d32, #1b5e20);
                    transform: translateY(-2px) scale(1.05);
                    box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
                }

                @media (max-width: 480px) {
                    .profile-edit-wrapper {
                        padding: 20px;
                    }

                    h2 {
                        font-size: 24px;
                    }

                    input,
                    select,
                    button {
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
            <div class="profile-edit-wrapper">
                <h2>Edit Profile</h2>
                <form action="/users/edit" method="post">
                    <input type="hidden" name="id" value="${user.id}">
                    <div class="form-group">
                        <label>Username:</label>
                        <input type="text" name="username" value="${user.username}" required>
                    </div>
                    <div class="form-group">
                        <label>Password:</label>
                        <input type="password" name="password" value="${user.password}" required>
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="email" value="${user.email}" required>
                    </div>
                    <div class="form-group">
                        <label>Phone:</label>
                        <input type="text" name="phone" value="${user.phone}" required>
                    </div>
                    <div class="form-group">
                        <label>Membership Type:</label>
                        <select name="membershipType">
                            <option value="Regular" ${user.membershipType=='Regular' ? 'selected' : '' }>Regular
                            </option>
                            <option value="Premium" ${user.membershipType=='Premium' ? 'selected' : '' }>Premium
                            </option>
                        </select>
                    </div>
                    <button type="submit">Update</button>
                </form>
            </div>
        </body>

        </html>