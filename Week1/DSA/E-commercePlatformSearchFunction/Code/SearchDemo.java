import java.util.*;

class Product {
    int productId;
    String productName;
    String category;

    public Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }
}

public class SearchDemo {

    public static Product linearSearch(Product[] products, String name) {
        for (Product p : products) {
            if (p.productName.equalsIgnoreCase(name)) {
                return p;
            }
        }
        return null;
    }

    public static Product binarySearch(Product[] products, String name) {
        int low = 0, high = products.length - 1;
        while (low <= high) {
            int mid = (low + high) / 2;
            int cmp = products[mid].productName.compareToIgnoreCase(name);
            if (cmp == 0) return products[mid];
            else if (cmp < 0) low = mid + 1;
            else high = mid - 1;
        }
        return null;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter number of products: ");
        int n = sc.nextInt();
        sc.nextLine(); // Consume newline

        Product[] products = new Product[n];

        for (int i = 0; i < n; i++) {
            System.out.println("Enter details for product " + (i + 1) + ":");
            System.out.print("Product ID: ");
            int id = sc.nextInt();
            sc.nextLine(); // consume newline
            System.out.print("Product Name: ");
            String name = sc.nextLine();
            System.out.print("Category: ");
            String cat = sc.nextLine();
            products[i] = new Product(id, name, cat);
        }

        Arrays.sort(products, Comparator.comparing(p -> p.productName.toLowerCase()));

        System.out.print("\nEnter product name to search: ");
        String searchName = sc.nextLine();

        System.out.println("\n--- Linear Search ---");
        Product result1 = linearSearch(products, searchName);
        if (result1 != null)
            System.out.println("Found: " + result1.productName + " in category " + result1.category);
        else
            System.out.println("Product not found.");

        System.out.println("\n--- Binary Search ---");
        Product result2 = binarySearch(products, searchName);
        if (result2 != null)
            System.out.println("Found: " + result2.productName + " in category " + result2.category);
        else
            System.out.println("Product not found.");
    }
}
