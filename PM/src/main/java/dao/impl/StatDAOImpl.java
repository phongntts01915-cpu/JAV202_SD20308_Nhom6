// src/main/java/dao/impl/StatDAOImpl.java
package dao.impl;

import dao.IStatDAO;
import util.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StatDAOImpl implements IStatDAO {

    // Hàm dùng chung để đếm số lượng dòng của 1 bảng
    private int countTable(String tableName) {
        // Ghi chú: Chỉ truyền tên bảng cố định trong code, KHÔNG nhận từ người dùng để
        // tránh SQL Injection
        String sql = "SELECT COUNT(*) FROM " + tableName;
        try (Connection conn = DBConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next())
                return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int getTotalUsers() {
        return countTable("Users");
    }

    @Override
    public int getTotalProducts() {
        return countTable("Products");
    }

    @Override
    public int getTotalCategories() {
        return countTable("Categories");
    }
}