package com.campushire.controller.student;

import com.campushire.model.Application;
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
 * Controller for tracking student's applied placements and lifecycle stages.
 */
@WebServlet("/student/applications")
public class MyApplicationsServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        List<Application> applications = studentService.getStudentApplications(student.getId());

        req.setAttribute("student", student);
        req.setAttribute("applications", applications);
        req.getRequestDispatcher("/WEB-INF/views/student/my-applications.jsp").forward(req, resp);
    }
}
