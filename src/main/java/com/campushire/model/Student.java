package com.campushire.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Student profile entity containing academic data, skills, projects, and certifications.
 */
public class Student implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int userId;
    private String collegeName;
    private String degree;
    private String branch;
    private double cgpa;
    private int graduationYear;
    private String rollNumber;
    private String phone;
    private String bio;
    private String resumeUrl;
    private String githubUrl;
    private String linkedinUrl;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Associated User information
    private String fullName;
    private String email;

    // Associated collections
    private List<StudentSkill> skills = new ArrayList<>();
    private List<Project> projects = new ArrayList<>();
    private List<Certification> certifications = new ArrayList<>();

    public Student() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCollegeName() { return collegeName; }
    public void setCollegeName(String collegeName) { this.collegeName = collegeName; }

    public String getDegree() { return degree; }
    public void setDegree(String degree) { this.degree = degree; }

    public String getBranch() { return branch; }
    public void setBranch(String branch) { this.branch = branch; }

    public double getCgpa() { return cgpa; }
    public void setCgpa(double cgpa) { this.cgpa = cgpa; }

    public int getGraduationYear() { return graduationYear; }
    public void setGraduationYear(int graduationYear) { this.graduationYear = graduationYear; }

    public String getRollNumber() { return rollNumber; }
    public void setRollNumber(String rollNumber) { this.rollNumber = rollNumber; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }

    public String getResumeUrl() { return resumeUrl; }
    public void setResumeUrl(String resumeUrl) { this.resumeUrl = resumeUrl; }

    public String getGithubUrl() { return githubUrl; }
    public void setGithubUrl(String githubUrl) { this.githubUrl = githubUrl; }

    public String getLinkedinUrl() { return linkedinUrl; }
    public void setLinkedinUrl(String linkedinUrl) { this.linkedinUrl = linkedinUrl; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public List<StudentSkill> getSkills() { return skills; }
    public void setSkills(List<StudentSkill> skills) { this.skills = skills; }

    public List<Project> getProjects() { return projects; }
    public void setProjects(List<Project> projects) { this.projects = projects; }

    public List<Certification> getCertifications() { return certifications; }
    public void setCertifications(List<Certification> certifications) { this.certifications = certifications; }

    /**
     * Helper to compute profile completion percentage.
     */
    public int getProfileCompletionPercentage() {
        int score = 0;
        if (fullName != null && !fullName.trim().isEmpty()) score += 15;
        if (collegeName != null && !collegeName.trim().isEmpty()) score += 15;
        if (branch != null && !branch.trim().isEmpty()) score += 15;
        if (cgpa > 0.0) score += 15;
        if (resumeUrl != null && !resumeUrl.trim().isEmpty()) score += 15;
        if (skills != null && !skills.isEmpty()) score += 15;
        if ((projects != null && !projects.isEmpty()) || (certifications != null && !certifications.isEmpty())) score += 10;
        return Math.min(score, 100);
    }
}
