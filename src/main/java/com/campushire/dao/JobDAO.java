package com.campushire.dao;

import com.campushire.model.Job;
import com.campushire.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Job Postings.
 */
public class JobDAO {

    private static final Logger LOGGER = Logger.getLogger(JobDAO.class.getName());

    public Job findById(int id) {
        String sql = "SELECT j.*, c.company_name, c.logo_url as company_logo_url, c.location as company_location, " +
                     "(SELECT COUNT(*) FROM applications WHERE job_id = j.id) as applicant_count " +
                     "FROM jobs j " +
                     "JOIN companies c ON j.company_id = c.id " +
                     "WHERE j.id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapJob(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findById for job: " + id, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return null;
    }

    public List<Job> findActiveJobs(String keyword, String location, String jobType, Double maxAllowedCgpa) {
        List<Job> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT j.*, c.company_name, c.logo_url as company_logo_url, c.location as company_location, " +
            "(SELECT COUNT(*) FROM applications WHERE job_id = j.id) as applicant_count " +
            "FROM jobs j " +
            "JOIN companies c ON j.company_id = c.id " +
            "WHERE j.status = 'ACTIVE' "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (LOWER(j.title) LIKE ? OR LOWER(j.description) LIKE ? OR LOWER(c.company_name) LIKE ?) ");
            String pat = "%" + keyword.trim().toLowerCase() + "%";
            params.add(pat);
            params.add(pat);
            params.add(pat);
        }

        if (location != null && !location.trim().isEmpty() && !location.equalsIgnoreCase("All")) {
            sql.append("AND LOWER(j.location) LIKE ? ");
            params.add("%" + location.trim().toLowerCase() + "%");
        }

        if (jobType != null && !jobType.trim().isEmpty() && !jobType.equalsIgnoreCase("All")) {
            sql.append("AND j.job_type = ? ");
            params.add(jobType.trim());
        }

        sql.append("ORDER BY j.created_at DESC");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapJob(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findActiveJobs", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public List<Job> findByCompanyId(int companyId) {
        List<Job> list = new ArrayList<>();
        String sql = "SELECT j.*, c.company_name, c.logo_url as company_logo_url, c.location as company_location, " +
                     "(SELECT COUNT(*) FROM applications WHERE job_id = j.id) as applicant_count " +
                     "FROM jobs j " +
                     "JOIN companies c ON j.company_id = c.id " +
                     "WHERE j.company_id = ? " +
                     "ORDER BY j.created_at DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, companyId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapJob(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findByCompanyId: " + companyId, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public List<Job> findAllJobs() {
        List<Job> list = new ArrayList<>();
        String sql = "SELECT j.*, c.company_name, c.logo_url as company_logo_url, c.location as company_location, " +
                     "(SELECT COUNT(*) FROM applications WHERE job_id = j.id) as applicant_count " +
                     "FROM jobs j " +
                     "JOIN companies c ON j.company_id = c.id " +
                     "ORDER BY j.created_at DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapJob(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findAllJobs", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public int createJob(Job j) {
        String sql = "INSERT INTO jobs (company_id, title, description, department, job_type, location, " +
                     "package_lpa, min_cgpa, eligible_branches, openings, deadline, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, j.getCompanyId());
            ps.setString(2, j.getTitle());
            ps.setString(3, j.getDescription());
            ps.setString(4, j.getDepartment());
            ps.setString(5, j.getJobType().name());
            ps.setString(6, j.getLocation());
            ps.setString(7, j.getPackageLpa());
            ps.setDouble(8, j.getMinCgpa());
            ps.setString(9, j.getEligibleBranches());
            ps.setInt(10, j.getOpenings());
            ps.setDate(11, j.getDeadline());
            ps.setString(12, j.getStatus().name());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in createJob", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return -1;
    }

    public boolean updateJob(Job j) {
        String sql = "UPDATE jobs SET title = ?, description = ?, department = ?, job_type = ?, " +
                     "location = ?, package_lpa = ?, min_cgpa = ?, eligible_branches = ?, openings = ?, " +
                     "deadline = ?, status = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, j.getTitle());
            ps.setString(2, j.getDescription());
            ps.setString(3, j.getDepartment());
            ps.setString(4, j.getJobType().name());
            ps.setString(5, j.getLocation());
            ps.setString(6, j.getPackageLpa());
            ps.setDouble(7, j.getMinCgpa());
            ps.setString(8, j.getEligibleBranches());
            ps.setInt(9, j.getOpenings());
            ps.setDate(10, j.getDeadline());
            ps.setString(11, j.getStatus().name());
            ps.setInt(12, j.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in updateJob: " + j.getId(), e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }

    public boolean updateStatus(int jobId, Job.Status status) {
        String sql = "UPDATE jobs SET status = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, status.name());
            ps.setInt(2, jobId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in updateStatus for job: " + jobId, e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }

    public boolean deleteJob(int id) {
        String sql = "DELETE FROM jobs WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in deleteJob: " + id, e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }

    public int countActiveJobs() {
        String sql = "SELECT COUNT(*) FROM jobs WHERE status = 'ACTIVE'";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in countActiveJobs", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return 0;
    }

    public int countTotalJobs() {
        String sql = "SELECT COUNT(*) FROM jobs";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in countTotalJobs", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return 0;
    }

    private Job mapJob(ResultSet rs) throws SQLException {
        Job j = new Job();
        j.setId(rs.getInt("id"));
        j.setCompanyId(rs.getInt("company_id"));
        j.setTitle(rs.getString("title"));
        j.setDescription(rs.getString("description"));
        j.setDepartment(rs.getString("department"));
        j.setJobType(Job.JobType.valueOf(rs.getString("job_type")));
        j.setLocation(rs.getString("location"));
        j.setPackageLpa(rs.getString("package_lpa"));
        j.setMinCgpa(rs.getDouble("min_cgpa"));
        j.setEligibleBranches(rs.getString("eligible_branches"));
        j.setOpenings(rs.getInt("openings"));
        j.setDeadline(rs.getDate("deadline"));
        j.setStatus(Job.Status.valueOf(rs.getString("status")));
        j.setCreatedAt(rs.getTimestamp("created_at"));
        j.setUpdatedAt(rs.getTimestamp("updated_at"));

        j.setCompanyName(rs.getString("company_name"));
        j.setCompanyLogoUrl(rs.getString("company_logo_url"));
        j.setCompanyLocation(rs.getString("company_location"));
        j.setApplicantCount(rs.getInt("applicant_count"));
        return j;
    }
}
