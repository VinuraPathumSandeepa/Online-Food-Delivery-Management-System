package modal;

import java.time.LocalDateTime;
import java.util.LinkedList;
import java.util.stream.Collectors;

public class Order {
    private String orderId;
    private User customer;
    private Restaurant restaurant;
    private LinkedList<MenuItem> items;
    private double totalAmount;
    private String status; // pending, confirmed, preparing, dispatched, delivered, cancelled
    private Payment payment;
    private String deliveryAddress;
    private Delivery delivery;

    public Order(User customer, Restaurant restaurant, LinkedList<MenuItem> items, String deliveryAddress) {
        this.orderId = null;
        this.customer = customer;
        this.restaurant = restaurant;
        this.items = items;
        this.totalAmount = calculateTotal();
        this.status = "pending";
        this.payment = null;
        this.deliveryAddress = deliveryAddress;
        this.delivery = null;
    }

    public Order(String orderId, User customer, Restaurant restaurant, LinkedList<MenuItem> items, double totalAmount, String status, Payment payment, String deliveryAddress, Delivery delivery) {
        this.orderId = orderId;
        this.customer = customer;
        this.restaurant = restaurant;
        this.items = items;
        this.totalAmount = totalAmount;
        this.status = status;
        this.payment = payment;
        this.deliveryAddress = deliveryAddress;
        this.delivery = delivery;
    }

    private double calculateTotal() {
        double total = 0;
        for (MenuItem item : items) {
            total += item.getPrice();
        }
        return total;
    }

    // Getters and Setters
    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }
    public User getCustomer() { return customer; }
    public void setCustomer(User customer) { this.customer = customer; }
    public Restaurant getRestaurant() { return restaurant; }
    public void setRestaurant(Restaurant restaurant) { this.restaurant = restaurant; }
    public LinkedList<MenuItem> getItems() { return items; }
    public void setItems(LinkedList<MenuItem> items) { this.items = items; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Payment getPayment() { return payment; }
    public void setPayment(Payment payment) { this.payment = payment; }
    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }
    public Delivery getDelivery() { return delivery; }
    public void setDelivery(Delivery delivery) { this.delivery = delivery; }

    public String orderToString() {
        String paymentId = payment == null ? "null" : payment.getPaymentId();
        String deliveryId = delivery == null ? "null" : delivery.getDeliveryId();
        String itemIds = items.stream().map(MenuItem::getItemId).collect(Collectors.joining(","));
        return orderId + "|" + customer.getUserId() + "|" + restaurant.getRestaurantId() + "|" + itemIds + "|" + totalAmount + "|" + status + "|" + paymentId + "|" + deliveryAddress + "|" + deliveryId;
    }
}