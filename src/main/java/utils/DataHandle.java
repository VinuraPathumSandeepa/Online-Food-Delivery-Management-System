package utils;

import modal.*;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.stream.Collectors;

public class DataHandle {
    private static final String basePath = "D:/FoodDeliveryData/";
    private static final String userFilePath = basePath + "users.txt";
    private static final String restaurantFilePath = basePath + "restaurants.txt";
    private static final String menuItemFilePath = basePath + "menu_items.txt";
    private static final String orderFilePath = basePath + "orders.txt";
    private static final String paymentFilePath = basePath + "payments.txt";
    private static final String deliveryFilePath = basePath + "deliveries.txt";

    static {
        try {
            ensureFileExists(userFilePath);
            ensureFileExists(restaurantFilePath);
            ensureFileExists(menuItemFilePath);
            ensureFileExists(orderFilePath);
            ensureFileExists(paymentFilePath);
            ensureFileExists(deliveryFilePath);
            System.out.println("All files are OK");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void ensureFileExists(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Path parentDir = path.getParent();

        if (parentDir != null && !Files.exists(parentDir)) {
            Files.createDirectories(parentDir);
        }

        if (!Files.exists(path)) {
            Files.createFile(path);
        }
    }

    public static void userDataSaveToFile(LinkedList<User> users) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(userFilePath))) {
            for (User user : users) {
                if (user != null) {
                    writer.write(user.userToString());
                    writer.newLine();
                }
            }
        }
    }

    public static LinkedList<User> userDataLoadFromFile() throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(userFilePath))) {
            LinkedList<User> users = new LinkedList<>();
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    String[] data = line.split("\\|");
                    User user = User.stringToUser(line);
                    if (user != null) {
                        users.add(user);
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing user from line: " + line);
                }
            }
            return users;
        }
    }

    public static void restaurantDataSaveToFile(LinkedList<Restaurant> restaurants) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(restaurantFilePath))) {
            for (Restaurant restaurant : restaurants) {
                if (restaurant != null) {
                    writer.write(restaurant.restaurantToString());
                    writer.newLine();
                }
            }
        }
    }

    public static LinkedList<Restaurant> restaurantDataLoadFromFile() throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(restaurantFilePath))) {
            LinkedList<Restaurant> restaurants = new LinkedList<>();
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    Restaurant restaurant = Restaurant.fromString(line);
                    if (restaurant != null) {
                        restaurants.add(restaurant);
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing restaurant from line: " + line);
                }
            }
            return restaurants;
        }
    }

    public static void menuItemDataSaveToFile(LinkedList<MenuItem> menuItems) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(menuItemFilePath))) {
            for (MenuItem item : menuItems) {
                if (item != null) {
                    writer.write(item.menuItemToString());
                    writer.newLine();
                }
            }
        }
    }

    public static LinkedList<MenuItem> menuItemDataLoadFromFile() throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(menuItemFilePath))) {
            LinkedList<MenuItem> menuItems = new LinkedList<>();
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    MenuItem item = MenuItem.fromString(line);
                    if (item != null) {
                        menuItems.add(item);
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing menu item from line: " + line);
                }
            }
            return menuItems;
        }
    }

    public static void orderDataSaveToFile(LinkedList<Order> orders) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(orderFilePath))) {
            for (Order order : orders) {
                if (order != null) {
                    writer.write(order.orderToString());
                    writer.newLine();
                }
            }
        }
    }

    public static LinkedList<Order> orderDataLoadFromFile() throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(orderFilePath))) {
            LinkedList<Order> orders = new LinkedList<>();
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    String[] split = line.split("\\|");
                    String orderId = split[0];
                    int userId = Integer.parseInt(split[1]);
                    String restaurantId = split[2];
                    String[] itemIds = split[3].split(",");
                    double totalAmount = Double.parseDouble(split[4]);
                    String status = split[5];
                    String paymentId = split[6];
                    String deliveryAddress = split[7];
                    String deliveryId = split[8];

                    User customer = UserHandle.findUserById(userId);
                    Restaurant restaurant = RestaurantHandle.findRestaurantById(restaurantId);
                    LinkedList<MenuItem> items = new LinkedList<>();
                    for (String itemId : itemIds) {
                        MenuItem item = MenuItemHandle.findMenuItemById(itemId);
                        if (item != null) {
                            items.add(item);
                        }
                    }
                    Payment payment = paymentId.equals("null") ? null : PaymentHandle.findPaymentById(paymentId);
                    Delivery delivery = deliveryId.equals("null") ? null : DeliveryHandle.findDeliveryById(deliveryId);

                    Order order = new Order(orderId, customer, restaurant, items, totalAmount, status, payment, deliveryAddress, delivery);
                    orders.add(order);
                } catch (Exception e) {
                    System.err.println("Error parsing order from line: " + line);
                }
            }
            return orders;
        }
    }

    public static void paymentDataSaveToFile(LinkedList<Payment> payments) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(paymentFilePath))) {
            for (Payment payment : payments) {
                if (payment != null) {
                    writer.write(payment.paymentToString());
                    writer.newLine();
                }
            }
        }
    }

    public static LinkedList<Payment> paymentDataLoadFromFile() throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(paymentFilePath))) {
            LinkedList<Payment> payments = new LinkedList<>();
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    Payment payment = Payment.fromString(line);
                    if (payment != null) {
                        payments.add(payment);
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing payment from line: " + line);
                }
            }
            return payments;
        }
    }

    public static void deliveryDataSaveToFile(LinkedList<Delivery> deliveries) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(deliveryFilePath))) {
            for (Delivery delivery : deliveries) {
                if (delivery != null) {
                    writer.write(delivery.toString());
                    writer.newLine();
                }
            }
        }
    }

    public static LinkedList<Delivery> deliveryDataLoadFromFile() throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(deliveryFilePath))) {
            LinkedList<Delivery> deliveries = new LinkedList<>();
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    Delivery delivery = Delivery.fromString(line);
                    if (delivery != null) {
                        deliveries.add(delivery);
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing delivery from line: " + line);
                }
            }
            return deliveries;
        }
    }
}