package com.campushire.controller.student;

import com.campushire.model.Application;
import com.campushire.model.Job;
import com.campushire.model.Student;
import com.campushire.model.User;
import com.campushire.service.StudentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Controller for Student Dashboard displaying profile overview,
 * application metrics, and top recommended matching jobs.
 */
@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");

        Student student = studentService.getStudentByUserId(user.getId());
        if (student == null) {
            resp.sendRedirect(req.getContextPath() + "/student/profile?msg=Please initialize your academic profile.");
            return;
        }

        List<Application> applications = studentService.getStudentApplications(student.getId());

        int appliedCount = applications.size();
        int shortlistedCount = 0;
        int offeredCount = 0;
        for (Application app : applications) {
            if (app.getStatus() == Application.Status.SHORTLISTED || app.getStatus() == Application.Status.INTERVIEW_SCHEDULED) {
                shortlistedCount++;
            } else if (app.getStatus() == Application.Status.OFFERED) {
                offeredCount++;
            }
        }

        // Fetch top matched jobs
        List<Job> matchedJobs = studentService.getMatchedJobs(student, null, null, null, null);
        List<Job> topRecommendations = matchedJobs.subList(0, Math.min(4, matchedJobs.size()));

        req.setAttribute("student", student);
        req.setAttribute("appliedCount", appliedCount);
        req.setAttribute("shortlistedCount", shortlistedCount);
        req.setAttribute("offeredCount", offeredCount);
        req.setAttribute("recentApplications", applications.subList(0, Math.min(5, applications.size())));
        req.setAttribute("recommendedJobs", topRecommendations);

        req.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(req, resp);
    }
}
