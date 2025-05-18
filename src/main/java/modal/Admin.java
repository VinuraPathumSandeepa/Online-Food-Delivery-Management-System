package modal;

public class Admin extends User {
    public Admin(String firstName, String lastName, String email, String phoneNumber, String password) {
        super(firstName, lastName, email, phoneNumber, password, "admin");
    }

    public Admin(int userId, String firstName, String lastName, String email, String phoneNumber, String password) {
        super(userId, firstName, lastName, email, phoneNumber, password, "admin");
    }

    @Override
    public boolean isAdmin() {
        return true;
    }

    @Override
    public String getRoleDescription() {
        return "Administrator";
    }

    @Override
    public String userToString() {
        return "admin" + "|" + userId + "|" + firstName + "|" + lastName + "|" + email + "|" + phoneNumber + "|" + password;
    }
}