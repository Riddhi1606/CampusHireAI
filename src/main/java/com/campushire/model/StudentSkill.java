package com.campushire.model;

import java.io.Serializable;

/**
 * Association between Student and Skill with proficiency level.
 */
public class StudentSkill implements Serializable {
    private static final long serialVersionUID = 1L;

    public enum Proficiency {
        BEGINNER, INTERMEDIATE, ADVANCED
    }

    private int id;
    private int studentId;
    private int skillId;
    private Proficiency proficiency;

    // Joined skill metadata
    private String skillName;
    private String skillCategory;

    public StudentSkill() {}

    public StudentSkill(int studentId, int skillId, Proficiency proficiency) {
        this.studentId = studentId;
        this.skillId = skillId;
        this.proficiency = proficiency;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getSkillId() { return skillId; }
    public void setSkillId(int skillId) { this.skillId = skillId; }

    public Proficiency getProficiency() { return proficiency; }
    public void setProficiency(Proficiency proficiency) { this.proficiency = proficiency; }

    public String getSkillName() { return skillName; }
    public void setSkillName(String skillName) { this.skillName = skillName; }

    public String getSkillCategory() { return skillCategory; }
    public void setSkillCategory(String skillCategory) { this.skillCategory = skillCategory; }
}
