package modal;

import utils.UserHandle;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Payment {
    private String paymentId;
    private User user;
    private double amount;
    private String paymentMethod; // cod, card, upi
    private String status; // pending, completed, failed, refunded
    private String paymentDate;

    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public Payment(double amount, String paymentMethod, User user) {
        this.paymentId = null;
        this.user = user;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.status = "pending";
        this.paymentDate = LocalDateTime.now().format(formatter);
    }

    public Payment(String paymentId, double amount, String paymentMethod, String status, String paymentDate, User user) {
        this.paymentId = paymentId;
        this.user = user;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.paymentDate = paymentDate;
    }

    // Getters and Setters
    public String getPaymentId() { 
        return paymentId; 
    }
    public void setPaymentId(String paymentId) { 
        this.paymentId = paymentId; 
    }
    public User getUser() { 
        return user; 
    }
    public void setUser(User user) { 
        this.user = user; 
    }
    public double getAmount() { 
        return amount; 
    }
    public void setAmount(double amount) { 
        this.amount = amount; 
    }
    public String getPaymentMethod() { 
        return paymentMethod; 
    }
    public void setPaymentMethod(String paymentMethod) { 
        this.paymentMethod = paymentMethod; 
    }
    public String getStatus() { 
        return status; 
    }
    public void setStatus(String status) { 
        this.status = status; 
    }
    public String getPaymentDate() { 
        return paymentDate; 
    }
    public void setPaymentDate(String paymentDate) { 
        this.paymentDate = paymentDate; 
    }

    public String paymentToString() {
        return paymentId + "|" + amount + "|" + paymentMethod + "|" + status + "|" + paymentDate + "|" + user.getUserId();
    }

    public static Payment fromString(String str) {
        String[] parts = str.split("\\|");
        if (parts.length == 6) {
            User user = UserHandle.findUserById(Integer.parseInt(parts[5]));
            return new Payment(parts[0], Double.parseDouble(parts[1]), parts[2], parts[3], parts[4], user);
        }
        System.out.println("Invalid payment string format");
        return null;
    }
}
