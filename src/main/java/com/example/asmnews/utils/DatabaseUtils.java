package com.example.asmnews.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class để quản lý kết nối database
 */
public class DatabaseUtils {
    // Thông tin kết nối database
    private static final String SERVER = "localhost";
    private static final String PORT = "1433";
    private static final String DATABASE = "ASM_NEWS";
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "1234";

    // URL kết nối
    private static final String URL = "jdbc:sqlserver://" + SERVER + ":" + PORT +
            ";databaseName=" + DATABASE +
            ";encrypt=false;trustServerCertificate=true";

    // Load driver
    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            System.err.println("Không thể load SQL Server JDBC Driver: " + e.getMessage());
        }
    }

    /**
     * Tạo kết nối đến database
     * 
     * @return Connection object
     * @throws SQLException nếu không thể kết nối
     */
    public static Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Kết nối database thành công!");
            return conn;
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối database: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Đóng kết nối database
     * 
     * @param conn Connection cần đóng
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Đã đóng kết nối database");
            } catch (SQLException e) {
                System.err.println("Lỗi khi đóng kết nối: " + e.getMessage());
            }
        }
    }

    /**
     * Test kết nối database
     * 
     * @return true nếu kết nối thành công
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Test kết nối thất bại: " + e.getMessage());
            return false;
        }
    }
}
