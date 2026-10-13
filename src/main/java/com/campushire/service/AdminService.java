package com.campushire.service;

import com.campushire.dao.*;
import com.campushire.model.*;

import java.util.*;

/**
 * System Administration Service for platform governance, moderation,
 * user management, and aggregate analytics.
 */
public class AdminService {

    private final UserDAO userDAO = new UserDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final JobDAO jobDAO = new JobDAO();
    private final ApplicationDAO applicationDAO = new ApplicationDAO();
    private final SkillDAO skillDAO = new SkillDAO();

    public Map<String, Object> getPlatformStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalStudents", studentDAO.countAll());
        stats.put("totalRecruiters", userDAO.countUsersByRole(User.Role.RECRUITER));
        stats.put("activeJobs", jobDAO.countActiveJobs());
        stats.put("totalJobs", jobDAO.countTotalJobs());
        stats.put("totalApplications", applicationDAO.countTotalApplications());
        stats.put("topSkills", skillDAO.getTopDemandedSkills(8));
        return stats;
    }

    public List<User> getAllUsers() {
        return userDAO.findAllUsers();
    }

    public boolean toggleUserStatus(int userId, boolean isActive) {
        return userDAO.toggleActiveStatus(userId, isActive);
    }

    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }

    public List<Job> getAllJobs() {
        List<Job> jobs = jobDAO.findAllJobs();
        for (Job j : jobs) {
            j.setRequiredSkills(skillDAO.getJobSkills(j.getId()));
        }
        return jobs;
    }

    public boolean updateJobStatus(int jobId, Job.Status status) {
        return jobDAO.updateStatus(jobId, status);
    }

    public List<Skill> getAllSkills() {
        return skillDAO.findAll();
    }

    public int addSkill(Skill skill) {
        return skillDAO.createSkill(skill);
    }

    public boolean removeSkill(int skillId) {
        return skillDAO.deleteSkill(skillId);
    }

    public Map<String, Integer> getSkillDemand() {
        return skillDAO.getTopDemandedSkills(10);
    }
}
