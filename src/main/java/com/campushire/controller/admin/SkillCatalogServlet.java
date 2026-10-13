package com.campushire.controller.admin;

import com.campushire.model.Skill;
import com.campushire.service.AdminService;
import com.campushire.util.Validator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller for Master Skills Catalog curation and taxonomy.
 */
@WebServlet("/admin/skills")
public class SkillCatalogServlet extends HttpServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Skill> skills = adminService.getAllSkills();
        req.setAttribute("skills", skills);
        req.getRequestDispatcher("/WEB-INF/views/admin/skills.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            String name = req.getParameter("name");
            String category = req.getParameter("category");
            if (Validator.isNotEmpty(name)) {
                Skill skill = new Skill();
                skill.setName(name.trim());
                skill.setCategory(Validator.isNotEmpty(category) ? category.trim() : "General");
                adminService.addSkill(skill);
                req.getSession().setAttribute("flashSuccess", "Skill added to master catalog.");
            }
        } else if ("delete".equalsIgnoreCase(action)) {
            int skillId = Validator.parseIntSafe(req.getParameter("skillId"), 0);
            if (skillId > 0) {
                adminService.removeSkill(skillId);
                req.getSession().setAttribute("flashSuccess", "Skill deleted from catalog.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/admin/skills");
    }
}
