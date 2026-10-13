package com.campushire.controller.admin;

import com.campushire.model.Job;
import com.campushire.model.User;
import com.campushire.service.AdminService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Controller for Administrator Dashboard featuring platform KPIs and metrics.
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> stats = adminService.getPlatformStats();
        List<User> users = adminService.getAllUsers();
        List<Job> jobs = adminService.getAllJobs();

        req.setAttribute("stats", stats);
        req.setAttribute("recentUsers", users.subList(0, Math.min(6, users.size())));
        req.setAttribute("recentJobs", jobs.subList(0, Math.min(5, jobs.size())));

        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
    }
}
