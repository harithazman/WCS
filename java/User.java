public class User {
    // Fields to store user data
    private int userId;
    private String username;
    private String password;
    private String role;
    private String email;

    // Default constructor
    public User() {
    }

    // Constructor with parameters to initialize all fields
    public User(int userId, String username, String password, String role, String email) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.role = role;
        this.email = email;
    }

    User(int aInt, String string) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    // Getter and Setter methods for each field

    // Getters and Setters for userId
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    // Getters and Setters for username
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    // Getters and Setters for password
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // Getters and Setters for role
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // Getters and Setters for email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // Optional: You can override toString() method for easier debugging
    @Override
    public String toString() {
        return "User [userId=" + userId + ", username=" + username + ", password=" + password + ", role=" + role
                + ", email=" + email + "]";
    }
}
