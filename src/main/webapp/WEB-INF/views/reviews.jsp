<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>My Reviews - Fitness Membership System</title>
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
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
            animation: fadeIn 0.5s ease-out;
        }

        h1 {
            color: #fff;
            font-size: 36px;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .reviews-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .review-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .review-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.3);
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .review-type {
            background: rgba(255, 255, 255, 0.2);
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: 500;
        }

        .review-content {
            margin-bottom: 15px;
            line-height: 1.6;
        }

        .review-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
            color: #e0e0e0;
        }

        .rating {
            color: #ffd700;
        }

        .rating i {
            margin-right: 2px;
        }

        .back-button {
            display: inline-block;
            padding: 12px 25px;
            background: linear-gradient(45deg, #388e3c, #2e7d32);
            color: #fff;
            text-decoration: none;
            border-radius: 25px;
            transition: all 0.3s ease;
            margin-top: 20px;
        }

        .back-button:hover {
            background: linear-gradient(45deg, #2e7d32, #1b5e20);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(46, 125, 50, 0.4);
        }

        .no-reviews {
            text-align: center;
            padding: 40px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            margin: 20px 0;
        }

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            h1 {
                font-size: 28px;
            }

            .reviews-grid {
                grid-template-columns: 1fr;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .review-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 15px;
        }

        .edit-button {
            display: inline-block;
            padding: 8px 15px;
            background: linear-gradient(45deg, #2196F3, #1976D2);
            color: #fff;
            text-decoration: none;
            border-radius: 20px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .edit-button:hover {
            background: linear-gradient(45deg, #1976D2, #1565C0);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(33, 150, 243, 0.3);
        }

        .edit-form {
            display: none;
            margin-top: 15px;
            padding: 15px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 10px;
        }

        .edit-form.active {
            display: block;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #e0e0e0;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.1);
            color: #000000;
        }

        .form-group textarea {
            height: 100px;
            resize: vertical;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .cancel-button {
            display: inline-block;
            padding: 8px 15px;
            background: linear-gradient(45deg, #757575, #616161);
            color: #fff;
            text-decoration: none;
            border-radius: 20px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .cancel-button:hover {
            background: linear-gradient(45deg, #616161, #424242);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(117, 117, 117, 0.3);
        }

        .submit-button {
            display: inline-block;
            padding: 8px 15px;
            background: linear-gradient(45deg, #4CAF50, #388E3C);
            color: #fff;
            text-decoration: none;
            border-radius: 20px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .submit-button:hover {
            background: linear-gradient(45deg, #388E3C, #2E7D32);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(76, 175, 80, 0.3);
        }

        .error-message {
            color: #ff4444;
            background: rgba(255, 68, 68, 0.1);
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }

        .success-message {
            color: #4CAF50;
            background: rgba(76, 175, 80, 0.1);
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <c:if test="${empty userId}">
        <script>
            window.location.href = '/users/login';
        </script>
    </c:if>

    <div class="container">
        <div class="header">
            <h1>My Reviews</h1>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="success-message">${message}</div>
        </c:if>

        <c:if test="${empty reviews}">
            <div class="no-reviews">
                <h3>You haven't submitted any reviews yet</h3>
                <a href="/review/submit" class="back-button" style="margin-top: 20px;">
                    <i class="fas fa-plus"></i> Write a Review
                </a>
            </div>
        </c:if>

        <div class="reviews-grid">
            <c:forEach var="review" items="${reviews}">
                <div class="review-card">
                    <div class="review-header">
                        <span class="review-type">${review.type}</span>
                        <div class="rating">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="fas fa-star${i <= review.rating ? '' : '-o'}"></i>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="review-content">
                        <p>${review.content}</p>
                    </div>
                    <div class="review-meta">
                        <span>
                            <c:if test="${review.type == 'Trainer'}">
                                Trainer: ${review.trainerName}
                            </c:if>
                            <c:if test="${review.type == 'Facility'}">
                                Area: ${review.facilityArea}
                            </c:if>
                        </span>
                        <span>
                            By: ${userName} on 
                            <fmt:parseDate value="${review.submissionDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                            <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                        </span>
                    </div>
                    <div class="review-actions">
                        <button class="edit-button" onclick="toggleEditForm('${review.reviewId}')">
                            <i class="fas fa-edit"></i> Edit
                        </button>
                    </div>
                    <form action="/review/update" method="post" class="edit-form" id="editForm${review.reviewId}">
                        <input type="hidden" name="reviewId" value="${review.reviewId}">
                        <input type="hidden" name="type" value="${review.type}">
                        
                        <div class="form-group">
                            <label for="content${review.reviewId}">Review Content:</label>
                            <textarea name="content" id="content${review.reviewId}" required>${review.content}</textarea>
                        </div>
                        
                        <div class="form-group">
                            <label for="rating${review.reviewId}">Rating:</label>
                            <select name="rating" id="rating${review.reviewId}" required>
                                <c:forEach begin="1" end="5" var="i">
                                    <option value="${i}" ${i == review.rating ? 'selected' : ''}>${i} Stars</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <c:if test="${review.type == 'Trainer'}">
                            <div class="form-group">
                                <label for="trainerName${review.reviewId}">Trainer Name:</label>
                                <input type="text" name="trainerName" id="trainerName${review.reviewId}" value="${review.trainerName}" required>
                            </div>
                        </c:if>
                        
                        <c:if test="${review.type == 'Facility'}">
                            <div class="form-group">
                                <label for="facilityArea${review.reviewId}">Facility Area:</label>
                                <input type="text" name="facilityArea" id="facilityArea${review.reviewId}" value="${review.facilityArea}" required>
                            </div>
                        </c:if>
                        
                        <div class="form-actions">
                            <button type="button" class="cancel-button" onclick="toggleEditForm('${review.reviewId}')">
                                Cancel
                            </button>
                            <button type="submit" class="submit-button">
                                Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </c:forEach>
        </div>

        <a href="/users/profile" class="back-button">
            <i class="fas fa-arrow-left"></i> Back to Profile
        </a>
    </div>

    <script>
        function toggleEditForm(reviewId) {
            const form = document.getElementById('editForm' + reviewId);
            form.classList.toggle('active');
        }
    </script>
</body>
</html>