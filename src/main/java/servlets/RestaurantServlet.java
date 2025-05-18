package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modal.Restaurant;
import utils.RestaurantHandle;

import java.io.IOException;

@WebServlet("/RestaurantServlet")
public class RestaurantServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("add")) {
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            String cuisineType = request.getParameter("cuisineType");
            String operatingHours = request.getParameter("operatingHours");
            String contactInfo = request.getParameter("contactInfo");

            Restaurant restaurant = new Restaurant(name, location, cuisineType, operatingHours, contactInfo);
            RestaurantHandle.addRestaurant(restaurant);

            response.sendRedirect(request.getContextPath() + "/admin/ManageRestaurants.jsp");
        }

        if (action.equals("update")) {
            String restaurantId = request.getParameter("restaurantId");
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            String cuisineType = request.getParameter("cuisineType");
            String operatingHours = request.getParameter("operatingHours");
            String contactInfo = request.getParameter("contactInfo");
            String status = request.getParameter("status");

            RestaurantHandle.updateRestaurant(restaurantId, name, location, cuisineType, operatingHours, contactInfo, status);

            response.sendRedirect(request.getContextPath() + "/admin/ManageRestaurants.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String restaurantId = request.getParameter("restaurantId");

        if (action.equals("delete")) {
            RestaurantHandle.deleteRestaurant(restaurantId);
            response.sendRedirect(request.getContextPath() + "/admin/ManageRestaurants.jsp");
        }

        if (action.equals("approve")) {
            RestaurantHandle.updateRestaurantStatus(restaurantId, "active");
            response.sendRedirect(request.getContextPath() + "/admin/ManageRestaurants.jsp");
        }
    }
}