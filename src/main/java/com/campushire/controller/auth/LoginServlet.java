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
 * Handles user authentication and redirects to respective role dashboards.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            User user = (User) session.getAttribute("currentUser");
            redirectToDashboard(user, req, resp);
            return;
        }
        req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (!Validator.isValidEmail(email) || !Validator.isNotEmpty(password)) {
            req.setAttribute("errorMessage", "Please provide a valid email and password.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            return;
        }

        User user = authService.login(email, password);
        if (user != null) {
            // Invalidate old session and create new session for session fixation protection
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            HttpSession newSession = req.getSession(true);
            newSession.setAttribute("currentUser", user);

            redirectToDashboard(user, req, resp);
        } else {
            req.setAttribute("errorMessage", "Invalid credentials or account is deactivated.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
        }
    }

    private void redirectToDashboard(User user, HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String ctx = req.getContextPath();
        switch (user.getRole()) {
            case STUDENT -> resp.sendRedirect(ctx + "/student/dashboard");
            case RECRUITER -> resp.sendRedirect(ctx + "/recruiter/dashboard");
            case ADMIN -> resp.sendRedirect(ctx + "/admin/dashboard");
        }
    }
}
