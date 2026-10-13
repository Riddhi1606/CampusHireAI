package com.campushire.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Job application entity linking student to job with application lifecycle status.
 */
public class Application implements Serializable {
    private static final long serialVersionUID = 1L;

    public enum Status {
        APPLIED, IN_REVIEW, SHORTLISTED, INTERVIEW_SCHEDULED, REJECTED, OFFERED
    }

    private int id;
    private int jobId;
    private int studentId;
    private double matchScore;
    private Status status = Status.APPLIED;
    private String coverLetter;
    private Timestamp interviewDate;
    private String recruiterNotes;
    private Timestamp appliedAt;
    private Timestamp updatedAt;

    // Joined Job and Company details
    private String jobTitle;
    private String jobLocation;
    private String companyName;
    private String companyLogoUrl;

    // Joined Student details
    private String studentName;
    private String studentEmail;
    private String studentPhone;
    private String studentCollege;
    private String studentBranch;
    private double studentCgpa;
    private String studentResumeUrl;

    public Application() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getJobId() { return jobId; }
    public void setJobId(int jobId) { this.jobId = jobId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public double getMatchScore() { return matchScore; }
    public void setMatchScore(double matchScore) { this.matchScore = Math.round(matchScore * 100.0) / 100.0; }

    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }

    public String getCoverLetter() { return coverLetter; }
    public void setCoverLetter(String coverLetter) { this.coverLetter = coverLetter; }

    public Timestamp getInterviewDate() { return interviewDate; }
    public void setInterviewDate(Timestamp interviewDate) { this.interviewDate = interviewDate; }

    public String getRecruiterNotes() { return recruiterNotes; }
    public void setRecruiterNotes(String recruiterNotes) { this.recruiterNotes = recruiterNotes; }

    public Timestamp getAppliedAt() { return appliedAt; }
    public void setAppliedAt(Timestamp appliedAt) { this.appliedAt = appliedAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getJobTitle() { return jobTitle; }
    public void setJobTitle(String jobTitle) { this.jobTitle = jobTitle; }

    public String getJobLocation() { return jobLocation; }
    public void setJobLocation(String jobLocation) { this.jobLocation = jobLocation; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getCompanyLogoUrl() { return companyLogoUrl; }
    public void setCompanyLogoUrl(String companyLogoUrl) { this.companyLogoUrl = companyLogoUrl; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getStudentEmail() { return studentEmail; }
    public void setStudentEmail(String studentEmail) { this.studentEmail = studentEmail; }

    public String getStudentPhone() { return studentPhone; }
    public void setStudentPhone(String studentPhone) { this.studentPhone = studentPhone; }

    public String getStudentCollege() { return studentCollege; }
    public void setStudentCollege(String studentCollege) { this.studentCollege = studentCollege; }

    public String getStudentBranch() { return studentBranch; }
    public void setStudentBranch(String studentBranch) { this.studentBranch = studentBranch; }

    public double getStudentCgpa() { return studentCgpa; }
    public void setStudentCgpa(double studentCgpa) { this.studentCgpa = studentCgpa; }

    public String getStudentResumeUrl() { return studentResumeUrl; }
    public void setStudentResumeUrl(String studentResumeUrl) { this.studentResumeUrl = studentResumeUrl; }

    public String getStatusBadgeClass() {
        if (status == null) return "secondary";
        return switch (status) {
            case APPLIED -> "info";
            case IN_REVIEW -> "warning";
            case SHORTLISTED -> "primary";
            case INTERVIEW_SCHEDULED -> "purple";
            case OFFERED -> "success";
            case REJECTED -> "danger";
        };
    }
}
