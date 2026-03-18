package controller;

import dao.IStatDAO;
import dao.impl.StatDAOImpl;
import dao.impl.BillDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;
import java.util.Calendar;

@WebServlet(name = "DashboardServlet", urlPatterns = { "/admin/dashboard" })
public class DashboardServlet extends HttpServlet {

    private IStatDAO statDAO;
    private BillDAOImpl billDAO;

    @Override
    public void init() throws ServletException {
        statDAO = new StatDAOImpl();
        billDAO = new BillDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            // =========================
            // 1. Thống kê cơ bản
            // =========================
            int totalUsers = statDAO.getTotalUsers();
            int totalProducts = statDAO.getTotalProducts();
            int totalCategories = statDAO.getTotalCategories();

            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("totalProducts", totalProducts);
            req.setAttribute("totalCategories", totalCategories);

            // =========================
            // 2. Thống kê doanh thu theo tháng
            // =========================
            int currentYear = Calendar.getInstance().get(Calendar.YEAR);

            double[] monthlyRevenue = billDAO.getRevenueByMonth(currentYear);

            StringBuilder revenueStr = new StringBuilder("[");
            for (int i = 0; i < 12; i++) {
                revenueStr.append(monthlyRevenue[i]);
                if (i < 11) {
                    revenueStr.append(",");
                }
            }
            revenueStr.append("]");

            req.setAttribute("revenueData", revenueStr.toString());

            // =========================
            // 3. Top sản phẩm bán chạy
            // =========================
            Map<String, Integer> topProducts = billDAO.getTopSellingProducts();
            req.setAttribute("topProducts", topProducts);

            // =========================
            // 4. Forward sang JSP
            // =========================
            req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", "Không thể tải dữ liệu Dashboard: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/error.jsp").forward(req, resp);
        }
    }
}