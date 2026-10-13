package com.campushire.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Encapsulates the transparent, explainable skill matching score
 * and criteria breakdown as defined in the CampusHire AI specification.
 */
public class MatchResult implements Serializable {
    private static final long serialVersionUID = 1L;

    // Component scores (weighted contribution out of 100)
    private double overallScore;    // 0 to 100
    private double skillScore;      // out of 50.0
    private double cgpaScore;       // out of 20.0
    private double branchScore;     // out of 15.0
    private double certScore;       // out of 10.0
    private double projectScore;    // out of 5.0

    // Component raw percentages (0 to 100% for display)
    private double skillPercentage;
    private double cgpaPercentage;
    private double branchPercentage;
    private double certPercentage;
    private double projectPercentage;

    // Eligibility check
    private boolean eligible;
    private String eligibilityReason;

    // Skills breakdown
    private List<String> matchedSkills = new ArrayList<>();
    private List<String> missingSkills = new ArrayList<>();
    private int totalRequiredSkills;

    // Presentation helpers
    private String badgeColor;   // 'success', 'primary', 'warning', 'danger'
    private String matchCategory; // 'Excellent Match', 'Strong Match', 'Moderate Match', 'Low Match'
    private String advice;

    public MatchResult() {}

    public double getOverallScore() { return overallScore; }
    public void setOverallScore(double overallScore) {
        this.overallScore = Math.round(overallScore * 100.0) / 100.0;
        updateBadgeAndCategory();
    }

    public double getSkillScore() { return skillScore; }
    public void setSkillScore(double skillScore) { this.skillScore = Math.round(skillScore * 100.0) / 100.0; }

    public double getCgpaScore() { return cgpaScore; }
    public void setCgpaScore(double cgpaScore) { this.cgpaScore = Math.round(cgpaScore * 100.0) / 100.0; }

    public double getBranchScore() { return branchScore; }
    public void setBranchScore(double branchScore) { this.branchScore = Math.round(branchScore * 100.0) / 100.0; }

    public double getCertScore() { return certScore; }
    public void setCertScore(double certScore) { this.certScore = Math.round(certScore * 100.0) / 100.0; }

    public double getProjectScore() { return projectScore; }
    public void setProjectScore(double projectScore) { this.projectScore = Math.round(projectScore * 100.0) / 100.0; }

    public double getSkillPercentage() { return skillPercentage; }
    public void setSkillPercentage(double skillPercentage) { this.skillPercentage = Math.round(skillPercentage * 10.0) / 10.0; }

    public double getCgpaPercentage() { return cgpaPercentage; }
    public void setCgpaPercentage(double cgpaPercentage) { this.cgpaPercentage = Math.round(cgpaPercentage * 10.0) / 10.0; }

    public double getBranchPercentage() { return branchPercentage; }
    public void setBranchPercentage(double branchPercentage) { this.branchPercentage = Math.round(branchPercentage * 10.0) / 10.0; }

    public double getCertPercentage() { return certPercentage; }
    public void setCertPercentage(double certPercentage) { this.certPercentage = Math.round(certPercentage * 10.0) / 10.0; }

    public double getProjectPercentage() { return projectPercentage; }
    public void setProjectPercentage(double projectPercentage) { this.projectPercentage = Math.round(projectPercentage * 10.0) / 10.0; }

    public boolean isEligible() { return eligible; }
    public void setEligible(boolean eligible) { this.eligible = eligible; }

    public String getEligibilityReason() { return eligibilityReason; }
    public void setEligibilityReason(String eligibilityReason) { this.eligibilityReason = eligibilityReason; }

    public List<String> getMatchedSkills() { return matchedSkills; }
    public void setMatchedSkills(List<String> matchedSkills) { this.matchedSkills = matchedSkills; }

    public List<String> getMissingSkills() { return missingSkills; }
    public void setMissingSkills(List<String> missingSkills) { this.missingSkills = missingSkills; }

    public int getTotalRequiredSkills() { return totalRequiredSkills; }
    public void setTotalRequiredSkills(int totalRequiredSkills) { this.totalRequiredSkills = totalRequiredSkills; }

    public String getBadgeColor() { return badgeColor; }
    public String getMatchCategory() { return matchCategory; }

    public String getAdvice() { return advice; }
    public void setAdvice(String advice) { this.advice = advice; }

    private void updateBadgeAndCategory() {
        if (overallScore >= 85.0) {
            badgeColor = "success";
            matchCategory = "Excellent Match";
        } else if (overallScore >= 70.0) {
            badgeColor = "primary";
            matchCategory = "Strong Match";
        } else if (overallScore >= 50.0) {
            badgeColor = "warning";
            matchCategory = "Moderate Match";
        } else {
            badgeColor = "danger";
            matchCategory = "Low Match";
        }
    }
}
