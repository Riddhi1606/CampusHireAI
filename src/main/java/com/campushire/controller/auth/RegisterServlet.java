package com.campushire.controller.auth;

import com.campushire.model.User;
import com.campushire.service.AuthService;
import com.campushire.util.Validator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Handles user self-registration for Students and Recruiters.
 * System security rule: ADMIN role creation via public registration is strictly blocked.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String roleStr = req.getParameter("role");
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (!Validator.isNotEmpty(fullName) || !Validator.isValidEmail(email) || !Validator.isNotEmpty(password)) {
            req.setAttribute("errorMessage", "All mandatory fields must be filled with valid data.");
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("errorMessage", "Passwords do not match.");
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
            return;
        }

        if (password.length() < 6) {
            req.setAttribute("errorMessage", "Password must be at least 6 characters.");
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
            return;
        }

        User registeredUser = null;
        if ("RECRUITER".equalsIgnoreCase(roleStr)) {
            String companyName = req.getParameter("companyName");
            String industry = req.getParameter("industry");
            String location = req.getParameter("location");
            registeredUser = authService.registerRecruiter(fullName, email, password, companyName, industry, location);
        } else {
            // Default to STUDENT role
            String collegeName = req.getParameter("collegeName");
            String branch = req.getParameter("branch");
            double cgpa = Validator.parseDoubleSafe(req.getParameter("cgpa"), 0.0);
            int gradYear = Validator.parseIntSafe(req.getParameter("graduationYear"), 2026);
            registeredUser = authService.registerStudent(fullName, email, password, collegeName, branch, cgpa, gradYear);
        }

        if (registeredUser != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("currentUser", registeredUser);
            session.setAttribute("flashSuccess", "Registration successful! Welcome to CampusHire AI.");

            String ctx = req.getContextPath();
            if (registeredUser.getRole() == User.Role.RECRUITER) {
                resp.sendRedirect(ctx + "/recruiter/dashboard");
            } else {
                resp.sendRedirect(ctx + "/student/dashboard");
            }
        } else {
            req.setAttribute("errorMessage", "Registration failed. An account with this email may already exist.");
            req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
        }
    }
}
