package com.campushire.controller.recruiter;

import com.campushire.model.Application;
import com.campushire.model.Company;
import com.campushire.model.Job;
import com.campushire.model.User;
import com.campushire.service.RecruiterService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Controller for Recruiter Dashboard displaying talent acquisition KPIs,
 * recent applicant inquiries, and active job postings.
 */
@WebServlet("/recruiter/dashboard")
public class RecruiterDashboardServlet extends HttpServlet {

    private final RecruiterService recruiterService = new RecruiterService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");

        Company company = recruiterService.getCompanyByRecruiterId(user.getId());
        if (company == null) {
            resp.sendRedirect(req.getContextPath() + "/recruiter/company-profile?msg=Please complete your company profile.");
            return;
        }

        List<Job> jobs = recruiterService.getRecruiterJobs(company.getId());
        List<Application> applicants = recruiterService.getAllApplicantsForRecruiter(user.getId());

        int activeJobsCount = 0;
        for (Job j : jobs) {
            if (j.getStatus() == Job.Status.ACTIVE) activeJobsCount++;
        }

        int shortlistedCount = 0;
        int interviewCount = 0;
        for (Application a : applicants) {
            if (a.getStatus() == Application.Status.SHORTLISTED) shortlistedCount++;
            if (a.getStatus() == Application.Status.INTERVIEW_SCHEDULED) interviewCount++;
        }

        req.setAttribute("company", company);
        req.setAttribute("jobsCount", jobs.size());
        req.setAttribute("activeJobsCount", activeJobsCount);
        req.setAttribute("applicantsCount", applicants.size());
        req.setAttribute("shortlistedCount", shortlistedCount);
        req.setAttribute("interviewCount", interviewCount);
        req.setAttribute("recentApplicants", applicants.subList(0, Math.min(6, applicants.size())));
        req.setAttribute("recentJobs", jobs.subList(0, Math.min(4, jobs.size())));

        req.getRequestDispatcher("/WEB-INF/views/recruiter/dashboard.jsp").forward(req, resp);
    }
}
