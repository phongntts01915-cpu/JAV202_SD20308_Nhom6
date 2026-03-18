// src/main/java/com/polycoffee/util/DBConnect.java
package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {
    // THAY ĐỔI DỮ LIỆU KẾT NỐI TẠI ĐÂY
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=PolyCoffeeDB;encrypt=false";
    private static final String USER = "sa";
    private static final String PASS = "1234";

    public static Connection getConnection() throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}