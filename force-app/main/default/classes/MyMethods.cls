public with sharing class MyMethods {
    
    /**
     * Given a string, return its backwards order.
     */
    public static String reverseString(String s) {
        String stringReversed = '';

        for (Integer i = s.length() - 1; i >= 0; --i) {
            stringReversed += s.substring(i, i + 1);
        }

        return stringReversed;


    /**
     * Given a string, determine if it is a palindrome.
     */
    public static Boolean isPalindrome(String s) {
        s = s.toLowerCase();

        Integer i = 0;
        Integer j = s.length() - 1;

        while (i < j && s.charAt(i) == s.charAt(j)) {
            ++i;
            --j;
        }
        return (i >= j);

    
    /**

    * Use recursion to compute the factorial of a given number.
    */
    public static Integer factorial(Integer n) {
        if (n < 0) { 
            System.debug('Please enter a number greater than or equal to 0.');
            return -1;
        } else if (n <= 1) {
            return 1;
        } else {
            return n * factorial(n - 1);

     * Return the nth fibonacci number in the fibonacci sequence.
     * It should start 1,1,2,3...
     * */
    public static Integer fibonacci(Integer n) {
        if (n <= 0) {
            System.debug('Please enter a positive number.');
            return -1;
        } else if (n <= 2) {
            return 1;
        } else {
            return fibonacci(n - 1) + fibonacci(n - 2);

        }
    }
}
