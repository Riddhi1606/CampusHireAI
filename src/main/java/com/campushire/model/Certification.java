package com.campushire.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * Student certification item.
 */
public class Certification implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int studentId;
    private String name;
    private String issuingOrganization;
    private Date issueDate;
    private String credentialUrl;
    private Timestamp createdAt;

    public Certification() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getIssuingOrganization() { return issuingOrganization; }
    public void setIssuingOrganization(String issuingOrganization) { this.issuingOrganization = issuingOrganization; }

    public Date getIssueDate() { return issueDate; }
    public void setIssueDate(Date issueDate) { this.issueDate = issueDate; }

    public String getCredentialUrl() { return credentialUrl; }
    public void setCredentialUrl(String credentialUrl) { this.credentialUrl = credentialUrl; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
