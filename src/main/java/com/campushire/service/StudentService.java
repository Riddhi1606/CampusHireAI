package com.campushire.service;

import com.campushire.dao.*;
import com.campushire.model.*;

import java.util.Comparator;
import java.util.List;

/**
 * Business service for Student operations, portfolio management,
 * and matched job discovery.
 */
public class StudentService {

    private final StudentDAO studentDAO = new StudentDAO();
    private final SkillDAO skillDAO = new SkillDAO();
    private final ProjectDAO projectDAO = new ProjectDAO();
    private final CertificationDAO certificationDAO = new CertificationDAO();
    private final JobDAO jobDAO = new JobDAO();
    private final ApplicationDAO applicationDAO = new ApplicationDAO();
    private final MatchingService matchingService = new MatchingService();

    public Student getStudentByUserId(int userId) {
        Student s = studentDAO.findByUserId(userId);
        if (s != null) {
            populateStudentRelations(s);
        }
        return s;
    }

    public Student getStudentById(int id) {
        Student s = studentDAO.findById(id);
        if (s != null) {
            populateStudentRelations(s);
        }
        return s;
    }

    private void populateStudentRelations(Student s) {
        s.setSkills(skillDAO.getStudentSkills(s.getId()));
        s.setProjects(projectDAO.findByStudentId(s.getId()));
        s.setCertifications(certificationDAO.findByStudentId(s.getId()));
    }

    public boolean updateProfile(Student s) {
        return studentDAO.updateProfile(s);
    }

    public boolean addSkill(int studentId, int skillId, StudentSkill.Proficiency proficiency) {
        return skillDAO.addStudentSkill(studentId, skillId, proficiency);
    }

    public boolean removeSkill(int studentId, int skillId) {
        return skillDAO.deleteStudentSkill(studentId, skillId);
    }

    public int addProject(Project p) {
        return projectDAO.createProject(p);
    }

    public boolean removeProject(int projectId, int studentId) {
        return projectDAO.deleteProject(projectId, studentId);
    }

    public int addCertification(Certification c) {
        return certificationDAO.createCertification(c);
    }

    public boolean removeCertification(int certId, int studentId) {
        return certificationDAO.deleteCertification(certId, studentId);
    }

    public List<Job> getMatchedJobs(Student student, String keyword, String location, String jobType, Double minCgpa) {
        List<Job> jobs = jobDAO.findActiveJobs(keyword, location, jobType, minCgpa);
        for (Job job : jobs) {
            job.setRequiredSkills(skillDAO.getJobSkills(job.getId()));
            if (student != null) {
                MatchResult mr = matchingService.calculateMatch(student, job);
                job.setMatchResult(mr);
                job.setHasApplied(applicationDAO.hasApplied(job.getId(), student.getId()));
                matchingService.saveRecommendation(student.getId(), job.getId(), mr);
            }
        }

        // Sort by match score descending if student is available
        if (student != null) {
            jobs.sort((j1, j2) -> {
                double s1 = (j1.getMatchResult() != null) ? j1.getMatchResult().getOverallScore() : 0;
                double s2 = (j2.getMatchResult() != null) ? j2.getMatchResult().getOverallScore() : 0;
                return Double.compare(s2, s1);
            });
        }
        return jobs;
    }

    public boolean applyForJob(int jobId, int studentId, String coverLetter) {
        if (applicationDAO.hasApplied(jobId, studentId)) {
            return false;
        }

        Student student = getStudentById(studentId);
        Job job = jobDAO.findById(jobId);
        if (student == null || job == null) return false;

        job.setRequiredSkills(skillDAO.getJobSkills(jobId));
        MatchResult mr = matchingService.calculateMatch(student, job);

        Application app = new Application();
        app.setJobId(jobId);
        app.setStudentId(studentId);
        app.setMatchScore(mr.getOverallScore());
        app.setStatus(Application.Status.APPLIED);
        app.setCoverLetter(coverLetter != null ? coverLetter.trim() : "");

        int id = applicationDAO.apply(app);
        return id > 0;
    }

    public List<Application> getStudentApplications(int studentId) {
        return applicationDAO.findByStudentId(studentId);
    }
}
