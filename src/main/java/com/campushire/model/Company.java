package com.campushire.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * Company entity representing recruiter organisation profiles.
 */
public class Company implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int recruiterId;
    private String companyName;
    private String industry;
    private String website;
    private String location;
    private String about;
    private String logoUrl;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Joined recruiter details
    private String recruiterName;
    private String recruiterEmail;

    public Company() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getRecruiterId() { return recruiterId; }
    public void setRecruiterId(int recruiterId) { this.recruiterId = recruiterId; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getIndustry() { return industry; }
    public void setIndustry(String industry) { this.industry = industry; }

    public String getWebsite() { return website; }
    public void setWebsite(String website) { this.website = website; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getAbout() { return about; }
    public void setAbout(String about) { this.about = about; }

    public String getLogoUrl() { return logoUrl; }
    public void setLogoUrl(String logoUrl) { this.logoUrl = logoUrl; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getRecruiterName() { return recruiterName; }
    public void setRecruiterName(String recruiterName) { this.recruiterName = recruiterName; }

    public String getRecruiterEmail() { return recruiterEmail; }
    public void setRecruiterEmail(String recruiterEmail) { this.recruiterEmail = recruiterEmail; }
}
