package modal;

public class User {
    protected int userId;
    protected String firstName;
    protected String lastName;
    protected String email;
    protected String phoneNumber;
    protected String password;
    protected String role; // customer, restaurant, delivery, admin

    public User(String firstName, String lastName, String email, String phoneNumber, String password, String role) {
        this.userId = -99;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
    }

    public User(int userId, String firstName, String lastName, String email, String phoneNumber, String password, String role) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.role = role;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public boolean isAdmin() {
        return role.equals("admin");
    }

    public boolean isCustomer() {
        return role.equals("customer");
    }

    public boolean isRestaurant() {
        return role.equals("restaurant");
    }

    public boolean isDelivery() {
        return role.equals("delivery");
    }

    public String getRoleDescription() {
        switch (role) {
            case "admin": return "Administrator";
            case "customer": return "Customer";
            case "restaurant": return "Restaurant Staff";
            case "delivery": return "Delivery Personnel";
            default: return "Unknown Role";
        }
    }

    public String userToString() {
        return role + "|" + userId + "|" + firstName + "|" + lastName + "|" + email + "|" + phoneNumber + "|" + password;
    }

    public static User stringToUser(String str) {
        String[] strArr = str.split("\\|");
        if (strArr.length == 7) {
            return new User(Integer.parseInt(strArr[1]), strArr[2], strArr[3], strArr[4], strArr[5], strArr[6], strArr[0]);
        } else {
            System.out.println("Invalid user string format");
            return null;
        }
    }
}