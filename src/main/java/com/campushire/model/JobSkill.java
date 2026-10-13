package com.campushire.model;

import java.io.Serializable;

/**
 * Skill required for a specific job posting.
 */
public class JobSkill implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int jobId;
    private int skillId;
    private boolean mandatory = true;

    // Joined skill metadata
    private String skillName;
    private String skillCategory;

    public JobSkill() {}

    public JobSkill(int jobId, int skillId, boolean mandatory) {
        this.jobId = jobId;
        this.skillId = skillId;
        this.mandatory = mandatory;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getJobId() { return jobId; }
    public void setJobId(int jobId) { this.jobId = jobId; }

    public int getSkillId() { return skillId; }
    public void setSkillId(int skillId) { this.skillId = skillId; }

    public boolean isMandatory() { return mandatory; }
    public void setMandatory(boolean mandatory) { this.mandatory = mandatory; }

    public String getSkillName() { return skillName; }
    public void setSkillName(String skillName) { this.skillName = skillName; }

    public String getSkillCategory() { return skillCategory; }
    public void setSkillCategory(String skillCategory) { this.skillCategory = skillCategory; }
}
