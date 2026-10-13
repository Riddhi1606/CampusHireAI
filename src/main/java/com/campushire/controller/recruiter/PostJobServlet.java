package com.campushire.controller.recruiter;

import com.campushire.dao.SkillDAO;
import com.campushire.model.Company;
import com.campushire.model.Job;
import com.campushire.model.JobSkill;
import com.campushire.model.Skill;
import com.campushire.model.User;
import com.campushire.service.RecruiterService;
import com.campushire.util.DateUtil;
import com.campushire.util.Validator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

/**
 * Controller for publishing new campus job postings and setting required skill weightages.
 */
@WebServlet("/recruiter/post-job")
public class PostJobServlet extends HttpServlet {

    private final RecruiterService recruiterService = new RecruiterService();
    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Company company = recruiterService.getCompanyByRecruiterId(user.getId());

        int jobId = Validator.parseIntSafe(req.getParameter("id"), 0);
        Job job = null;
        Set<Integer> mandatorySkillIds = new HashSet<>();
        Set<Integer> preferredSkillIds = new HashSet<>();

        if (jobId > 0) {
            job = recruiterService.getJobById(jobId);
            if (job != null && job.getRequiredSkills() != null) {
                for (JobSkill js : job.getRequiredSkills()) {
                    if (js.isMandatory()) mandatorySkillIds.add(js.getSkillId());
                    else preferredSkillIds.add(js.getSkillId());
                }
            }
        }

        List<Skill> allSkills = skillDAO.findAll();

        req.setAttribute("company", company);
        req.setAttribute("job", job);
        req.setAttribute("allSkills", allSkills);
        req.setAttribute("mandatorySkillIds", mandatorySkillIds);
        req.setAttribute("preferredSkillIds", preferredSkillIds);

        req.getRequestDispatcher("/WEB-INF/views/recruiter/post-job.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Company company = recruiterService.getCompanyByRecruiterId(user.getId());

        int jobId = Validator.parseIntSafe(req.getParameter("jobId"), 0);
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String department = req.getParameter("department");
        String jobTypeStr = req.getParameter("jobType");
        String location = req.getParameter("location");
        String packageLpa = req.getParameter("packageLpa");
        double minCgpa = Validator.parseDoubleSafe(req.getParameter("minCgpa"), 0.0);
        String eligibleBranches = req.getParameter("eligibleBranches");
        int openings = Validator.parseIntSafe(req.getParameter("openings"), 1);
        String deadlineStr = req.getParameter("deadline");

        Job job = (jobId > 0) ? recruiterService.getJobById(jobId) : new Job();
        job.setCompanyId(company.getId());
        job.setTitle(title);
        job.setDescription(description);
        job.setDepartment(department);
        if (jobTypeStr != null) {
            try { job.setJobType(Job.JobType.valueOf(jobTypeStr.toUpperCase())); } catch (Exception ignored) {}
        }
        job.setLocation(location);
        job.setPackageLpa(packageLpa);
        job.setMinCgpa(minCgpa);
        job.setEligibleBranches(Validator.isNotEmpty(eligibleBranches) ? eligibleBranches : "All");
        job.setOpenings(openings);
        job.setDeadline(DateUtil.parseSqlDate(deadlineStr));

        // Parse skills
        String[] mandatoryArr = req.getParameterValues("mandatorySkills");
        String[] preferredArr = req.getParameterValues("preferredSkills");

        List<Integer> mandatoryIds = new ArrayList<>();
        if (mandatoryArr != null) {
            for (String s : mandatoryArr) {
                int id = Validator.parseIntSafe(s, 0);
                if (id > 0) mandatoryIds.add(id);
            }
        }

        List<Integer> preferredIds = new ArrayList<>();
        if (preferredArr != null) {
            for (String s : preferredArr) {
                int id = Validator.parseIntSafe(s, 0);
                if (id > 0 && !mandatoryIds.contains(id)) preferredIds.add(id);
            }
        }

        if (jobId > 0) {
            job.setId(jobId);
            recruiterService.updateJob(job, mandatoryIds, preferredIds);
            session.setAttribute("flashSuccess", "Job posting updated successfully!");
        } else {
            recruiterService.postJob(job, mandatoryIds, preferredIds);
            session.setAttribute("flashSuccess", "New job posted successfully!");
        }

        resp.sendRedirect(req.getContextPath() + "/recruiter/jobs");
    }
}
