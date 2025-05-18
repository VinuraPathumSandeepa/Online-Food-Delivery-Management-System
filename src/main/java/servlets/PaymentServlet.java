package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modal.Order;
import modal.Payment;
import utils.OrderHandle;
import utils.PaymentHandle;

import java.io.IOException;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String orderId = request.getParameter("orderId");

        if (action.equals("processPayment")) {
            Order order = OrderHandle.findOrderById(orderId);
            String paymentMethod = request.getParameter("paymentMethod");

            Payment payment = order.getPayment();
            PaymentHandle.updatePaymentDetails(payment.getPaymentId(), paymentMethod, "completed");
            OrderHandle.setOrderStatus(orderId, "confirmed");

            response.sendRedirect(request.getContextPath() + "/MyOrders.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String paymentId = request.getParameter("paymentId");

        if (action.equals("refund")) {
            PaymentHandle.updatePaymentStatus(paymentId, "refunded");
            response.sendRedirect(request.getContextPath() + "/admin/ManagePayments.jsp");
        }

        if (action.equals("delete")) {
            PaymentHandle.removePayment(PaymentHandle.findPaymentById(paymentId));
            response.sendRedirect(request.getContextPath() + "/admin/ManagePayments.jsp");
        }
    }
}