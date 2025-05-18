package utils;

import modal.Delivery;

import java.io.IOException;
import java.util.LinkedList;

public class DeliveryHandle {
    private static LinkedList<Delivery> deliveries = new LinkedList<>();
    private static int lastDeliveryId = 0;

    static {
        try {
            loadFromFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static String generateDeliveryId() {
        lastDeliveryId++;
        return String.format("DEL%04d", lastDeliveryId);
    }

    public static LinkedList<Delivery> getDeliveries() {
        return deliveries;
    }

    public static void addDelivery(Delivery delivery) throws IOException {
        if (delivery.getDeliveryId() == null || delivery.getDeliveryId().isEmpty()) {
            delivery.setDeliveryId(generateDeliveryId());
        }
        deliveries.add(delivery);
        saveToFile();
    }

    public static void removeDelivery(Delivery delivery) throws IOException {
        deliveries.remove(delivery);
        saveToFile();
    }

    public static Delivery findDeliveryById(String deliveryId) {
        for (Delivery delivery : deliveries) {
            if (delivery.getDeliveryId().equals(deliveryId)) {
                return delivery;
            }
        }
        System.out.println("Delivery not found");
        return null;
    }

    public static void updateDeliveryStatus(String deliveryId, String status) throws IOException {
        Delivery delivery = findDeliveryById(deliveryId);
        if (delivery != null) {
            delivery.setStatus(status);
            saveToFile();
        }
    }

    public static LinkedList<Delivery> getDeliveriesByPersonnel(int userId) {
        LinkedList<Delivery> personnelDeliveries = new LinkedList<>();
        for (Delivery delivery : deliveries) {
            if (delivery.getDeliveryPersonnel().getUserId() == userId) {
                personnelDeliveries.add(delivery);
            }
        }
        return personnelDeliveries;
    }

    public static void saveToFile() throws IOException {
        DataHandle.deliveryDataSaveToFile(deliveries);
        System.out.println("Deliveries data saved");
    }

    public static void loadFromFile() throws IOException {
        deliveries = DataHandle.deliveryDataLoadFromFile();
        for (Delivery delivery : deliveries) {
            String idNumStr = delivery.getDeliveryId().replace("DEL", "");
            int idNum = Integer.parseInt(idNumStr);
            lastDeliveryId = Math.max(lastDeliveryId, idNum);
        }
        System.out.println(" Deliveries loaded");
    }
}