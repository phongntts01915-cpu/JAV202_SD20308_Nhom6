// src/main/java/com/polycoffee/entity/Product.java
package entity;

// Entity thuần tuý (POJO)
public class Product {
    private int id;
    private String name;
    private double price;
    private int categoryId;
    private String image;
    private String description;
    private boolean status;

    // LƯU Ý: Tự generate Getters, Setters, Constructors để tiết kiệm diện tích code
    public Product(int id, String name, double price, int categoryId, String image, String description,
            boolean status) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.categoryId = categoryId;
        this.image = image;
        this.description = description;
        this.status = status;
    }

    // ... Getters & Setters
    // Getters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getImage() {
        return image;
    }

    public String getDescription() {
        return description;
    }

    public boolean isStatus() {
        return status;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}