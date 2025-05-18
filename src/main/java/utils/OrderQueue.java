package utils;

import modal.Order;
import java.util.LinkedList;
import java.util.Queue;

public class OrderQueue {
    private static Queue<Order> orderQueue = new LinkedList<>();

    // Add an order to the queue
    public static void enqueueOrder(Order order) {
        orderQueue.offer(order);
    }

    // Remove and return the next order from the queue
    public static Order dequeueOrder() {
        return orderQueue.poll();
    }

    // Peek at the next order without removing it
    public static Order peekNextOrder() {
        return orderQueue.peek();
    }

    // Get the current size of the queue
    public static int getQueueSize() {
        return orderQueue.size();
    }

    // Check if the queue is empty
    public static boolean isQueueEmpty() {
        return orderQueue.isEmpty();
    }

    // Get all orders in the queue without removing them
    public static Queue<Order> getAllOrders() {
        return new LinkedList<>(orderQueue);
    }

    // Clear all orders from the queue
    public static void clearQueue() {
        orderQueue.clear();
    }
}