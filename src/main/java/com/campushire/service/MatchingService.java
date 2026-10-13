package com.campushire.service;

import com.campushire.model.*;
import com.campushire.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Core explainable skill-matching engine implementing the 5-pillar weighted formula:
 * 1. Required skill match: 50%
 * 2. CGPA / eligibility:   20%
 * 3. Branch eligibility:   15%
 * 4. Certifications:       10%
 * 5. Projects:              5%
 * Total:                  100%
 */
public class MatchingService {

    private static final Logger LOGGER = Logger.getLogger(MatchingService.class.getName());

    public MatchResult calculateMatch(Student student, Job job) {
        MatchResult result = new MatchResult();
        if (student == null || job == null) {
            result.setOverallScore(0.0);
            return result;
        }

        // ==========================================
        // 1. Skill Matching (Weight: 50%)
        // ==========================================
        List<JobSkill> jobSkills = job.getRequiredSkills();
        List<StudentSkill> studentSkills = student.getSkills();

        Set<String> studentSkillSet = new HashSet<>();
        Map<String, StudentSkill.Proficiency> proficiencyMap = new HashMap<>();
        if (studentSkills != null) {
            for (StudentSkill ss : studentSkills) {
                if (ss.getSkillName() != null) {
                    String normName = ss.getSkillName().trim().toLowerCase();
                    studentSkillSet.add(normName);
                    proficiencyMap.put(normName, ss.getProficiency());
                }
            }
        }

        List<String> matched = new ArrayList<>();
        List<String> missing = new ArrayList<>();
        double skillRawScore = 100.0;

        if (jobSkills != null && !jobSkills.isEmpty()) {
            double totalWeight = 0.0;
            double earnedWeight = 0.0;

            for (JobSkill js : jobSkills) {
                String reqName = js.getSkillName() != null ? js.getSkillName().trim().toLowerCase() : "";
                double skillFactor = js.isMandatory() ? 1.5 : 1.0;
                totalWeight += skillFactor;

                boolean hasSkill = false;
                for (String sSkill : studentSkillSet) {
                    if (sSkill.contains(reqName) || reqName.contains(sSkill)) {
                        hasSkill = true;
                        break;
                    }
                }

                if (hasSkill) {
                    matched.add(js.getSkillName());
                    // Proficiency bonus adjustment
                    StudentSkill.Proficiency prof = proficiencyMap.get(reqName);
                    double profMultiplier = 1.0;
                    if (prof == StudentSkill.Proficiency.ADVANCED) profMultiplier = 1.1;
                    else if (prof == StudentSkill.Proficiency.BEGINNER) profMultiplier = 0.85;

                    earnedWeight += (skillFactor * profMultiplier);
                } else {
                    missing.add(js.getSkillName());
                }
            }

            result.setTotalRequiredSkills(jobSkills.size());
            skillRawScore = Math.min(100.0, (earnedWeight / totalWeight) * 100.0);
        } else {
            result.setTotalRequiredSkills(0);
        }

        result.setMatchedSkills(matched);
        result.setMissingSkills(missing);
        result.setSkillPercentage(skillRawScore);
        result.setSkillScore(skillRawScore * 0.50);

        // ==========================================
        // 2. CGPA / Eligibility (Weight: 20%)
        // ==========================================
        double minCgpa = job.getMinCgpa();
        double studentCgpa = student.getCgpa();
        double cgpaRawScore = 100.0;
        boolean cgpaEligible = true;

        if (minCgpa > 0.0) {
            if (studentCgpa >= minCgpa) {
                // Bonus for stellar academic standing
                double bonus = Math.min(15.0, (studentCgpa - minCgpa) * 10.0);
                cgpaRawScore = Math.min(100.0, 85.0 + bonus);
            } else {
                cgpaEligible = false;
                cgpaRawScore = Math.max(10.0, (studentCgpa / minCgpa) * 50.0);
            }
        } else {
            cgpaRawScore = studentCgpa > 0.0 ? Math.min(100.0, studentCgpa * 10.0) : 75.0;
        }

        result.setCgpaPercentage(cgpaRawScore);
        result.setCgpaScore(cgpaRawScore * 0.20);

        // ==========================================
        // 3. Branch Eligibility (Weight: 15%)
        // ==========================================
        String eligibleBranches = job.getEligibleBranches();
        String studentBranch = student.getBranch();
        double branchRawScore = 100.0;
        boolean branchEligible = true;

        if (eligibleBranches != null && !eligibleBranches.trim().equalsIgnoreCase("All") && !eligibleBranches.trim().isEmpty()) {
            if (studentBranch != null && !studentBranch.trim().isEmpty()) {
                String normStudentBranch = studentBranch.toLowerCase();
                String normEligible = eligibleBranches.toLowerCase();

                if (normEligible.contains(normStudentBranch) || normStudentBranch.contains(normEligible)) {
                    branchRawScore = 100.0;
                } else if (normStudentBranch.contains("computer") || normStudentBranch.contains("information") || normStudentBranch.contains("electronics")) {
                    // Allied STEM branch
                    branchRawScore = 70.0;
                } else {
                    branchEligible = false;
                    branchRawScore = 30.0;
                }
            } else {
                branchRawScore = 50.0;
            }
        } else {
            branchRawScore = 100.0;
        }

        result.setBranchPercentage(branchRawScore);
        result.setBranchScore(branchRawScore * 0.15);

        // ==========================================
        // 4. Certifications (Weight: 10%)
        // ==========================================
        List<Certification> certs = student.getCertifications();
        double certRawScore = 20.0; // Baseline
        if (certs != null && !certs.isEmpty()) {
            int count = certs.size();
            if (count >= 3) certRawScore = 100.0;
            else if (count == 2) certRawScore = 85.0;
            else certRawScore = 70.0;

            // Check if any certification directly matches job requirements
            for (Certification c : certs) {
                if (c.getName() != null) {
                    for (String m : missing) {
                        if (c.getName().toLowerCase().contains(m.toLowerCase())) {
                            certRawScore = Math.min(100.0, certRawScore + 15.0);
                        }
                    }
                }
            }
        }
        result.setCertPercentage(certRawScore);
        result.setCertScore(certRawScore * 0.10);

        // ==========================================
        // 5. Projects (Weight: 5%)
        // ==========================================
        List<Project> projs = student.getProjects();
        double projRawScore = 20.0;
        if (projs != null && !projs.isEmpty()) {
            int count = projs.size();
            if (count >= 3) projRawScore = 100.0;
            else if (count == 2) projRawScore = 85.0;
            else projRawScore = 70.0;

            // Tech stack relevance
            for (Project p : projs) {
                if (p.getTechStack() != null) {
                    for (JobSkill js : (jobSkills != null ? jobSkills : Collections.<JobSkill>emptyList())) {
                        if (js.getSkillName() != null && p.getTechStack().toLowerCase().contains(js.getSkillName().toLowerCase())) {
                            projRawScore = Math.min(100.0, projRawScore + 10.0);
                        }
                    }
                }
            }
        }
        result.setProjectPercentage(projRawScore);
        result.setProjectScore(projRawScore * 0.05);

        // Overall Final Weighted Score
        double overall = result.getSkillScore() + result.getCgpaScore() + result.getBranchScore()
                       + result.getCertScore() + result.getProjectScore();
        result.setOverallScore(overall);

        // Eligibility verdict
        boolean isOverallEligible = cgpaEligible && branchEligible;
        result.setEligible(isOverallEligible);
        if (!cgpaEligible) {
            result.setEligibilityReason("Minimum CGPA criteria not met (" + studentCgpa + " < " + minCgpa + ")");
        } else if (!branchEligible) {
            result.setEligibilityReason("Branch " + studentBranch + " does not match listed eligibility (" + eligibleBranches + ")");
        } else {
            result.setEligibilityReason("Eligible for recruitment process");
        }

        // Actionable guidance
        if (!missing.isEmpty()) {
            result.setAdvice("Recommended preparation: Master " + String.join(", ", missing.subList(0, Math.min(3, missing.size()))) + " to maximize selection probability.");
        } else {
            result.setAdvice("Exceptional profile fit! Polish core fundamentals and prepare for technical interview rounds.");
        }

        return result;
    }

    /**
     * Persists or updates the calculated recommendation in the database for instant retrieval.
     */
    public void saveRecommendation(int studentId, int jobId, MatchResult mr) {
        String sql = "INSERT INTO recommendations (student_id, job_id, overall_score, skill_score, cgpa_score, branch_score, cert_score, project_score, missing_skills) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE overall_score = VALUES(overall_score), skill_score = VALUES(skill_score), " +
                     "cgpa_score = VALUES(cgpa_score), branch_score = VALUES(branch_score), cert_score = VALUES(cert_score), " +
                     "project_score = VALUES(project_score), missing_skills = VALUES(missing_skills)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setInt(2, jobId);
            ps.setDouble(3, mr.getOverallScore());
            ps.setDouble(4, mr.getSkillScore());
            ps.setDouble(5, mr.getCgpaScore());
            ps.setDouble(6, mr.getBranchScore());
            ps.setDouble(7, mr.getCertScore());
            ps.setDouble(8, mr.getProjectScore());
            ps.setString(9, String.join(", ", mr.getMissingSkills()));
            ps.executeUpdate();
        } catch (Exception e) {
            LOGGER.log(Level.FINE, "Failed to cache recommendation: " + e.getMessage());
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
    }
}
