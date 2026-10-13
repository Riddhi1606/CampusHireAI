package com.campushire.service;

import com.campushire.dao.*;
import com.campushire.model.*;

import java.sql.Timestamp;
import java.util.List;

/**
 * Recruiter Business Service handling company profiles, job postings,
 * skill requirements, and candidate evaluations.
 */
public class RecruiterService {

    private final CompanyDAO companyDAO = new CompanyDAO();
    private final JobDAO jobDAO = new JobDAO();
    private final SkillDAO skillDAO = new SkillDAO();
    private final ApplicationDAO applicationDAO = new ApplicationDAO();
    private final StudentService studentService = new StudentService();
    private final MatchingService matchingService = new MatchingService();

    public Company getCompanyByRecruiterId(int recruiterId) {
        return companyDAO.findByRecruiterId(recruiterId);
    }

    public boolean updateCompanyProfile(Company company) {
        return companyDAO.updateCompany(company);
    }

    public List<Job> getRecruiterJobs(int companyId) {
        List<Job> jobs = jobDAO.findByCompanyId(companyId);
        for (Job j : jobs) {
            j.setRequiredSkills(skillDAO.getJobSkills(j.getId()));
        }
        return jobs;
    }

    public Job getJobById(int jobId) {
        Job job = jobDAO.findById(jobId);
        if (job != null) {
            job.setRequiredSkills(skillDAO.getJobSkills(jobId));
        }
        return job;
    }

    public int postJob(Job job, List<Integer> mandatorySkillIds, List<Integer> preferredSkillIds) {
        int jobId = jobDAO.createJob(job);
        if (jobId > 0) {
            saveJobSkills(jobId, mandatorySkillIds, preferredSkillIds);
            return jobId;
        }
        return -1;
    }

    public boolean updateJob(Job job, List<Integer> mandatorySkillIds, List<Integer> preferredSkillIds) {
        boolean updated = jobDAO.updateJob(job);
        if (updated) {
            skillDAO.deleteJobSkills(job.getId());
            saveJobSkills(job.getId(), mandatorySkillIds, preferredSkillIds);
            return true;
        }
        return false;
    }

    private void saveJobSkills(int jobId, List<Integer> mandatorySkillIds, List<Integer> preferredSkillIds) {
        if (mandatorySkillIds != null) {
            for (Integer sid : mandatorySkillIds) {
                if (sid != null) skillDAO.addJobSkill(jobId, sid, true);
            }
        }
        if (preferredSkillIds != null) {
            for (Integer sid : preferredSkillIds) {
                if (sid != null) skillDAO.addJobSkill(jobId, sid, false);
            }
        }
    }

    public boolean closeJob(int jobId) {
        return jobDAO.updateStatus(jobId, Job.Status.CLOSED);
    }

    public boolean activateJob(int jobId) {
        return jobDAO.updateStatus(jobId, Job.Status.ACTIVE);
    }

    public boolean deleteJob(int jobId) {
        return jobDAO.deleteJob(jobId);
    }

    public List<Application> getApplicantsForJob(int jobId) {
        return applicationDAO.findByJobId(jobId);
    }

    public List<Application> getAllApplicantsForRecruiter(int recruiterId) {
        return applicationDAO.findByRecruiterId(recruiterId);
    }

    public Application getApplicationById(int applicationId) {
        return applicationDAO.findById(applicationId);
    }

    public boolean updateApplicationStatus(int applicationId, Application.Status status, String notes, Timestamp interviewDate) {
        return applicationDAO.updateStatus(applicationId, status, notes, interviewDate);
    }

    public MatchResult evaluateApplicant(int studentId, int jobId) {
        Student student = studentService.getStudentById(studentId);
        Job job = getJobById(jobId);
        if (student != null && job != null) {
            return matchingService.calculateMatch(student, job);
        }
        return null;
    }
}
