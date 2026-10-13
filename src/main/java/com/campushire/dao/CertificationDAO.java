package com.campushire.dao;

import com.campushire.model.Certification;
import com.campushire.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Student Certifications.
 */
public class CertificationDAO {

    private static final Logger LOGGER = Logger.getLogger(CertificationDAO.class.getName());

    public List<Certification> findByStudentId(int studentId) {
        List<Certification> list = new ArrayList<>();
        String sql = "SELECT id, student_id, name, issuing_organization, issue_date, credential_url, created_at " +
                     "FROM certifications WHERE student_id = ? ORDER BY issue_date DESC, created_at DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Certification c = new Certification();
                c.setId(rs.getInt("id"));
                c.setStudentId(rs.getInt("student_id"));
                c.setName(rs.getString("name"));
                c.setIssuingOrganization(rs.getString("issuing_organization"));
                c.setIssueDate(rs.getDate("issue_date"));
                c.setCredentialUrl(rs.getString("credential_url"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(c);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findByStudentId for certifications: " + studentId, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public int createCertification(Certification cert) {
        String sql = "INSERT INTO certifications (student_id, name, issuing_organization, issue_date, credential_url) " +
                     "VALUES (?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, cert.getStudentId());
            ps.setString(2, cert.getName());
            ps.setString(3, cert.getIssuingOrganization());
            ps.setDate(4, cert.getIssueDate());
            ps.setString(5, cert.getCredentialUrl());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in createCertification", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return -1;
    }

    public boolean deleteCertification(int id, int studentId) {
        String sql = "DELETE FROM certifications WHERE id = ? AND student_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setInt(2, studentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in deleteCertification id: " + id, e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }
}
