// Form validation with animations
function validateRegistrationForm() {
    const username = document.querySelector('input[name="username"]');
    const password = document.querySelector('input[name="password"]');
    const email = document.querySelector('input[name="email"]');
    const phone = document.querySelector('input[name="phone"]');
    let isValid = true;

    // Reset previous error states
    clearErrors();

    // Username validation
    if (username.value.length < 3) {
        showError(username, "Username must be at least 3 characters long");
        isValid = false;
    }

    // Password validation
    if (password.value.length < 6) {
        showError(password, "Password must be at least 6 characters long");
        isValid = false;
    }

    // Email validation
    if (!email.value.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
        showError(email, "Please enter a valid email address");
        isValid = false;
    }

    // Phone validation
    if (!phone.value.match(/^\d{10}$/)) {
        showError(phone, "Please enter a valid 10-digit phone number");
        isValid = false;
    }

    if (isValid) {
        // Show loading state and disable button
        const regButton = document.querySelector('.register-form button[type="submit"]');
        if (regButton) {
            regButton.innerHTML = '<span class="loading"></span> Processing...';
            regButton.disabled = true;
        }
        return true;
    }
    return false;
}

// Show error message with animation
function showError(input, message) {
    const formGroup = input.closest('.form-group') || input.parentElement;
    const errorDiv = document.createElement('div');
    errorDiv.className = 'error-message';
    errorDiv.textContent = message;

    formGroup.classList.add('error');
    formGroup.appendChild(errorDiv);

    // Add shake animation
    input.classList.add('shake');
    setTimeout(() => input.classList.remove('shake'), 500);
}

// Clear all error messages
function clearErrors() {
    document.querySelectorAll('.error-message').forEach(error => error.remove());
    document.querySelectorAll('.error').forEach(group => group.classList.remove('error'));
}

// Add smooth scrolling
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});

// Add hover effects to table rows
document.querySelectorAll('table tr').forEach(row => {
    row.addEventListener('mouseenter', function () {
        this.style.transform = 'scale(1.01)';
        this.style.transition = 'transform 0.3s ease';
    });

    row.addEventListener('mouseleave', function () {
        this.style.transform = 'scale(1)';
    });
});

// Add form input animations
document.querySelectorAll('input, select').forEach(input => {
    input.addEventListener('focus', function () {
        this.parentElement.classList.add('focused');
    });

    input.addEventListener('blur', function () {
        if (!this.value) {
            this.parentElement.classList.remove('focused');
        }
    });
});

// Add page load animation
document.addEventListener('DOMContentLoaded', function () {
    document.body.classList.add('loaded');
});

// Add confirmation dialog for delete actions
document.querySelectorAll('a[href*="delete"]').forEach(link => {
    link.addEventListener('click', function (e) {
        if (!confirm('Are you sure you want to delete this item?')) {
            e.preventDefault();
        }
    });
}); 