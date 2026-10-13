package com.campushire.controller.student;

import com.campushire.dao.ApplicationDAO;
import com.campushire.dao.JobDAO;
import com.campushire.dao.SkillDAO;
import com.campushire.model.Job;
import com.campushire.model.MatchResult;
import com.campushire.model.Student;
import com.campushire.model.User;
import com.campushire.service.MatchingService;
import com.campushire.service.StudentService;
import com.campushire.util.Validator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller displaying transparent Explainable Skill-Matching breakdown
 * and in-depth Job Specifications.
 */
@WebServlet("/student/job-detail")
public class JobDetailServlet extends HttpServlet {

    private final JobDAO jobDAO = new JobDAO();
    private final SkillDAO skillDAO = new SkillDAO();
    private final StudentService studentService = new StudentService();
    private final MatchingService matchingService = new MatchingService();
    private final ApplicationDAO applicationDAO = new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int jobId = Validator.parseIntSafe(req.getParameter("id"), 0);
        Job job = jobDAO.findById(jobId);

        if (job == null) {
            resp.sendRedirect(req.getContextPath() + "/student/jobs?error=Job not found.");
            return;
        }

        job.setRequiredSkills(skillDAO.getJobSkills(jobId));

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        MatchResult matchResult = matchingService.calculateMatch(student, job);
        boolean hasApplied = applicationDAO.hasApplied(job.getId(), student.getId());

        req.setAttribute("job", job);
        req.setAttribute("student", student);
        req.setAttribute("matchResult", matchResult);
        req.setAttribute("hasApplied", hasApplied);

        req.getRequestDispatcher("/WEB-INF/views/student/job-detail.jsp").forward(req, resp);
    }
}
