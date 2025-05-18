package utils;

import modal.MenuItem;
import modal.Order;
import modal.Payment;
import modal.Delivery;

import java.io.IOException;
import java.util.LinkedList;

public class OrderHandle {
    private static LinkedList<Order> orders = new LinkedList<>();
    private static int lastOrderId = 0;

    static {
        try {
            loadFromFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static String generateOrderId() {
        lastOrderId++;
        return String.format("ORD%04d", lastOrderId);
    }

    public static LinkedList<Order> getOrders() {
        return orders;
    }

    public static void addOrder(Order order) throws IOException {
        if (order.getOrderId() == null || order.getOrderId().isEmpty()) {
            order.setOrderId(generateOrderId());
        }
        orders.add(order);
        // Add the order to the queue for processing
        OrderQueue.enqueueOrder(order);
        saveToFile();
    }

    public static void removeOrder(Order order) throws IOException {
        orders.remove(order);
        saveToFile();
    }

    public static Order findOrderById(String orderId) {
        for (Order order : orders) {
            if (order.getOrderId().equals(orderId)) {
                return order;
            }
        }
        System.out.println("Order not found");
        return null;
    }

    public static void setOrderPayment(String orderId, Payment payment) throws IOException {
        Order order = findOrderById(orderId);
        if (order != null) {
            order.setPayment(payment);
            saveToFile();
        }
    }

    public static void setOrderDelivery(String orderId, Delivery delivery) throws IOException {
        Order order = findOrderById(orderId);
        if (order != null) {
            order.setDelivery(delivery);
            saveToFile();
        }
    }

    public static void setOrderStatus(String orderId, String status) throws IOException {
        Order order = findOrderById(orderId);
        if (order != null) {
            order.setStatus(status);
            // If order is completed or cancelled, remove it from the queue
            if (status.equals("delivered") || status.equals("cancelled")) {
                OrderQueue.dequeueOrder();
            }
            saveToFile();
        }
    }

    public static void updateOrder(String orderId, LinkedList<MenuItem> items, String deliveryAddress) throws IOException {
        Order order = findOrderById(orderId);
        if (order != null) {
            order.setItems(items);
            order.setDeliveryAddress(deliveryAddress);
            order.setTotalAmount(order.getItems().stream().mapToDouble(MenuItem::getPrice).sum());
            saveToFile();
        }
    }

    public static LinkedList<Order> getOrdersByUserId(int userId) {
        LinkedList<Order> userOrders = new LinkedList<>();
        for (Order order : orders) {
            if (order.getCustomer().getUserId() == userId) {
                userOrders.add(order);
            }
        }
        return userOrders;
    }

    // Get the next order to be processed from the queue
    public static Order getNextOrder() {
        return OrderQueue.peekNextOrder();
    }

    // Process the next order in the queue
    public static Order processNextOrder() {
        return OrderQueue.dequeueOrder();
    }

    // Get the number of orders waiting to be processed
    public static int getPendingOrdersCount() {
        return OrderQueue.getQueueSize();
    }

    public static void saveToFile() throws IOException {
        DataHandle.orderDataSaveToFile(orders);
        System.out.println("Orders data saved");
    }

    public static void loadFromFile() throws IOException {
        orders = DataHandle.orderDataLoadFromFile();
        for (Order order : orders) {
            String idNumStr = order.getOrderId().replace("ORD", "");
            int idNum = Integer.parseInt(idNumStr);
            lastOrderId = Math.max(lastOrderId, idNum);
            // Add pending orders to the queue
            if (order.getStatus().equals("pending")) {
                OrderQueue.enqueueOrder(order);
            }
        }
        System.out.println("Orders loaded");
    }
}