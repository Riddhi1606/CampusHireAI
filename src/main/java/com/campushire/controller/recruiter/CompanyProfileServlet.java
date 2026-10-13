package com.campushire.controller.recruiter;

import com.campushire.model.Company;
import com.campushire.model.User;
import com.campushire.service.RecruiterService;
import com.campushire.util.Validator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Controller for Recruiter Company Profile details management.
 */
@WebServlet("/recruiter/company-profile")
public class CompanyProfileServlet extends HttpServlet {

    private final RecruiterService recruiterService = new RecruiterService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");

        Company company = recruiterService.getCompanyByRecruiterId(user.getId());
        req.setAttribute("company", company);
        req.getRequestDispatcher("/WEB-INF/views/recruiter/company-profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("currentUser");
        Company company = recruiterService.getCompanyByRecruiterId(user.getId());

        if (company != null) {
            String companyName = req.getParameter("companyName");
            if (Validator.isNotEmpty(companyName)) {
                company.setCompanyName(companyName.trim());
            }
            company.setIndustry(req.getParameter("industry"));
            company.setWebsite(req.getParameter("website"));
            company.setLocation(req.getParameter("location"));
            company.setAbout(req.getParameter("about"));
            company.setLogoUrl(req.getParameter("logoUrl"));

            boolean ok = recruiterService.updateCompanyProfile(company);
            if (ok) {
                session.setAttribute("flashSuccess", "Company profile updated successfully!");
            } else {
                session.setAttribute("flashError", "Failed to update profile.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/recruiter/company-profile");
    }
}
