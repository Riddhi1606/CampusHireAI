/**
 * CampusHire AI Front-end Scripts
 */
document.addEventListener('DOMContentLoaded', function () {
    // Enable Bootstrap tooltips and popovers
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Auto-dismiss alert banners after 5 seconds
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(function (alert) {
        setTimeout(function () {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 5000);
    });
});

/**
 * 1-Click quick fill for evaluator & teacher demo testing
 */
function fillDemoLogin(role) {
    const emailField = document.getElementById('loginEmail');
    const passField = document.getElementById('loginPassword');
    if (!emailField || !passField) return;

    if (role === 'student') {
        emailField.value = 'riddhi.sharma@college.edu';
        passField.value = 'student123';
    } else if (role === 'recruiter') {
        emailField.value = 'recruiter@google.com';
        passField.value = 'recruiter123';
    } else if (role === 'admin') {
        emailField.value = 'admin@campushire.ai';
        passField.value = 'admin123';
    }
}
