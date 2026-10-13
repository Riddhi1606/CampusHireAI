package com.campushire.dao;

import com.campushire.model.Company;
import com.campushire.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Recruiter Company profile.
 */
public class CompanyDAO {

    private static final Logger LOGGER = Logger.getLogger(CompanyDAO.class.getName());

    public Company findByRecruiterId(int recruiterId) {
        String sql = "SELECT c.*, u.full_name as recruiter_name, u.email as recruiter_email " +
                     "FROM companies c " +
                     "JOIN users u ON c.recruiter_id = u.id " +
                     "WHERE c.recruiter_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, recruiterId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapCompany(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findByRecruiterId for recruiterId: " + recruiterId, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return null;
    }

    public Company findById(int id) {
        String sql = "SELECT c.*, u.full_name as recruiter_name, u.email as recruiter_email " +
                     "FROM companies c " +
                     "JOIN users u ON c.recruiter_id = u.id " +
                     "WHERE c.id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapCompany(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findById for company id: " + id, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return null;
    }

    public int createCompany(Company c) {
        String sql = "INSERT INTO companies (recruiter_id, company_name, industry, website, location, about, logo_url) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, c.getRecruiterId());
            ps.setString(2, c.getCompanyName());
            ps.setString(3, c.getIndustry());
            ps.setString(4, c.getWebsite());
            ps.setString(5, c.getLocation());
            ps.setString(6, c.getAbout());
            ps.setString(7, c.getLogoUrl());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in createCompany for recruiterId: " + c.getRecruiterId(), e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return -1;
    }

    public boolean updateCompany(Company c) {
        String sql = "UPDATE companies SET company_name = ?, industry = ?, website = ?, " +
                     "location = ?, about = ?, logo_url = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, c.getCompanyName());
            ps.setString(2, c.getIndustry());
            ps.setString(3, c.getWebsite());
            ps.setString(4, c.getLocation());
            ps.setString(5, c.getAbout());
            ps.setString(6, c.getLogoUrl());
            ps.setInt(7, c.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in updateCompany for company id: " + c.getId(), e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }

    public List<Company> findAll() {
        List<Company> list = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as recruiter_name, u.email as recruiter_email " +
                     "FROM companies c JOIN users u ON c.recruiter_id = u.id ORDER BY c.company_name ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapCompany(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findAll companies", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    private Company mapCompany(ResultSet rs) throws SQLException {
        Company c = new Company();
        c.setId(rs.getInt("id"));
        c.setRecruiterId(rs.getInt("recruiter_id"));
        c.setCompanyName(rs.getString("company_name"));
        c.setIndustry(rs.getString("industry"));
        c.setWebsite(rs.getString("website"));
        c.setLocation(rs.getString("location"));
        c.setAbout(rs.getString("about"));
        c.setLogoUrl(rs.getString("logo_url"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        c.setUpdatedAt(rs.getTimestamp("updated_at"));

        c.setRecruiterName(rs.getString("recruiter_name"));
        c.setRecruiterEmail(rs.getString("recruiter_email"));
        return c;
    }
}
