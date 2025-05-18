package utils;

import modal.MenuItem;
import java.util.List;

public class MenuItemSorter {
    
    // Sort menu items by price using Quick sort
    public static void sortByPrice(List<MenuItem> items) {
        if (items == null || items.size() <= 1) {
            return;
        }
        quickSort(items, 0, items.size() - 1);
    }

    private static void quickSort(List<MenuItem> items, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(items, low, high);
            quickSort(items, low, pivotIndex - 1);
            quickSort(items, pivotIndex + 1, high);
        }
    }

    private static int partition(List<MenuItem> items, int low, int high) {
        double pivot = items.get(high).getPrice();
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (items.get(j).getPrice() <= pivot) {
                i++;
                swap(items, i, j);
            }
        }

        swap(items, i + 1, high);
        return i + 1;
    }

    private static void swap(List<MenuItem> items, int i, int j) {
        MenuItem temp = items.get(i);
        items.set(i, items.get(j));
        items.set(j, temp);
    }

    // Sort menu items by price in descending order
    public static void sortByPriceDescending(List<MenuItem> items) {
        sortByPrice(items);
        // Reverse the list to get descending order
        int left = 0;
        int right = items.size() - 1;
        while (left < right) {
            swap(items, left, right);
            left++;
            right--;
        }
    }
} 