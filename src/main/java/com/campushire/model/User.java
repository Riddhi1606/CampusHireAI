package com.campushire.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * User entity representing system authentication and basic profile.
 */
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    public enum Role {
        STUDENT, RECRUITER, ADMIN
    }

    private int id;
    private String email;
    private String password;
    private Role role;
    private String fullName;
    private boolean active;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public User() {}

    public User(int id, String email, String password, Role role, String fullName, boolean active) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.role = role;
        this.fullName = fullName;
        this.active = active;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", email='" + email + '\'' + ", role=" + role + ", fullName='" + fullName + '\'' + '}';
    }
}
