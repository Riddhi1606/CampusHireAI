package com.campushire.service;

import com.campushire.dao.CompanyDAO;
import com.campushire.dao.StudentDAO;
import com.campushire.dao.UserDAO;
import com.campushire.model.Company;
import com.campushire.model.Student;
import com.campushire.model.User;
import com.campushire.util.PasswordUtil;

import java.util.logging.Logger;

/**
 * Authentication and Registration Service enforcing BCrypt password security
 * and atomic user profile initialization.
 */
public class AuthService {

    private static final Logger LOGGER = Logger.getLogger(AuthService.class.getName());

    private final UserDAO userDAO = new UserDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final CompanyDAO companyDAO = new CompanyDAO();

    public User login(String email, String password) {
        if (email == null || password == null) return null;
        User user = userDAO.findByEmail(email);
        if (user != null && user.isActive()) {
            if (PasswordUtil.checkPassword(password, user.getPassword())) {
                return user;
            }
        }
        return null;
    }

    public User registerStudent(String fullName, String email, String plainPassword,
                                String collegeName, String branch, double cgpa, int graduationYear) {
        if (userDAO.findByEmail(email) != null) {
            return null; // Email already in use
        }

        String hashedPassword = PasswordUtil.hashPassword(plainPassword);
        User user = new User();
        user.setEmail(email.trim().toLowerCase());
        user.setPassword(hashedPassword);
        user.setRole(User.Role.STUDENT);
        user.setFullName(fullName.trim());
        user.setActive(true);

        int userId = userDAO.createUser(user);
        if (userId > 0) {
            user.setId(userId);
            Student student = new Student();
            student.setUserId(userId);
            student.setCollegeName(collegeName != null ? collegeName.trim() : "College of Engineering");
            student.setDegree("B.Tech");
            student.setBranch(branch != null ? branch.trim() : "Computer Science and Engineering");
            student.setCgpa(cgpa);
            student.setGraduationYear(graduationYear > 0 ? graduationYear : 2026);
            studentDAO.createStudent(student);
            return user;
        }
        return null;
    }

    public User registerRecruiter(String fullName, String email, String plainPassword,
                                  String companyName, String industry, String location) {
        if (userDAO.findByEmail(email) != null) {
            return null; // Email already in use
        }

        String hashedPassword = PasswordUtil.hashPassword(plainPassword);
        User user = new User();
        user.setEmail(email.trim().toLowerCase());
        user.setPassword(hashedPassword);
        user.setRole(User.Role.RECRUITER);
        user.setFullName(fullName.trim());
        user.setActive(true);

        int userId = userDAO.createUser(user);
        if (userId > 0) {
            user.setId(userId);
            Company company = new Company();
            company.setRecruiterId(userId);
            company.setCompanyName(companyName != null ? companyName.trim() : "Tech Solutions Inc.");
            company.setIndustry(industry != null ? industry.trim() : "Technology");
            company.setLocation(location != null ? location.trim() : "Pan India");
            companyDAO.createCompany(company);
            return user;
        }
        return null;
    }
}
