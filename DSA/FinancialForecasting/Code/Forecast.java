import java.util.Scanner;

public class Forecast {

    public static double futureValue(double current, double rate, int years) {
        if (years == 0)
            return current;
        return futureValue(current, rate, years - 1) * (1 + rate);
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter current amount ($): ");
        double current = sc.nextDouble();

        System.out.print("Enter annual growth rate (as percentage): ");
        double rate = sc.nextDouble() / 100;

        System.out.print("Enter number of years: ");
        int years = sc.nextInt();

        double result = futureValue(current, rate, years);
        System.out.printf("Future value after %d years: $%.2f\n", years, result);
    }
}
