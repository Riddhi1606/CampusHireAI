package com.campushire.controller.student;

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

/**
 * Controller for Student Academic & Personal Profile CRUD.
 */
@WebServlet("/student/profile")
public class StudentProfileServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");

        Student student = studentService.getStudentByUserId(user.getId());
        req.setAttribute("student", student);
        req.getRequestDispatcher("/WEB-INF/views/student/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        if (student == null) {
            resp.sendRedirect(req.getContextPath() + "/student/dashboard");
            return;
        }

        student.setCollegeName(req.getParameter("collegeName"));
        student.setDegree(req.getParameter("degree"));
        student.setBranch(req.getParameter("branch"));
        student.setCgpa(Validator.parseDoubleSafe(req.getParameter("cgpa"), 0.0));
        student.setGraduationYear(Validator.parseIntSafe(req.getParameter("graduationYear"), 2026));
        student.setRollNumber(req.getParameter("rollNumber"));
        student.setPhone(req.getParameter("phone"));
        student.setBio(req.getParameter("bio"));
        student.setResumeUrl(req.getParameter("resumeUrl"));
        student.setGithubUrl(req.getParameter("githubUrl"));
        student.setLinkedinUrl(req.getParameter("linkedinUrl"));

        boolean success = studentService.updateProfile(student);
        if (success) {
            req.getSession().setAttribute("flashSuccess", "Profile updated successfully!");
        } else {
            req.getSession().setAttribute("flashError", "Failed to update profile. Please verify your inputs.");
        }
        resp.sendRedirect(req.getContextPath() + "/student/profile");
    }
}
