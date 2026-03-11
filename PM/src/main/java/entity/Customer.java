package entity;

public class Customer {

    private int id;
    private String fullname;
    private String email;
    private String phone;
    private String address;
    private String username;
    private String password;

    public Customer() {
    }

    public Customer(int id, String fullname, String email, String phone,
            String address, String username, String password) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.username = username;
        this.password = password;
    }

    // ===== Getter =====

    public int getId() {
        return id;
    }

    public String getFullname() {
        return fullname;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public String getAddress() {
        return address;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    // ===== Setter =====

    public void setId(int id) {
        this.id = id;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}