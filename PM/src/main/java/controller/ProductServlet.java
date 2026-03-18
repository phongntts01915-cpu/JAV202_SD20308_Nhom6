// src/main/java/controller/ProductServlet.java
package controller;

import dao.IProductDAO;
import dao.impl.ProductDAOImpl;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ProductServlet", urlPatterns = { "/admin/products" })
public class ProductServlet extends HttpServlet {

    private IProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "delete":
                    deleteProduct(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "list":
                default:
                    listProducts(req, resp);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/views/admin/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("add".equals(action)) {
                addProduct(req, resp);
            } else if ("update".equals(action)) {
                updateProduct(req, resp);
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Lỗi định dạng số (Giá tiền hoặc ID không hợp lệ)!");
            listProducts(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
            listProducts(req, resp);
        }
    }

    // --- CÁC HÀM XỬ LÝ CHI TIẾT ---

    private void listProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("products", productDAO.findAll());
        req.getRequestDispatcher("/views/admin/products.jsp").forward(req, resp);
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        productDAO.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product existingProduct = productDAO.findById(id);
        req.setAttribute("product", existingProduct);
        req.getRequestDispatcher("/views/admin/product_edit.jsp").forward(req, resp);
    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        // Ghi chú: THAY ĐỔI CÁC TRƯỜNG DỮ LIỆU TẠI ĐÂY NẾU BẠN SỬA DATABASE (Tương
        // đương dòng 82-83 cũ)
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        String categoryIdStr = req.getParameter("categoryId");

        // Thêm các trường mới nếu có ở HTML Form
        // String image = req.getParameter("image");
        // String description = req.getParameter("description");

        // 1. Server-side validation
        if (name == null || name.trim().isEmpty() || priceStr == null || priceStr.trim().isEmpty()) {
            req.setAttribute("error", "Không được để trống Tên và Giá");
            listProducts(req, resp);
            return;
        }

        double price = Double.parseDouble(priceStr);
        if (price <= 0) {
            req.setAttribute("error", "Giá phải lớn hơn 0");
            listProducts(req, resp);
            return;
        }

        int categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : 1;

        // 2. Map dữ liệu vào Entity (Tương đương dòng 95 cũ)
        // Ghi chú: DÒNG NÀY ĐỂ THAY ĐỔI GIÁ TRỊ MẶC ĐỊNH KHI THÊM
        Product newProduct = new Product(0, name, price, categoryId, "", "Mô tả mặc định", true);

        // Nếu lấy dữ liệu từ form đầy đủ, bạn sửa lại như sau:
        // Product newProduct = new Product(0, name, price, categoryId, image,
        // description, true);

        // 3. Gọi DAO lưu xuống DB
        productDAO.insert(newProduct);
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        // 1. Lấy dữ liệu từ form (Bao gồm cả ID để biết sửa bản ghi nào)
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        String categoryIdStr = req.getParameter("categoryId");
        String statusStr = req.getParameter("status"); // Thường là checkbox hoặc radio

        // Validation cơ bản
        if (name == null || name.trim().isEmpty() || priceStr == null || priceStr.trim().isEmpty()) {
            req.setAttribute("error", "Không được để trống Tên và Giá khi cập nhật");
            showEditForm(req, resp); // Quay lại trang sửa
            return;
        }

        double price = Double.parseDouble(priceStr);
        int categoryId = (categoryIdStr != null && !categoryIdStr.isEmpty()) ? Integer.parseInt(categoryIdStr) : 1;
        boolean status = statusStr != null && statusStr.equals("true"); // Ví dụ cách xử lý status

        // 2. Map dữ liệu vào Entity
        Product updateProd = new Product(id, name, price, categoryId, "", "Mô tả cập nhật", status);

        // 3. Gọi DAO update
        productDAO.update(updateProd);
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}