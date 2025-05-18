package utils;

import modal.Restaurant;

import java.io.IOException;
import java.util.LinkedList;

public class RestaurantHandle {
    private static LinkedList<Restaurant> restaurants = new LinkedList<>();
    private static int lastRestaurantId = 0;

    static {
        try {
            loadFromFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static String generateRestaurantId() {
        lastRestaurantId++;
        return String.format("REST%04d", lastRestaurantId);
    }

    public static LinkedList<Restaurant> getRestaurants() {
        return restaurants;
    }

    public static void addRestaurant(Restaurant restaurant) throws IOException {
        if (restaurant.getRestaurantId() == null || restaurant.getRestaurantId().isEmpty()) {
            restaurant.setRestaurantId(generateRestaurantId());
        }
        restaurants.add(restaurant);
        saveToFile();
    }

    public static void removeRestaurant(Restaurant restaurant) throws IOException {
        restaurants.remove(restaurant);
        saveToFile();
    }

    public static Restaurant findRestaurantById(String restaurantId) {
        for (Restaurant restaurant : restaurants) {
            if (restaurant.getRestaurantId().equals(restaurantId)) {
                return restaurant;
            }
        }
        System.out.println("Restaurant not found");
        return null;
    }

    public static void updateRestaurant(String restaurantId, String name, String location, String cuisineType, String operatingHours, String contactInfo, String status) throws IOException {
        Restaurant restaurant = findRestaurantById(restaurantId);
        if (restaurant != null) {
            restaurant.setName(name);
            restaurant.setLocation(location);
            restaurant.setCuisineType(cuisineType);
            restaurant.setOperatingHours(operatingHours);
            restaurant.setContactInfo(contactInfo);
            restaurant.setStatus(status);
            saveToFile();
        }
    }

    public static void updateRestaurantStatus(String restaurantId, String status) throws IOException {
        Restaurant restaurant = findRestaurantById(restaurantId);
        if (restaurant != null) {
            restaurant.setStatus(status);
            saveToFile();
        }
    }

    public static void deleteRestaurant(String restaurantId) throws IOException {
        Restaurant restaurant = findRestaurantById(restaurantId);
        if (restaurant != null) {
            restaurants.remove(restaurant);
            saveToFile();
        }
    }

    public static void saveToFile() throws IOException {
        DataHandle.restaurantDataSaveToFile(restaurants);
        System.out.println("Restaurants data saved");
    }

    public static void loadFromFile() throws IOException {
        restaurants = DataHandle.restaurantDataLoadFromFile();
        for (Restaurant restaurant : restaurants) {
            String idNumStr = restaurant.getRestaurantId().replace("REST", "");
            int idNum = Integer.parseInt(idNumStr);
            lastRestaurantId = Math.max(lastRestaurantId, idNum);
        }
        System.out.println("Restaurants loaded");
    }
}