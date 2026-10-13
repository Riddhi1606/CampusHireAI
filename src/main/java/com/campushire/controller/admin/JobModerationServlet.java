package com.campushire.controller.admin;

import com.campushire.model.Job;
import com.campushire.service.AdminService;
import com.campushire.util.Validator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller for Job Moderation and Listing oversight.
 */
@WebServlet("/admin/jobs")
public class JobModerationServlet extends HttpServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Job> jobs = adminService.getAllJobs();
        req.setAttribute("jobs", jobs);
        req.getRequestDispatcher("/WEB-INF/views/admin/jobs.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int jobId = Validator.parseIntSafe(req.getParameter("jobId"), 0);
        String action = req.getParameter("action");

        if (jobId > 0 && action != null) {
            try {
                Job.Status status = Job.Status.valueOf(action.toUpperCase());
                adminService.updateJobStatus(jobId, status);
                req.getSession().setAttribute("flashSuccess", "Job status updated to " + status);
            } catch (Exception ignored) {}
        }

        resp.sendRedirect(req.getContextPath() + "/admin/jobs");
    }
}
