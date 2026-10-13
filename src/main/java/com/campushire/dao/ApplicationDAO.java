package com.campushire.dao;

import com.campushire.model.Application;
import com.campushire.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Applications submitted by students.
 */
public class ApplicationDAO {

    private static final Logger LOGGER = Logger.getLogger(ApplicationDAO.class.getName());

    public int apply(Application app) {
        String sql = "INSERT INTO applications (job_id, student_id, match_score, status, cover_letter) " +
                     "VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, app.getJobId());
            ps.setInt(2, app.getStudentId());
            ps.setDouble(3, app.getMatchScore());
            ps.setString(4, app.getStatus().name());
            ps.setString(5, app.getCoverLetter());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in apply for student: " + app.getStudentId() + " job: " + app.getJobId(), e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return -1;
    }

    public boolean hasApplied(int jobId, int studentId) {
        String sql = "SELECT id FROM applications WHERE job_id = ? AND student_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, jobId);
            ps.setInt(2, studentId);
            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in hasApplied", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return false;
    }

    public Application findById(int id) {
        String sql = "SELECT a.*, j.title as job_title, j.location as job_location, " +
                     "c.company_name, c.logo_url as company_logo_url, " +
                     "u.full_name as student_name, u.email as student_email, " +
                     "s.phone as student_phone, s.college_name as student_college, " +
                     "s.branch as student_branch, s.cgpa as student_cgpa, s.resume_url as student_resume_url " +
                     "FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "JOIN companies c ON j.company_id = c.id " +
                     "JOIN students s ON a.student_id = s.id " +
                     "JOIN users u ON s.user_id = u.id " +
                     "WHERE a.id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapApplication(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findById for application id: " + id, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return null;
    }

    public List<Application> findByStudentId(int studentId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, j.title as job_title, j.location as job_location, " +
                     "c.company_name, c.logo_url as company_logo_url, " +
                     "u.full_name as student_name, u.email as student_email, " +
                     "s.phone as student_phone, s.college_name as student_college, " +
                     "s.branch as student_branch, s.cgpa as student_cgpa, s.resume_url as student_resume_url " +
                     "FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "JOIN companies c ON j.company_id = c.id " +
                     "JOIN students s ON a.student_id = s.id " +
                     "JOIN users u ON s.user_id = u.id " +
                     "WHERE a.student_id = ? " +
                     "ORDER BY a.applied_at DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapApplication(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findByStudentId: " + studentId, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public List<Application> findByJobId(int jobId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, j.title as job_title, j.location as job_location, " +
                     "c.company_name, c.logo_url as company_logo_url, " +
                     "u.full_name as student_name, u.email as student_email, " +
                     "s.phone as student_phone, s.college_name as student_college, " +
                     "s.branch as student_branch, s.cgpa as student_cgpa, s.resume_url as student_resume_url " +
                     "FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "JOIN companies c ON j.company_id = c.id " +
                     "JOIN students s ON a.student_id = s.id " +
                     "JOIN users u ON s.user_id = u.id " +
                     "WHERE a.job_id = ? " +
                     "ORDER BY a.match_score DESC, a.applied_at DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, jobId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapApplication(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findByJobId: " + jobId, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public List<Application> findByRecruiterId(int recruiterId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, j.title as job_title, j.location as job_location, " +
                     "c.company_name, c.logo_url as company_logo_url, " +
                     "u.full_name as student_name, u.email as student_email, " +
                     "s.phone as student_phone, s.college_name as student_college, " +
                     "s.branch as student_branch, s.cgpa as student_cgpa, s.resume_url as student_resume_url " +
                     "FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "JOIN companies c ON j.company_id = c.id " +
                     "JOIN students s ON a.student_id = s.id " +
                     "JOIN users u ON s.user_id = u.id " +
                     "WHERE c.recruiter_id = ? " +
                     "ORDER BY a.applied_at DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, recruiterId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapApplication(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findByRecruiterId: " + recruiterId, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public boolean updateStatus(int applicationId, Application.Status status, String recruiterNotes, Timestamp interviewDate) {
        String sql = "UPDATE applications SET status = ?, recruiter_notes = ?, interview_date = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, status.name());
            ps.setString(2, recruiterNotes);
            ps.setTimestamp(3, interviewDate);
            ps.setInt(4, applicationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in updateStatus for application id: " + applicationId, e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }

    public int countTotalApplications() {
        String sql = "SELECT COUNT(*) FROM applications";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in countTotalApplications", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return 0;
    }

    public int countApplicationsForRecruiter(int recruiterId) {
        String sql = "SELECT COUNT(a.id) FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "JOIN companies c ON j.company_id = c.id " +
                     "WHERE c.recruiter_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, recruiterId);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in countApplicationsForRecruiter", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return 0;
    }

    private Application mapApplication(ResultSet rs) throws SQLException {
        Application a = new Application();
        a.setId(rs.getInt("id"));
        a.setJobId(rs.getInt("job_id"));
        a.setStudentId(rs.getInt("student_id"));
        a.setMatchScore(rs.getDouble("match_score"));
        a.setStatus(Application.Status.valueOf(rs.getString("status")));
        a.setCoverLetter(rs.getString("cover_letter"));
        a.setInterviewDate(rs.getTimestamp("interview_date"));
        a.setRecruiterNotes(rs.getString("recruiter_notes"));
        a.setAppliedAt(rs.getTimestamp("applied_at"));
        a.setUpdatedAt(rs.getTimestamp("updated_at"));

        a.setJobTitle(rs.getString("job_title"));
        a.setJobLocation(rs.getString("job_location"));
        a.setCompanyName(rs.getString("company_name"));
        a.setCompanyLogoUrl(rs.getString("company_logo_url"));

        a.setStudentName(rs.getString("student_name"));
        a.setStudentEmail(rs.getString("student_email"));
        a.setStudentPhone(rs.getString("student_phone"));
        a.setStudentCollege(rs.getString("student_college"));
        a.setStudentBranch(rs.getString("student_branch"));
        a.setStudentCgpa(rs.getDouble("student_cgpa"));
        a.setStudentResumeUrl(rs.getString("student_resume_url"));
        return a;
    }
}
