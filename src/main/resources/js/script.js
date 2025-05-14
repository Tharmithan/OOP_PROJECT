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
        // Show loading state
        const submitButton = document.querySelector('button[type="submit"]');
        submitButton.innerHTML = '<span class="loading"></span> Processing...';
        submitButton.disabled = true;

        // Allow form submission
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

    // Initialize all forms
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function (e) {
            const submitButton = this.querySelector('button[type="submit"]');
            if (submitButton && !submitButton.disabled) {
                submitButton.innerHTML = '<span class="loading"></span> Processing...';
                submitButton.disabled = true;
            }
        });
    });
});

// Add confirmation dialog for delete actions
document.querySelectorAll('a[href*="delete"]').forEach(link => {
    link.addEventListener('click', function (e) {
        if (!confirm('Are you sure you want to delete this item?')) {
            e.preventDefault();
        }
    });
});

function validateRegistrationForm() {
    const username = document.querySelector('input[name="username"]').value;
    const password = document.querySelector('input[name="password"]').value;
    const email = document.querySelector('input[name="email"]').value;
    const phone = document.querySelector('input[name="phone"]').value;

    if (username.length < 3) {
        alert("Username must be at least 3 characters long.");
        return false;
    }
    if (password.length < 6) {
        alert("Password must be at least 6 characters long.");
        return false;
    }
    if (!email.includes('@')) {
        alert("Please enter a valid email address.");
        return false;
    }
    if (phone.length < 10) {
        alert("Please enter a valid phone number.");
        return false;
    }
    return true;
}

function validateUpgradeForm() {
    const userId = document.querySelector('input[name="userId"]').value;
    if (userId.length < 1) {
        alert("Please enter a valid User ID.");
        return false;
    }
    return true;
}

function validateRegistrationForm() {
    const username = document.querySelector('input[name="username"]').value;
    const password = document.querySelector('input[name="password"]').value;
    const email = document.querySelector('input[name="email"]').value;
    const phone = document.querySelector('input[name="phone"]').value;

    if (username.length < 3) {
        alert("Username must be at least 3 characters long.");
        return false;
    }
    if (password.length < 6) {
        alert("Password must be at least 6 characters long.");
        return false;
    }
    if (!email.includes('@')) {
        alert("Please enter a valid email address.");
        return false;
    }
    if (phone.length < 10) {
        alert("Please enter a valid phone number.");
        return false;
    }
    return true;
}

function validateUpgradeForm() {
    const userId = document.querySelector('input[name="userId"]').value;
    if (userId.length < 1) {
        alert("Please enter a valid User ID.");
        return false;
    }
    return true;
}

function validateBookingForm() {
    const userId = document.querySelector('input[name="userId"]').value;
    const sessionTime = document.querySelector('input[name="sessionTime"]').value;
    if (userId.length < 1) {
        alert("Please enter a valid User ID.");
        return false;
    }
    if (!sessionTime) {
        alert("Please select a valid session time.");
        return false;
    }
    return true;
}