package com.group01.aurora_demo.admin.controller;

import com.group01.aurora_demo.admin.dao.VoucherDAO;
import com.group01.aurora_demo.admin.model.Voucher;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "VoucherManagementServlet", urlPatterns = {
    "/admin/vouchers",
    "/admin/vouchers/create",
    "/admin/vouchers/edit",
    "/admin/vouchers/delete",
    "/admin/vouchers/view"
})
public class VoucherManagementServlet extends HttpServlet {
    
    private final VoucherDAO voucherDAO = new VoucherDAO();
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        String action = request.getPathInfo();
        
        if (action == null) {
            action = "";
        }
        
        if (path.equals("/admin/vouchers/view")) {
            viewVoucher(request, response);
        } else if (path.equals("/admin/vouchers/create")) {
            showCreateForm(request, response);
        } else if (path.equals("/admin/vouchers/edit")) {
            showEditForm(request, response);
        } else {
            listVouchers(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        
        if (path.equals("/admin/vouchers/create")) {
            createVoucher(request, response);
        } else if (path.equals("/admin/vouchers/edit")) {
            updateVoucher(request, response);
        } else if (path.equals("/admin/vouchers/delete")) {
            deleteVoucher(request, response);
        }
    }
    
    private void listVouchers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String statusFilter = request.getParameter("status");
        List<Voucher> vouchers;
        
        if (statusFilter != null && !statusFilter.isEmpty()) {
            vouchers = voucherDAO.getVouchersByStatus(statusFilter);
        } else {
            vouchers = voucherDAO.getAllVouchers();
        }
        
        int activeCount = voucherDAO.getActiveVouchersCount();
        int pendingCount = voucherDAO.getPendingVouchersCount();
        int expiredCount = voucherDAO.getExpiredVouchersCount();
        int totalUsageCount = voucherDAO.getTotalUsageCount();
        
        request.setAttribute("vouchers", vouchers);
        request.setAttribute("activeCount", activeCount);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("expiredCount", expiredCount);
        request.setAttribute("totalUsageCount", totalUsageCount);
        request.setAttribute("statusFilter", statusFilter);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/voucher_management.jsp").forward(request, response);
    }
    
    private void viewVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String voucherId = request.getParameter("id");
        
        if (voucherId != null && !voucherId.isEmpty()) {
            Optional<Voucher> optVoucher = voucherDAO.getVoucherById(Long.parseLong(voucherId));
            if (optVoucher.isPresent()) {
                request.setAttribute("voucher", optVoucher.get());
                request.getRequestDispatcher("/WEB-INF/views/admin/voucher_details.jsp").forward(request, response);
                return;
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=voucher_not_found");
    }
    
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> discountTypes = voucherDAO.getAllDiscountTypes();
        List<String> statusCodes = voucherDAO.getAllVoucherStatuses();
        
        request.setAttribute("discountTypes", discountTypes);
        request.setAttribute("statusCodes", statusCodes);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/voucher_create.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String voucherId = request.getParameter("id");
        
        if (voucherId != null && !voucherId.isEmpty()) {
            Optional<Voucher> optVoucher = voucherDAO.getVoucherById(Long.parseLong(voucherId));
            if (optVoucher.isPresent()) {
                List<String> discountTypes = voucherDAO.getAllDiscountTypes();
                List<String> statusCodes = voucherDAO.getAllVoucherStatuses();
                
                request.setAttribute("voucher", optVoucher.get());
                request.setAttribute("discountTypes", discountTypes);
                request.setAttribute("statusCodes", statusCodes);
                
                // Format dates for the form
                Voucher voucher = optVoucher.get();
                request.setAttribute("startAtFormatted", voucher.getStartAt().format(DATE_TIME_FORMATTER));
                request.setAttribute("endAtFormatted", voucher.getEndAt().format(DATE_TIME_FORMATTER));
                
                request.getRequestDispatcher("/WEB-INF/views/admin/voucher_create.jsp").forward(request, response);
                return;
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=voucher_not_found");
    }
    
    private void createVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Voucher voucher = extractVoucherFromRequest(request);
            voucher.setUsageCount(0);
            
            boolean success = voucherDAO.createVoucher(voucher);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/vouchers?success=voucher_created");
            } else {
                request.setAttribute("error", "Failed to create voucher");
                showCreateForm(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing voucher data: " + e.getMessage());
            showCreateForm(request, response);
        }
    }
    
    private void updateVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String voucherId = request.getParameter("id");
        
        if (voucherId != null && !voucherId.isEmpty()) {
            try {
                long id = Long.parseLong(voucherId);
                Optional<Voucher> existingVoucher = voucherDAO.getVoucherById(id);
                
                if (existingVoucher.isPresent()) {
                    Voucher voucher = extractVoucherFromRequest(request);
                    voucher.setVoucherId(id);
                    voucher.setUsageCount(existingVoucher.get().getUsageCount());
                    
                    boolean success = voucherDAO.updateVoucher(voucher);
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/admin/vouchers/view?id=" + id + "&success=voucher_updated");
                    } else {
                        request.setAttribute("error", "Failed to update voucher");
                        request.setAttribute("voucher", voucher);
                        request.getRequestDispatcher("/WEB-INF/views/admin/voucher_create.jsp").forward(request, response);
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=voucher_not_found");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin/vouchers/edit?id=" + voucherId + "&error=" + e.getMessage());
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=invalid_voucher_id");
        }
    }
    
    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String voucherId = request.getParameter("id");
        
        if (voucherId != null && !voucherId.isEmpty()) {
            try {
                long id = Long.parseLong(voucherId);
                boolean success = voucherDAO.deleteVoucher(id);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/vouchers?success=voucher_deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=delete_failed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=" + e.getMessage());
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/vouchers?error=invalid_voucher_id");
        }
    }
    
    private Voucher extractVoucherFromRequest(HttpServletRequest request) {
        Voucher voucher = new Voucher();
        
        String code = request.getParameter("code");
        String discountType = request.getParameter("discountType");
        String valueStr = request.getParameter("value");
        String maxAmountStr = request.getParameter("maxAmount");
        String minOrderAmountStr = request.getParameter("minOrderAmount");
        String startAtStr = request.getParameter("startAt");
        String endAtStr = request.getParameter("endAt");
        String usageLimitStr = request.getParameter("usageLimit");
        String perUserLimitStr = request.getParameter("perUserLimit");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        
        voucher.setCode(code);
        voucher.setDiscountType(discountType);
        voucher.setValue(new BigDecimal(valueStr));
        
        if (maxAmountStr != null && !maxAmountStr.isEmpty()) {
            voucher.setMaxAmount(new BigDecimal(maxAmountStr));
        }
        
        voucher.setMinOrderAmount(new BigDecimal(minOrderAmountStr));
        
        // Parse dates
        voucher.setStartAt(LocalDateTime.parse(startAtStr, DATE_TIME_FORMATTER));
        voucher.setEndAt(LocalDateTime.parse(endAtStr, DATE_TIME_FORMATTER));
        
        if (usageLimitStr != null && !usageLimitStr.isEmpty()) {
            voucher.setUsageLimit(Integer.parseInt(usageLimitStr));
        }
        
        if (perUserLimitStr != null && !perUserLimitStr.isEmpty()) {
            voucher.setPerUserLimit(Integer.parseInt(perUserLimitStr));
        }
        
        voucher.setStatus(status);
        voucher.setDescription(description);
        
        return voucher;
    }
}