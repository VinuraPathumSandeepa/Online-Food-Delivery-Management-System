package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modal.Delivery;
import modal.Order;
import modal.User;
import utils.DeliveryHandle;
import utils.OrderHandle;
import utils.UserHandle;

import java.io.IOException;

@WebServlet("/DeliveryServlet")
public class DeliveryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String orderId = request.getParameter("orderId");

        if (action.equals("assignDelivery")) {
            String deliveryPersonnelId = request.getParameter("deliveryPersonnelId");
            String estimatedDeliveryTime = request.getParameter("estimatedDeliveryTime");

            User deliveryPersonnel = UserHandle.findUserById(Integer.parseInt(deliveryPersonnelId));
            Order order = OrderHandle.findOrderById(orderId);

            Delivery delivery = new Delivery(deliveryPersonnel, order, estimatedDeliveryTime);
            DeliveryHandle.addDelivery(delivery);
            OrderHandle.setOrderDelivery(orderId, delivery);
            OrderHandle.setOrderStatus(orderId, "dispatched");

            response.sendRedirect(request.getContextPath() + "/admin/ManageDeliveries.jsp");
        }

        if (action.equals("updateStatus")) {
            String deliveryId = request.getParameter("deliveryId");
            String status = request.getParameter("status");

            DeliveryHandle.updateDeliveryStatus(deliveryId, status);
            if (status.equals("delivered")) {
                Order order = DeliveryHandle.findDeliveryById(deliveryId).getOrder();
                OrderHandle.setOrderStatus(order.getOrderId(), "delivered");
            }

            response.sendRedirect(request.getContextPath() + "/delivery/MyDeliveries.jsp.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String deliveryId = request.getParameter("deliveryId");

        if (action.equals("delete")) {
            DeliveryHandle.removeDelivery(DeliveryHandle.findDeliveryById(deliveryId));
            response.sendRedirect(request.getContextPath() + "/admin/ManageDeliveries.jsp");
        }
    }
}