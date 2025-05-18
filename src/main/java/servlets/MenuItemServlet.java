package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modal.MenuItem;
import utils.MenuItemHandle;

import java.io.IOException;

@WebServlet("/MenuItemServlet")
public class MenuItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String restaurantId = request.getParameter("restaurantId");

        if (action.equals("add")) {
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            String cuisineType = request.getParameter("cuisineType");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");

            MenuItem item = new MenuItem(name, category, cuisineType, price, description, restaurantId);
            MenuItemHandle.addMenuItem(item);

            response.sendRedirect(request.getContextPath() + "/admin/ManageMenu.jsp");
        }

        if (action.equals("update")) {
            String itemId = request.getParameter("itemId");
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            String cuisineType = request.getParameter("cuisineType");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));

            MenuItemHandle.updateMenuItem(itemId, name, category, cuisineType, price, description, isAvailable);

            response.sendRedirect(request.getContextPath() + "/restaurant/ManageMenu.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String itemId = request.getParameter("itemId");

        if (action.equals("delete")) {
            MenuItemHandle.deleteMenuItem(itemId);
            response.sendRedirect(request.getContextPath() + "/restaurant/ManageMenu.jsp");
        }
    }
}