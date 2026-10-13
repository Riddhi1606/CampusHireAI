package com.campushire.controller.student;

import com.campushire.model.Project;
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
 * Controller for Student Portfolio Projects management.
 */
@WebServlet("/student/projects")
public class StudentProjectsServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        req.setAttribute("student", student);
        req.setAttribute("projects", student.getProjects());
        req.getRequestDispatcher("/WEB-INF/views/student/projects.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        String action = req.getParameter("action");
        if ("add".equalsIgnoreCase(action)) {
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String techStack = req.getParameter("techStack");
            String projectUrl = req.getParameter("projectUrl");
            String githubUrl = req.getParameter("githubUrl");

            if (Validator.isNotEmpty(title)) {
                Project p = new Project();
                p.setStudentId(student.getId());
                p.setTitle(title.trim());
                p.setDescription(description);
                p.setTechStack(techStack);
                p.setProjectUrl(projectUrl);
                p.setGithubUrl(githubUrl);

                studentService.addProject(p);
                session.setAttribute("flashSuccess", "Project added to your portfolio successfully!");
            }
        } else if ("delete".equalsIgnoreCase(action)) {
            int projectId = Validator.parseIntSafe(req.getParameter("projectId"), 0);
            if (projectId > 0) {
                studentService.removeProject(projectId, student.getId());
                session.setAttribute("flashSuccess", "Project deleted successfully.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/student/projects");
    }
}
