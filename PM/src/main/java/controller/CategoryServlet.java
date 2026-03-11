package controller;

import dao.ICategoryDAO;
import dao.impl.CategoryDAOImpl;
import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "CategoryServlet", urlPatterns = { "/admin/categories" })
public class CategoryServlet extends HttpServlet {

    private ICategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "delete":
                    int id = Integer.parseInt(req.getParameter("id"));

                    // 👉 LOGIC BẢO VỆ KHOÁ NGOẠI
                    if (categoryDAO.checkHasProducts(id)) {
                        req.setAttribute("error",
                                "Không thể xóa! Danh mục này đang chứa sản phẩm. Vui lòng chuyển sản phẩm sang danh mục khác trước.");
                        listCategories(req, resp);
                        return;
                    }

                    categoryDAO.delete(id);
                    resp.sendRedirect(req.getContextPath() + "/admin/categories");
                    break;
                case "list":
                default:
                    listCategories(req, resp);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi: " + e.getMessage());
            listCategories(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {

            // ==========================================
            // CHỖ LẤY DỮ LIỆU TỪ FORM (SỬA Ở ĐÂY NẾU CẦN)
            // ==========================================
            String name = req.getParameter("name");
            String description = req.getParameter("description");

            if (name == null || name.trim().isEmpty()) {
                req.setAttribute("error", "Tên danh mục không được để trống!");
                listCategories(req, resp);
                return;
            }

            // Đóng gói và lưu DB
            Category newCat = new Category(0, name, description);
            categoryDAO.insert(newCat);

            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    private void listCategories(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("categories", categoryDAO.findAll());
        req.getRequestDispatcher("/views/admin/categories.jsp").forward(req, resp);
    }
}