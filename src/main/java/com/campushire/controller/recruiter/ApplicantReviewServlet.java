package com.campushire.controller.recruiter;

import com.campushire.model.*;
import com.campushire.service.RecruiterService;
import com.campushire.service.StudentService;
import com.campushire.util.Validator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

/**
 * Controller for reviewing applicants, viewing candidates' explainable match metrics,
 * and progressing hiring pipeline stages.
 */
@WebServlet("/recruiter/applicants")
public class ApplicantReviewServlet extends HttpServlet {

    private final RecruiterService recruiterService = new RecruiterService();
    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Company company = recruiterService.getCompanyByRecruiterId(user.getId());

        int jobId = Validator.parseIntSafe(req.getParameter("jobId"), 0);
        int viewAppId = Validator.parseIntSafe(req.getParameter("viewAppId"), 0);

        List<Job> companyJobs = recruiterService.getRecruiterJobs(company.getId());
        List<Application> applicants = (jobId > 0)
                ? recruiterService.getApplicantsForJob(jobId)
                : recruiterService.getAllApplicantsForRecruiter(user.getId());

        // Check if viewing a specific applicant detail
        if (viewAppId > 0) {
            Application viewApp = recruiterService.getApplicationById(viewAppId);
            if (viewApp != null) {
                Student student = studentService.getStudentById(viewApp.getStudentId());
                MatchResult matchResult = recruiterService.evaluateApplicant(viewApp.getStudentId(), viewApp.getJobId());
                req.setAttribute("viewApp", viewApp);
                req.setAttribute("viewStudent", student);
                req.setAttribute("viewMatchResult", matchResult);
            }
        }

        req.setAttribute("company", company);
        req.setAttribute("companyJobs", companyJobs);
        req.setAttribute("selectedJobId", jobId);
        req.setAttribute("applicants", applicants);

        req.getRequestDispatcher("/WEB-INF/views/recruiter/applicants.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int applicationId = Validator.parseIntSafe(req.getParameter("applicationId"), 0);
        String statusStr = req.getParameter("status");
        String recruiterNotes = req.getParameter("recruiterNotes");
        String interviewDateStr = req.getParameter("interviewDate");

        if (applicationId > 0 && statusStr != null) {
            try {
                Application.Status status = Application.Status.valueOf(statusStr.toUpperCase());
                Timestamp interviewDate = null;
                if (interviewDateStr != null && !interviewDateStr.trim().isEmpty()) {
                    // Expect format YYYY-MM-DDTHH:MM
                    String formatted = interviewDateStr.replace("T", " ") + ":00";
                    interviewDate = Timestamp.valueOf(formatted);
                }

                boolean updated = recruiterService.updateApplicationStatus(applicationId, status, recruiterNotes, interviewDate);
                if (updated) {
                    req.getSession().setAttribute("flashSuccess", "Applicant status updated to " + status + " successfully!");
                }
            } catch (Exception e) {
                req.getSession().setAttribute("flashError", "Failed to update status: " + e.getMessage());
            }
        }

        String returnJobId = req.getParameter("returnJobId");
        if (returnJobId != null && !returnJobId.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/recruiter/applicants?jobId=" + returnJobId);
        } else {
            resp.sendRedirect(req.getContextPath() + "/recruiter/applicants");
        }
    }
}
