
public class Logger {
    // Step 1: Create a private static instance
    private static Logger instance;

    // Step 2: Make the constructor private to prevent instantiation
    private Logger() {
        System.out.println("Logger Initialized");
    }

    // Step 3: Provide a public static method to get the instance
    public static Logger getInstance() {
        if (instance == null) {
            instance = new Logger(); // Create new only if not already created
        }
        return instance;
    }

    // Method to simulate logging
    public void log(String msg) {
        System.out.println("Log: " + msg);
    }
}
