package com.campushire.dao;

import com.campushire.model.Student;
import com.campushire.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Student profile management.
 */
public class StudentDAO {

    private static final Logger LOGGER = Logger.getLogger(StudentDAO.class.getName());

    public Student findByUserId(int userId) {
        String sql = "SELECT s.*, u.full_name, u.email " +
                     "FROM students s " +
                     "JOIN users u ON s.user_id = u.id " +
                     "WHERE s.user_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapStudent(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findByUserId for userId: " + userId, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return null;
    }

    public Student findById(int id) {
        String sql = "SELECT s.*, u.full_name, u.email " +
                     "FROM students s " +
                     "JOIN users u ON s.user_id = u.id " +
                     "WHERE s.id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapStudent(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findById for student id: " + id, e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return null;
    }

    public int createStudent(Student s) {
        String sql = "INSERT INTO students (user_id, college_name, degree, branch, cgpa, graduation_year, " +
                     "roll_number, phone, bio, resume_url, github_url, linkedin_url) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, s.getUserId());
            ps.setString(2, s.getCollegeName());
            ps.setString(3, s.getDegree() != null ? s.getDegree() : "B.Tech");
            ps.setString(4, s.getBranch());
            ps.setDouble(5, s.getCgpa());
            ps.setInt(6, s.getGraduationYear());
            ps.setString(7, s.getRollNumber());
            ps.setString(8, s.getPhone());
            ps.setString(9, s.getBio());
            ps.setString(10, s.getResumeUrl());
            ps.setString(11, s.getGithubUrl());
            ps.setString(12, s.getLinkedinUrl());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in createStudent for userId: " + s.getUserId(), e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return -1;
    }

    public boolean updateProfile(Student s) {
        String sql = "UPDATE students SET college_name = ?, degree = ?, branch = ?, cgpa = ?, " +
                     "graduation_year = ?, roll_number = ?, phone = ?, bio = ?, resume_url = ?, " +
                     "github_url = ?, linkedin_url = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, s.getCollegeName());
            ps.setString(2, s.getDegree());
            ps.setString(3, s.getBranch());
            ps.setDouble(4, s.getCgpa());
            ps.setInt(5, s.getGraduationYear());
            ps.setString(6, s.getRollNumber());
            ps.setString(7, s.getPhone());
            ps.setString(8, s.getBio());
            ps.setString(9, s.getResumeUrl());
            ps.setString(10, s.getGithubUrl());
            ps.setString(11, s.getLinkedinUrl());
            ps.setInt(12, s.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in updateProfile for student id: " + s.getId(), e);
        } finally {
            DBConnection.closeQuietly(ps, conn);
        }
        return false;
    }

    public List<Student> findAllStudents() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT s.*, u.full_name, u.email FROM students s " +
                     "JOIN users u ON s.user_id = u.id ORDER BY s.cgpa DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapStudent(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in findAllStudents", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return list;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM students";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error in countAll students", e);
        } finally {
            DBConnection.closeQuietly(rs, ps, conn);
        }
        return 0;
    }

    private Student mapStudent(ResultSet rs) throws SQLException {
        Student s = new Student();
        s.setId(rs.getInt("id"));
        s.setUserId(rs.getInt("user_id"));
        s.setCollegeName(rs.getString("college_name"));
        s.setDegree(rs.getString("degree"));
        s.setBranch(rs.getString("branch"));
        s.setCgpa(rs.getDouble("cgpa"));
        s.setGraduationYear(rs.getInt("graduation_year"));
        s.setRollNumber(rs.getString("roll_number"));
        s.setPhone(rs.getString("phone"));
        s.setBio(rs.getString("bio"));
        s.setResumeUrl(rs.getString("resume_url"));
        s.setGithubUrl(rs.getString("github_url"));
        s.setLinkedinUrl(rs.getString("linkedin_url"));
        s.setCreatedAt(rs.getTimestamp("created_at"));
        s.setUpdatedAt(rs.getTimestamp("updated_at"));

        s.setFullName(rs.getString("full_name"));
        s.setEmail(rs.getString("email"));
        return s;
    }
}
