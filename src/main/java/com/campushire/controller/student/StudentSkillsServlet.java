package com.campushire.controller.student;

import com.campushire.dao.SkillDAO;
import com.campushire.model.Skill;
import com.campushire.model.Student;
import com.campushire.model.StudentSkill;
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
 * Controller for Student Skills Management (add, update proficiency, remove).
 */
@WebServlet("/student/skills")
public class StudentSkillsServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();
    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        List<StudentSkill> studentSkills = skillDAO.getStudentSkills(student.getId());
        List<Skill> allSkills = skillDAO.findAll();

        req.setAttribute("student", student);
        req.setAttribute("studentSkills", studentSkills);
        req.setAttribute("allSkills", allSkills);
        req.getRequestDispatcher("/WEB-INF/views/student/skills.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        String action = req.getParameter("action");
        if ("add".equalsIgnoreCase(action)) {
            int skillId = Validator.parseIntSafe(req.getParameter("skillId"), 0);
            String profStr = req.getParameter("proficiency");
            StudentSkill.Proficiency prof = StudentSkill.Proficiency.INTERMEDIATE;
            if (profStr != null) {
                try {
                    prof = StudentSkill.Proficiency.valueOf(profStr.toUpperCase());
                } catch (IllegalArgumentException ignored) {}
            }

            if (skillId > 0) {
                studentService.addSkill(student.getId(), skillId, prof);
                session.setAttribute("flashSuccess", "Skill added to your profile successfully!");
            }
        } else if ("delete".equalsIgnoreCase(action)) {
            int skillId = Validator.parseIntSafe(req.getParameter("skillId"), 0);
            if (skillId > 0) {
                studentService.removeSkill(student.getId(), skillId);
                session.setAttribute("flashSuccess", "Skill removed from profile.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/student/skills");
    }
}
