package modal;

import utils.OrderHandle;
import utils.UserHandle;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Delivery {
    private String deliveryId;
    private User deliveryPersonnel;
    private Order order;
    private String status; // assigned, dispatched, delivered
    private String estimatedDeliveryTime;
    private String deliveryDate;

    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public Delivery(User deliveryPersonnel, Order order, String estimatedDeliveryTime) {
        this.deliveryId = null;
        this.deliveryPersonnel = deliveryPersonnel;
        this.order = order;
        this.status = "assigned";
        this.estimatedDeliveryTime = estimatedDeliveryTime;
        this.deliveryDate = LocalDateTime.now().format(formatter);
    }

    public Delivery(String deliveryId, User deliveryPersonnel, Order order, String status, String estimatedDeliveryTime, String deliveryDate) {
        this.deliveryId = deliveryId;
        this.deliveryPersonnel = deliveryPersonnel;
        this.order = order;
        this.status = status;
        this.estimatedDeliveryTime = estimatedDeliveryTime;
        this.deliveryDate = deliveryDate;
    }

    // Getters and Setters
    public String getDeliveryId() { return deliveryId; }
    public void setDeliveryId(String deliveryId) { this.deliveryId = deliveryId; }
    public User getDeliveryPersonnel() { return deliveryPersonnel; }
    public void setDeliveryPersonnel(User deliveryPersonnel) { this.deliveryPersonnel = deliveryPersonnel; }
    public Order getOrder() { return order; }
    public void setOrder(Order order) { this.order = order; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getEstimatedDeliveryTime() { return estimatedDeliveryTime; }
    public void setEstimatedDeliveryTime(String estimatedDeliveryTime) { this.estimatedDeliveryTime = estimatedDeliveryTime; }
    public String getDeliveryDate() { return deliveryDate; }
    public void setDeliveryDate(String deliveryDate) { this.deliveryDate = deliveryDate; }

    public String deliveryToString() {
        return deliveryId + "|" + deliveryPersonnel.getUserId() + "|" + order.getOrderId() + "|" + status + "|" + estimatedDeliveryTime + "|" + deliveryDate;
    }

    public static Delivery fromString(String str) {
        String[] parts = str.split("\\|");
        if (parts.length == 6) {
            User deliveryPersonnel = UserHandle.findUserById(Integer.parseInt(parts[1]));
            Order order = OrderHandle.findOrderById(parts[2]);
            return new Delivery(parts[0], deliveryPersonnel, order, parts[3], parts[4], parts[5]);
        }
        System.out.println("Invalid delivery string format");
        return null;
    }
}