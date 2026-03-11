// src/main/java/com/polycoffee/dao/IProductDAO.java
package dao;
import entity.Product;
import java.util.List;

// Interface định nghĩa Hợp đồng (Contract) - Interface Segregation
public interface IProductDAO {
    List<Product> findAll();
    Product findById(int id);
    boolean insert(Product p);
    boolean update(Product p);
    boolean delete(int id);
}