package com.campushire.dao;

import com.campushire.model.Project;
import com.campushire.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Student Projects.
 */
public class ProjectDAO {

    private static final Logger LOGGER = Logger.getLogger(ProjectDAO.class.getName());

    public List<Project> findByStudentId(int studentId) {
        List<Project> list = new ArrayList<>();
        String sql = "SELECT id, student_id, title, description, tech_stack, project_url, github_url, created_at " +
                     "FROM projects WHERE student_id = ? ORDER BY created_at DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Project p = new Project();
                p.setId(rs.getInt("id"));
                p.setStudentId(rs.getInt("student_id"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setTechStack(rs.getString("tech_stack"));
                p.setProjectUrl(rs.getString("project_url"));
                p.setGithubUrl(rs.getString("github_url"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(p);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findByStudentId for student: " + studentId, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public int createProject(Project project) {
        String sql = "INSERT INTO projects (student_id, title, description, tech_stack, project_url, github_url) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, project.getStudentId());
            ps.setString(2, project.getTitle());
            ps.setString(3, project.getDescription());
            ps.setString(4, project.getTechStack());
            ps.setString(5, project.getProjectUrl());
            ps.setString(6, project.getGithubUrl());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in createProject", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return -1;
    }

    public boolean deleteProject(int id, int studentId) {
        String sql = "DELETE FROM projects WHERE id = ? AND student_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setInt(2, studentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in deleteProject id: " + id, e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }
}
