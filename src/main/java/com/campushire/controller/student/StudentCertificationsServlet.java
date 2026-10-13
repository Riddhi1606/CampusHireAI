package com.campushire.controller.student;

import com.campushire.model.Certification;
import com.campushire.model.Student;
import com.campushire.model.User;
import com.campushire.service.StudentService;
import com.campushire.util.DateUtil;
import com.campushire.util.Validator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller for Student Certifications management.
 */
@WebServlet("/student/certifications")
public class StudentCertificationsServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        req.setAttribute("student", student);
        req.setAttribute("certifications", student.getCertifications());
        req.getRequestDispatcher("/WEB-INF/views/student/certifications.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Student student = studentService.getStudentByUserId(user.getId());

        String action = req.getParameter("action");
        if ("add".equalsIgnoreCase(action)) {
            String name = req.getParameter("name");
            String issuingOrg = req.getParameter("issuingOrganization");
            String issueDateStr = req.getParameter("issueDate");
            String credentialUrl = req.getParameter("credentialUrl");

            if (Validator.isNotEmpty(name) && Validator.isNotEmpty(issuingOrg)) {
                Certification c = new Certification();
                c.setStudentId(student.getId());
                c.setName(name.trim());
                c.setIssuingOrganization(issuingOrg.trim());
                c.setIssueDate(DateUtil.parseSqlDate(issueDateStr));
                c.setCredentialUrl(credentialUrl);

                studentService.addCertification(c);
                session.setAttribute("flashSuccess", "Certification added successfully!");
            }
        } else if ("delete".equalsIgnoreCase(action)) {
            int certId = Validator.parseIntSafe(req.getParameter("certId"), 0);
            if (certId > 0) {
                studentService.removeCertification(certId, student.getId());
                session.setAttribute("flashSuccess", "Certification removed.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/student/certifications");
    }
}
