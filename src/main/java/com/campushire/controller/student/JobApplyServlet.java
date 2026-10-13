package com.campushire.controller.student;

import com.campushire.model.Student;
import com.campushire.model.User;
import com.campushire.service.StudentService;
import com.campushire.util.Validator;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller handling job application submission with duplicate prevention.
 */
@WebServlet("/student/apply")
public class JobApplyServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        int jobId = Validator.parseIntSafe(req.getParameter("jobId"), 0);
        String coverLetter = req.getParameter("coverLetter");

        if (jobId > 0 && student != null) {
            boolean applied = studentService.applyForJob(jobId, student.getId(), coverLetter);
            if (applied) {
                session.setAttribute("flashSuccess", "Your application has been submitted successfully!");
                resp.sendRedirect(req.getContextPath() + "/student/applications");
                return;
            } else {
                session.setAttribute("flashError", "You have already applied for this opening or an error occurred.");
            }
        } else {
            session.setAttribute("flashError", "Invalid application request.");
        }

        resp.sendRedirect(req.getContextPath() + "/student/job-detail?id=" + jobId);
    }
}
