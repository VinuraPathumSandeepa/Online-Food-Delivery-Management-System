package modal;

public class MenuItem {
    private String itemId;
    private String name;
    private String category; // veg, non-veg
    private String cuisineType;
    private double price;
    private String description;
    private boolean isAvailable;
    private String restaurantId;

    public MenuItem(String name, String category, String cuisineType, double price, String description, String restaurantId) {
        this.itemId = null;
        this.name = name;
        this.category = category;
        this.cuisineType = cuisineType;
        this.price = price;
        this.description = description;
        this.isAvailable = true;
        this.restaurantId = restaurantId;
    }

    public MenuItem(String itemId, String name, String category, String cuisineType, double price, String description, boolean isAvailable, String restaurantId) {
        this.itemId = itemId;
        this.name = name;
        this.category = category;
        this.cuisineType = cuisineType;
        this.price = price;
        this.description = description;
        this.isAvailable = isAvailable;
        this.restaurantId = restaurantId;
    }

    // Getters and Setters
    public String getItemId() { return itemId; }
    public void setItemId(String itemId) { this.itemId = itemId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getCuisineType() { return cuisineType; }
    public void setCuisineType(String cuisineType) { this.cuisineType = cuisineType; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }
    public String getRestaurantId() { return restaurantId; }
    public void setRestaurantId(String restaurantId) { this.restaurantId = restaurantId; }

    public String menuItemToString() {
        return itemId + "|" + name + "|" + category + "|" + cuisineType + "|" + price + "|" + description + "|" + isAvailable + "|" + restaurantId;
    }

    public static MenuItem fromString(String str) {
        String[] parts = str.split("\\|");
        if (parts.length == 8) {
            return new MenuItem(parts[0], parts[1], parts[2], parts[3], Double.parseDouble(parts[4]), parts[5], Boolean.parseBoolean(parts[6]), parts[7]);
        }
        System.out.println("Invalid menu item string format");
        return null;
    }
}