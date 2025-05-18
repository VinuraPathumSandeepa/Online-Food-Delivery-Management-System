package modal;

public class Restaurant {
    private String restaurantId;
    private String name;
    private String location;
    private String cuisineType;
    private String operatingHours;
    private String contactInfo;
    private String status; // active, pending, inactive

    public Restaurant(String name, String location, String cuisineType, String operatingHours, String contactInfo) {
        this.restaurantId = null;
        this.name = name;
        this.location = location;
        this.cuisineType = cuisineType;
        this.operatingHours = operatingHours;
        this.contactInfo = contactInfo;
        this.status = "pending";
    }

    public Restaurant(String restaurantId, String name, String location, String cuisineType, String operatingHours, String contactInfo, String status) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.location = location;
        this.cuisineType = cuisineType;
        this.operatingHours = operatingHours;
        this.contactInfo = contactInfo;
        this.status = status;
    }

    // Getters and Setters
    public String getRestaurantId() { 
        return restaurantId; 
    }
    
    public void setRestaurantId(String restaurantId) { 
        this.restaurantId = restaurantId; 
    }
    
    public String getName() { 
        return name; 
    }
    
    public void setName(String name) {
        this.name = name; 
    }
    
    public String getLocation() { 
        return location; 
    }
    
    public void setLocation(String location) {
        this.location = location; 
    }
    
    public String getCuisineType() { 
        return cuisineType; 
    }
    
    public void setCuisineType(String cuisineType) {
        this.cuisineType = cuisineType; 
    }
    
    public String getOperatingHours() { 
        return operatingHours; 
    }
    
    public void setOperatingHours(String operatingHours) { 
        this.operatingHours = operatingHours; 
    }
    
    public String getContactInfo() {
        return contactInfo;
    }
    
    public void setContactInfo(String contactInfo) { 
        this.contactInfo = contactInfo; 
    }
    
    public String getStatus() { 
        return status; 
    }
    
    public void setStatus(String status) { 
        this.status = status; 
    }

    public String restaurantToString() {
        return restaurantId + "|" + name + "|" + location + "|" + cuisineType + "|" + operatingHours + "|" + contactInfo + "|" + status;
    }

    public static Restaurant fromString(String str) {
        String[] parts = str.split("\\|");
        if (parts.length == 7) {
            return new Restaurant(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]);
        }
        System.out.println("Invalid restaurant string format");
        return null;
    }
}
