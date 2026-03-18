package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatabaseManager {
    // THÔNG SỐ KẾT NỐI (Đã sử dụng thông số bạn cung cấp)
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    // Đã thay đổi encrypt=true thành false để tăng tính tương thích, nếu không chạy được bạn thử lại với true
    private static final String DBURL = "jdbc:sqlserver://localhost:1433;databaseName=assigment;encrypt=false;trustServerCertificate=true";
    private static final String USER = "sa";
    private static final String PASS = "123456";
    private static final Logger LOGGER = Logger.getLogger(DatabaseManager.class.getName());

    /**
     * Phương thức lấy đối tượng Connection đến cơ sở dữ liệu.
     * * @return Connection đến cơ sở dữ liệu, hoặc null nếu kết nối thất bại.
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Đăng ký Driver JDBC
            // Class.forName("com.mysql.cj.jdbc.Driver"); // Đối với JDBC 4.0 trở lên, bước này thường không cần thiết
            
            // Thiết lập kết nối
            connection = DriverManager.getConnection(jdbc:sqlserver,sa, 123456);
            LOGGER.info("Kết nối database thành công.");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "LỖI KẾT NỐI DATABASE!", e);
            // In thông báo chi tiết lỗi SQL để debug
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
        }
        return connection;
    }

    /**
     * Phương thức đóng đối tượng Connection một cách an toàn.
     * * @param connection Đối tượng Connection cần đóng.
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                LOGGER.info("Đóng kết nối database thành công.");
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "LỖI ĐÓNG KẾT NỐI DATABASE!", e);
            }
        }
    }
    
    // Phương thức main để kiểm tra kết nối (Test)
    public static void main(String[] args) {
        Connection conn = getConnection();
        if (conn != null) {
            System.out.println("Kiểm tra kết nối: OK");
            closeConnection(conn);
        } else {
            System.out.println("Kiểm tra kết nối: FAILED");
        }
    }
}