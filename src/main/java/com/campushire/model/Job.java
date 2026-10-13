package com.campushire.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Job posting entity published by recruiters.
 */
public class Job implements Serializable {
    private static final long serialVersionUID = 1L;

    public enum JobType {
        FULL_TIME, INTERNSHIP, PART_TIME
    }

    public enum Status {
        ACTIVE, CLOSED, UNDER_REVIEW
    }

    private int id;
    private int companyId;
    private String title;
    private String description;
    private String department;
    private JobType jobType = JobType.FULL_TIME;
    private String location;
    private String packageLpa;
    private double minCgpa;
    private String eligibleBranches = "All";
    private int openings = 1;
    private Date deadline;
    private Status status = Status.ACTIVE;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Joined company information
    private String companyName;
    private String companyLogoUrl;
    private String companyLocation;

    // Associated skills
    private List<JobSkill> requiredSkills = new ArrayList<>();

    // Calculated for current student session (transient)
    private MatchResult matchResult;
    private boolean hasApplied;
    private int applicantCount;

    public Job() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCompanyId() { return companyId; }
    public void setCompanyId(int companyId) { this.companyId = companyId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public JobType getJobType() { return jobType; }
    public void setJobType(JobType jobType) { this.jobType = jobType; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getPackageLpa() { return packageLpa; }
    public void setPackageLpa(String packageLpa) { this.packageLpa = packageLpa; }

    public double getMinCgpa() { return minCgpa; }
    public void setMinCgpa(double minCgpa) { this.minCgpa = minCgpa; }

    public String getEligibleBranches() { return eligibleBranches; }
    public void setEligibleBranches(String eligibleBranches) { this.eligibleBranches = eligibleBranches; }

    public int getOpenings() { return openings; }
    public void setOpenings(int openings) { this.openings = openings; }

    public Date getDeadline() { return deadline; }
    public void setDeadline(Date deadline) { this.deadline = deadline; }

    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getCompanyLogoUrl() { return companyLogoUrl; }
    public void setCompanyLogoUrl(String companyLogoUrl) { this.companyLogoUrl = companyLogoUrl; }

    public String getCompanyLocation() { return companyLocation; }
    public void setCompanyLocation(String companyLocation) { this.companyLocation = companyLocation; }

    public List<JobSkill> getRequiredSkills() { return requiredSkills; }
    public void setRequiredSkills(List<JobSkill> requiredSkills) { this.requiredSkills = requiredSkills; }

    public MatchResult getMatchResult() { return matchResult; }
    public void setMatchResult(MatchResult matchResult) { this.matchResult = matchResult; }

    public boolean isHasApplied() { return hasApplied; }
    public void setHasApplied(boolean hasApplied) { this.hasApplied = hasApplied; }

    public int getApplicantCount() { return applicantCount; }
    public void setApplicantCount(int applicantCount) { this.applicantCount = applicantCount; }
}
