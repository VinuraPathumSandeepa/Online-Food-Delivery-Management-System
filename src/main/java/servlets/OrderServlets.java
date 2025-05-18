package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modal.MenuItem;
import modal.Order;
import modal.Payment;
import modal.User;
import utils.MenuItemHandle;
import utils.OrderHandle;
import utils.PaymentHandle;
import utils.RestaurantHandle;

import java.io.IOException;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.stream.Collectors;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        User user = (User) request.getSession().getAttribute("USER");
        RestaurantHandle.loadFromFile();

        if (action.equals("createOrder")) {
            String restaurantId = request.getParameter("restaurantId");
            String[] itemIds = request.getParameterValues("itemIds");
            String deliveryAddress = request.getParameter("deliveryAddress");
            String paymentMethod = request.getParameter("paymentMethod");

            LinkedList<MenuItem> items = new LinkedList<>();
            for (String itemId : itemIds) {
                MenuItem item = MenuItemHandle.findMenuItemById(itemId);
                if (item != null) {
                    items.add(item);
                }
            }

            Order order = new Order(user, RestaurantHandle.findRestaurantById(restaurantId), items, deliveryAddress);
            OrderHandle.addOrder(order);

            double totalAmount = order.getTotalAmount();
            Payment payment = new Payment(totalAmount, paymentMethod, user);
            PaymentHandle.addPayment(payment);
            OrderHandle.setOrderPayment(order.getOrderId(), payment);

            // Redirect to PaymentDetails.jsp with orderId and paymentId
            response.sendRedirect(request.getContextPath() + "/PaymentDetails.jsp?orderId=" + order.getOrderId() + "&paymentId=" + payment.getPaymentId());
        }

        if (action.equals("update")) {
            String orderId = request.getParameter("orderId");
            String[] itemIds = request.getParameterValues("itemIds");
            String deliveryAddress = request.getParameter("deliveryAddress");

            LinkedList<MenuItem> items = new LinkedList<>();
            for (String itemId : itemIds) {
                MenuItem item = MenuItemHandle.findMenuItemById(itemId);
                if (item != null) {
                    items.add(item);
                }
            }

            OrderHandle.updateOrder(orderId, items, deliveryAddress);
            response.sendRedirect(request.getContextPath() + "/MyOrders.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String orderId = request.getParameter("orderId");

        if (action.equals("cancel")) {
            OrderHandle.setOrderStatus(orderId, "cancelled");
            response.sendRedirect(request.getContextPath() + "/MyOrders.jsp");
        }

        if (action.equals("delete")) {
            OrderHandle.removeOrder(OrderHandle.findOrderById(orderId));
            response.sendRedirect(request.getContextPath() + "/admin/ManageOrders.jsp");
        }
    }
}