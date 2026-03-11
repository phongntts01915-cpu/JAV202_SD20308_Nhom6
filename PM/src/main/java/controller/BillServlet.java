package controller;

import dao.impl.BillDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "BillServlet", urlPatterns = { "/admin/bills" })
public class BillServlet extends HttpServlet {
    private BillDAOImpl billDAO = new BillDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String role = (String) session.getAttribute("USER_ROLE");
        Integer userId = (Integer) session.getAttribute("USER_ID");

        if (role == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // --- XỬ LÝ HÀNH ĐỘNG SỬA TRẠNG THÁI (THANH TOÁN) ---
        String action = req.getParameter("action");
        if ("markPaid".equals(action)) {
            int billId = Integer.parseInt(req.getParameter("id"));
            billDAO.updateBillStatus(billId, 1); // 1 = Đã thanh toán
            session.setAttribute("toastMsg", "Đã chốt thanh toán hóa đơn #" + billId);
            session.setAttribute("toastType", "success");
            resp.sendRedirect(req.getContextPath() + "/admin/bills");
            return;
        }

        // --- PHÂN LUỒNG HIỂN THỊ THEO ĐÚNG YÊU CẦU ---
        if ("ADMIN".equals(role)) {
            // Quản lý: Xem TẤT CẢ hóa đơn
            req.setAttribute("bills", billDAO.findAllWithDetails());
        } else if ("STAFF".equals(role)) {
            // Nhân viên: CHỈ XEM hóa đơn DO MÌNH TẠO
            req.setAttribute("bills", billDAO.findByStaffIdWithDetails(userId));
        }

        req.getRequestDispatcher("/views/admin/bills.jsp").forward(req, resp);
    }
}