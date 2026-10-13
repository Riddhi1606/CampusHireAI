package com.campushire.dao;

import com.campushire.model.JobSkill;
import com.campushire.model.Skill;
import com.campushire.model.StudentSkill;
import com.campushire.util.DBConnection;

import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Master Skills, Student Skills, and Job Skills associations.
 */
public class SkillDAO {

    private static final Logger LOGGER = Logger.getLogger(SkillDAO.class.getName());

    public List<Skill> findAll() {
        List<Skill> list = new ArrayList<>();
        String sql = "SELECT id, name, category, created_at FROM skills ORDER BY name ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Skill s = new Skill();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setCategory(rs.getString("category"));
                s.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(s);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findAll skills", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public Skill findById(int id) {
        String sql = "SELECT id, name, category, created_at FROM skills WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Skill s = new Skill();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setCategory(rs.getString("category"));
                s.setCreatedAt(rs.getTimestamp("created_at"));
                return s;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findById for skill id: " + id, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return null;
    }

    public Skill findByName(String name) {
        String sql = "SELECT id, name, category, created_at FROM skills WHERE LOWER(name) = LOWER(?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, name != null ? name.trim() : "");
            rs = ps.executeQuery();
            if (rs.next()) {
                Skill s = new Skill();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setCategory(rs.getString("category"));
                s.setCreatedAt(rs.getTimestamp("created_at"));
                return s;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findByName for: " + name, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return null;
    }

    public int createSkill(Skill skill) {
        String sql = "INSERT INTO skills (name, category) VALUES (?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, skill.getName().trim());
            ps.setString(2, skill.getCategory() != null ? skill.getCategory().trim() : "General");
            int affected = ps.executeUpdate();
            if (affected > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in createSkill: " + skill.getName(), e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return -1;
    }

    public boolean deleteSkill(int id) {
        String sql = "DELETE FROM skills WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in deleteSkill: " + id, e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }

    // Student Skills
    public List<StudentSkill> getStudentSkills(int studentId) {
        List<StudentSkill> list = new ArrayList<>();
        String sql = "SELECT ss.id, ss.student_id, ss.skill_id, ss.proficiency, s.name as skill_name, s.category as skill_category " +
                     "FROM student_skills ss " +
                     "JOIN skills s ON ss.skill_id = s.id " +
                     "WHERE ss.student_id = ? " +
                     "ORDER BY s.name ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            rs = ps.executeQuery();
            while (rs.next()) {
                StudentSkill ss = new StudentSkill();
                ss.setId(rs.getInt("id"));
                ss.setStudentId(rs.getInt("student_id"));
                ss.setSkillId(rs.getInt("skill_id"));
                ss.setProficiency(StudentSkill.Proficiency.valueOf(rs.getString("proficiency")));
                ss.setSkillName(rs.getString("skill_name"));
                ss.setSkillCategory(rs.getString("skill_category"));
                list.add(ss);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getStudentSkills for student: " + studentId, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public boolean addStudentSkill(int studentId, int skillId, StudentSkill.Proficiency proficiency) {
        String sql = "INSERT INTO student_skills (student_id, skill_id, proficiency) " +
                     "VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE proficiency = VALUES(proficiency)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setInt(2, skillId);
            ps.setString(3, proficiency != null ? proficiency.name() : StudentSkill.Proficiency.INTERMEDIATE.name());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in addStudentSkill", e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }

    public boolean deleteStudentSkill(int studentId, int skillId) {
        String sql = "DELETE FROM student_skills WHERE student_id = ? AND skill_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setInt(2, skillId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in deleteStudentSkill", e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }

    // Job Skills
    public List<JobSkill> getJobSkills(int jobId) {
        List<JobSkill> list = new ArrayList<>();
        String sql = "SELECT js.id, js.job_id, js.skill_id, js.is_mandatory, s.name as skill_name, s.category as skill_category " +
                     "FROM job_skills js " +
                     "JOIN skills s ON js.skill_id = s.id " +
                     "WHERE js.job_id = ? " +
                     "ORDER BY js.is_mandatory DESC, s.name ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, jobId);
            rs = ps.executeQuery();
            while (rs.next()) {
                JobSkill js = new JobSkill();
                js.setId(rs.getInt("id"));
                js.setJobId(rs.getInt("job_id"));
                js.setSkillId(rs.getInt("skill_id"));
                js.setMandatory(rs.getBoolean("is_mandatory"));
                js.setSkillName(rs.getString("skill_name"));
                js.setSkillCategory(rs.getString("skill_category"));
                list.add(js);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getJobSkills for job: " + jobId, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public boolean addJobSkill(int jobId, int skillId, boolean isMandatory) {
        String sql = "INSERT INTO job_skills (job_id, skill_id, is_mandatory) " +
                     "VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE is_mandatory = VALUES(is_mandatory)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, jobId);
            ps.setInt(2, skillId);
            ps.setBoolean(3, isMandatory);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in addJobSkill", e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }

    public boolean deleteJobSkills(int jobId) {
        String sql = "DELETE FROM job_skills WHERE job_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, jobId);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in deleteJobSkills for job: " + jobId, e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }

    /**
     * Aggregates top skills required across active jobs for analytics and skill gaps.
     */
    public Map<String, Integer> getTopDemandedSkills(int limit) {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT s.name, COUNT(js.id) as demand_count " +
                     "FROM job_skills js " +
                     "JOIN skills s ON js.skill_id = s.id " +
                     "JOIN jobs j ON js.job_id = j.id " +
                     "WHERE j.status = 'ACTIVE' " +
                     "GROUP BY s.name " +
                     "ORDER BY demand_count DESC, s.name ASC " +
                     "LIMIT ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                result.put(rs.getString("name"), rs.getInt("demand_count"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in getTopDemandedSkills", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return result;
    }
}
