package utils;

import modal.MenuItem;

import java.io.IOException;
import java.util.LinkedList;

public class MenuItemHandle {
    private static LinkedList<MenuItem> menuItems = new LinkedList<>();
    private static int lastItemId = 0;

    static {
        try {
            loadFromFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static String generateItemId() {
        lastItemId++;
        return String.format("ITEM%04d", lastItemId);
    }

    public static LinkedList<MenuItem> getMenuItems() {
        return menuItems;
    }

    // Get menu items sorted by price (ascending)
    public static LinkedList<MenuItem> getMenuItemsSortedByPrice() {
        LinkedList<MenuItem> sortedItems = new LinkedList<>(menuItems);
        MenuItemSorter.sortByPrice(sortedItems);
        return sortedItems;
    }

    // Get menu items sorted by price (descending)
    public static LinkedList<MenuItem> getMenuItemsSortedByPriceDescending() {
        LinkedList<MenuItem> sortedItems = new LinkedList<>(menuItems);
        MenuItemSorter.sortByPriceDescending(sortedItems);
        return sortedItems;
    }

    // Get available menu items sorted by price (ascending)
    public static LinkedList<MenuItem> getAvailableMenuItemsSortedByPrice() {
        LinkedList<MenuItem> availableItems = getAvailableMenuItems();
        MenuItemSorter.sortByPrice(availableItems);
        return availableItems;
    }

    // Get available menu items sorted by price (descending)
    public static LinkedList<MenuItem> getAvailableMenuItemsSortedByPriceDescending() {
        LinkedList<MenuItem> availableItems = getAvailableMenuItems();
        MenuItemSorter.sortByPriceDescending(availableItems);
        return availableItems;
    }

    public static void addMenuItem(MenuItem item) throws IOException {
        if (item.getItemId() == null || item.getItemId().isEmpty()) {
            item.setItemId(generateItemId());
        }
        menuItems.add(item);
        saveToFile();
    }

    public static void removeMenuItem(MenuItem item) throws IOException {
        menuItems.remove(item);
        saveToFile();
    }

    public static MenuItem findMenuItemById(String itemId) {
        for (MenuItem item : menuItems) {
            if (item.getItemId().equals(itemId)) {
                return item;
            }
        }
        System.out.println("Menu item not found");
        return null;
    }

    public static void updateMenuItem(String itemId, String name, String category, String cuisineType, double price, String description, boolean isAvailable) throws IOException {
        MenuItem item = findMenuItemById(itemId);
        if (item != null) {
            item.setName(name);
            item.setCategory(category);
            item.setCuisineType(cuisineType);
            item.setPrice(price);
            item.setDescription(description);
            item.setAvailable(isAvailable);
            saveToFile();
        }
    }

    public static void deleteMenuItem(String itemId) throws IOException {
        MenuItem item = findMenuItemById(itemId);
        if (item != null) {
            menuItems.remove(item);
            saveToFile();
        }
    }

    public static LinkedList<MenuItem> getAvailableMenuItems() {
        LinkedList<MenuItem> availableItems = new LinkedList<>();
        for (MenuItem item : menuItems) {
            if (item.isAvailable()) {
                availableItems.add(item);
            }
        }
        return availableItems;
    }

    public static void saveToFile() throws IOException {
        DataHandle.menuItemDataSaveToFile(menuItems);
        System.out.println("Menu items data saved");
    }

    public static void loadFromFile() throws IOException {
        menuItems = DataHandle.menuItemDataLoadFromFile();
        for (MenuItem item : menuItems) {
            String idNumStr = item.getItemId().replace("ITEM", "");
            int idNum = Integer.parseInt(idNumStr);
            lastItemId = Math.max(lastItemId, idNum);
        }
        System.out.println("Menu items loaded");
    }
}