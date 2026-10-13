package com.campushire.controller.recruiter;

import com.campushire.model.Company;
import com.campushire.model.Job;
import com.campushire.model.User;
import com.campushire.service.RecruiterService;
import com.campushire.util.Validator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Controller for managing, toggling status, and deleting company job postings.
 */
@WebServlet("/recruiter/jobs")
public class ManageJobsServlet extends HttpServlet {

    private final RecruiterService recruiterService = new RecruiterService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Company company = recruiterService.getCompanyByRecruiterId(user.getId());

        List<Job> jobs = recruiterService.getRecruiterJobs(company.getId());
        req.setAttribute("company", company);
        req.setAttribute("jobs", jobs);
        req.getRequestDispatcher("/WEB-INF/views/recruiter/manage-jobs.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        int jobId = Validator.parseIntSafe(req.getParameter("jobId"), 0);

        if (jobId > 0) {
            if ("close".equalsIgnoreCase(action)) {
                recruiterService.closeJob(jobId);
                req.getSession().setAttribute("flashSuccess", "Job posting closed successfully.");
            } else if ("activate".equalsIgnoreCase(action)) {
                recruiterService.activateJob(jobId);
                req.getSession().setAttribute("flashSuccess", "Job posting activated successfully.");
            } else if ("delete".equalsIgnoreCase(action)) {
                recruiterService.deleteJob(jobId);
                req.getSession().setAttribute("flashSuccess", "Job posting deleted.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/recruiter/jobs");
    }
}
