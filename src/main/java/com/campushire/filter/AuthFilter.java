package com.campushire.filter;

import com.campushire.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Role-Based Access Control (RBAC) Security Filter.
 * Protects paths:
 * /student/* -> STUDENT role required
 * /recruiter/* -> RECRUITER role required
 * /admin/* -> ADMIN role required
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        // Permit static assets and public routes
        if (path.startsWith("/assets/") || path.startsWith("/css/") || path.startsWith("/js/")
                || path.startsWith("/images/") || path.equals("/") || path.equals("/index.jsp")
                || path.equals("/login") || path.equals("/register") || path.equals("/logout")
                || path.startsWith("/auth/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        // Check protected student endpoints
        if (path.startsWith("/student/")) {
            if (user == null) {
                res.sendRedirect(contextPath + "/login?error=Please login to access student portal");
                return;
            }
            if (user.getRole() != User.Role.STUDENT) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Student permissions required.");
                return;
            }
        }

        // Check protected recruiter endpoints
        if (path.startsWith("/recruiter/")) {
            if (user == null) {
                res.sendRedirect(contextPath + "/login?error=Please login to access recruiter portal");
                return;
            }
            if (user.getRole() != User.Role.RECRUITER) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Recruiter permissions required.");
                return;
            }
        }

        // Check protected admin endpoints
        if (path.startsWith("/admin/")) {
            if (user == null) {
                res.sendRedirect(contextPath + "/login?error=Please login to access administrator portal");
                return;
            }
            if (user.getRole() != User.Role.ADMIN) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Administrator permissions required.");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
