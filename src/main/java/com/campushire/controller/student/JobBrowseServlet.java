package com.campushire.controller.student;

import com.campushire.model.Job;
import com.campushire.model.Student;
import com.campushire.model.User;
import com.campushire.service.StudentService;
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
 * Controller for Job Discovery, Search, and Live Compatibility Matching.
 */
@WebServlet("/student/jobs")
public class JobBrowseServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        String keyword = req.getParameter("keyword");
        String location = req.getParameter("location");
        String jobType = req.getParameter("jobType");
        String minCgpaStr = req.getParameter("minCgpa");
        Double minCgpa = (minCgpaStr != null && !minCgpaStr.isEmpty()) ? Validator.parseDoubleSafe(minCgpaStr, 0.0) : null;

        List<Job> matchedJobs = studentService.getMatchedJobs(student, keyword, location, jobType, minCgpa);

        req.setAttribute("student", student);
        req.setAttribute("jobs", matchedJobs);
        req.setAttribute("keyword", keyword);
        req.setAttribute("location", location);
        req.setAttribute("jobType", jobType);
        req.setAttribute("minCgpa", minCgpaStr);

        req.getRequestDispatcher("/WEB-INF/views/student/jobs.jsp").forward(req, resp);
    }
}
