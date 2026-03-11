// src/main/java/dao/impl/ProductDAOImpl.java
package dao.impl;

import dao.IProductDAO;
import entity.Product;
import util.DBConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOImpl implements IProductDAO {

    @Override
    public List<Product> findAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("id"), rs.getString("name"), rs.getDouble("price"),
                        rs.getInt("categoryId"), rs.getString("image"),
                        rs.getString("description"), rs.getBoolean("status")));
            }
        } catch (Exception e) {
            e.printStackTrace(); // Tốt nhất nên dùng Logger (Log4j/SLF4J)
        }
        return list;
    }

    // Các hàm insert, update, delete làm tương tự, nhớ dùng dấu `?` trong
    // PreparedStatement để chống SQL Injection.
    @Override
    public boolean insert(Product p) {
        String sql = "INSERT INTO Products (name, price, categoryId, image, description, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setDouble(2, p.getPrice());
            ps.setInt(3, p.getCategoryId());
            ps.setString(4, p.getImage());
            ps.setString(5, p.getDescription());
            ps.setBoolean(6, p.isStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Abstract các hàm còn lại để giữ code ngắn gọn...
    @Override
    public Product findById(int id) {
        return null;
    }

    @Override
    public boolean update(Product p) {
        return false;
    }

    @Override
    public boolean delete(int id) {
        return false;
    }
}