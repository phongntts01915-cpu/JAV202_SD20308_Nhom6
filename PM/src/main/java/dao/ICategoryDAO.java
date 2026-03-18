package dao;

import entity.Category;
import java.util.List;

// Interface định nghĩa hợp đồng cho Category
public interface ICategoryDAO {

    // Lấy toàn bộ danh mục
    List<Category> findAll();

    // Thêm danh mục mới
    boolean insert(Category c);

    // Kiểm tra xem danh mục có chứa sản phẩm nào không (Để chống lỗi khóa ngoại khi
    // xóa)
    boolean checkHasProducts(int categoryId);

    // Xóa danh mục theo ID
    boolean delete(int id);

}