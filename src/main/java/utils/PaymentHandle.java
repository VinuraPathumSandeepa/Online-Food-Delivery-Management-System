package utils;

import modal.Payment;

import java.io.IOException;
import java.util.LinkedList;

public class PaymentHandle {
    private static LinkedList<Payment> payments = new LinkedList<>();
    private static int lastPaymentId = 0;

    static {
        try {
            loadFromFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static String generatePaymentId() {
        lastPaymentId++;
        return String.format("PAY%04d", lastPaymentId);
    }

    public static LinkedList<Payment> getPayments() {
        return payments;
    }

    public static void addPayment(Payment payment) throws IOException {
        if (payment.getPaymentId() == null || payment.getPaymentId().isEmpty()) {
            payment.setPaymentId(generatePaymentId());
        }
        payments.add(payment);
        saveToFile();
    }

    public static void removePayment(Payment payment) throws IOException {
        payments.remove(payment);
        saveToFile();
    }

    public static Payment findPaymentById(String paymentId) {
        for (Payment payment : payments) {
            if (payment.getPaymentId().equals(paymentId)) {
                return payment;
            }
        }
        System.out.println("Payment not found");
        return null;
    }

    public static void updatePaymentDetails(String paymentId, String paymentMethod, String status) throws IOException {
        Payment payment = findPaymentById(paymentId);
        if (payment != null) {
            payment.setPaymentMethod(paymentMethod);
            payment.setStatus(status);
            saveToFile();
        }
    }

    public static void updatePaymentStatus(String paymentId, String status) throws IOException {
        Payment payment = findPaymentById(paymentId);
        if (payment != null) {
            payment.setStatus(status);
            saveToFile();
        }
    }

    public static void saveToFile() throws IOException {
        DataHandle.paymentDataSaveToFile(payments);
        System.out.println("Payments data saved");
    }

    public static void loadFromFile() throws IOException {
        payments = DataHandle.paymentDataLoadFromFile();
        for (Payment payment : payments) {
            String idNumStr = payment.getPaymentId().replace("PAY", "");
            int idNum = Integer.parseInt(idNumStr);
            lastPaymentId = Math.max(lastPaymentId, idNum);
        }
        System.out.println("Payments loaded");
    }
}