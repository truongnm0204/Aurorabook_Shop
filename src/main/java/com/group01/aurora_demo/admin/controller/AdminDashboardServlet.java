package com.group01.aurora_demo.admin.controller;

import java.io.IOException;
import java.util.List;

import com.group01.aurora_demo.catalog.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet{
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        req.getRequestDispatcher("/WEB-INF/views/admin/adminDashboard.jsp").forward(req, resp);
            
    }
}
