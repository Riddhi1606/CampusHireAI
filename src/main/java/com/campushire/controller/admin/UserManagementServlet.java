package com.campushire.controller.admin;

import com.campushire.model.User;
import com.campushire.service.AdminService;
import com.campushire.util.Validator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller for managing platform users, status toggles, and access permissions.
 */
@WebServlet("/admin/users")
public class UserManagementServlet extends HttpServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = adminService.getAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        int userId = Validator.parseIntSafe(req.getParameter("userId"), 0);

        if (userId > 0) {
            if ("activate".equalsIgnoreCase(action)) {
                adminService.toggleUserStatus(userId, true);
                req.getSession().setAttribute("flashSuccess", "User activated.");
            } else if ("deactivate".equalsIgnoreCase(action)) {
                adminService.toggleUserStatus(userId, false);
                req.getSession().setAttribute("flashSuccess", "User deactivated.");
            } else if ("delete".equalsIgnoreCase(action)) {
                adminService.deleteUser(userId);
                req.getSession().setAttribute("flashSuccess", "User account removed.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}
