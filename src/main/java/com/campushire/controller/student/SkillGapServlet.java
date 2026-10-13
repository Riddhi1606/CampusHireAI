package com.campushire.controller.student;

import com.campushire.dao.SkillDAO;
import com.campushire.model.Student;
import com.campushire.model.StudentSkill;
import com.campushire.model.User;
import com.campushire.service.StudentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

/**
 * Controller providing comprehensive Market Skill Gap Analysis
 * and personalized student upskilling roadmaps.
 */
@WebServlet("/student/skill-gap")
public class SkillGapServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();
    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        Map<String, Integer> marketDemands = skillDAO.getTopDemandedSkills(12);

        Set<String> studentSkillNames = new HashSet<>();
        if (student != null && student.getSkills() != null) {
            for (StudentSkill ss : student.getSkills()) {
                if (ss.getSkillName() != null) {
                    studentSkillNames.add(ss.getSkillName().trim().toLowerCase());
                }
            }
        }

        Map<String, Integer> acquiredSkills = new LinkedHashMap<>();
        Map<String, Integer> missingSkills = new LinkedHashMap<>();

        for (Map.Entry<String, Integer> entry : marketDemands.entrySet()) {
            String skillName = entry.getKey();
            if (studentSkillNames.contains(skillName.toLowerCase())) {
                acquiredSkills.put(skillName, entry.getValue());
            } else {
                missingSkills.put(skillName, entry.getValue());
            }
        }

        req.setAttribute("student", student);
        req.setAttribute("marketDemands", marketDemands);
        req.setAttribute("acquiredSkills", acquiredSkills);
        req.setAttribute("missingSkills", missingSkills);

        req.getRequestDispatcher("/WEB-INF/views/student/skill-gap.jsp").forward(req, resp);
    }
}
