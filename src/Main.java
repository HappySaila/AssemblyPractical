import java.util.Scanner;

/**
 * Created by wlsgra012 on 2016/08/25.
 */

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter lower bound");
        int lower = sc.nextInt();
        System.out.println("Enter upper bound");
        int upper = sc.nextInt();
        getPalindromes(lower, upper);

    }

    private static boolean isPrime(int n){
        if (n==1 || n==0){
            return false;
        }
        if (n==2){
            return true;
        }
        int newN = (int)Math.sqrt(n);

        for (int i = 2; i <= newN ; i++) {
            if (n % i == 0){
                return false;
            }
        }
        return true;
    }

    private static boolean isPalindrome(int n){
        //create a string and reverse the number
        String strN = n+"";
        String newStrN = "";
        //need to reverse string
        for (int i = 0; i < strN.length(); i++) {
            newStrN += strN.substring(strN.length()-i-1,strN.length()-i);
        }
        if (newStrN.equals(strN)){
            return true;
        }
        return false;
    }

    private static void getPalindromes(int lower, int upper){
        //print all palindromes between 2 points
        int i=0;
        while (true) {
            if (isPrime(i)){
                if (isPalindrome(i)){
                    System.out.println(i);
                }
            }
            i++;
        }
    }
}
