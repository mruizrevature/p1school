public with sharing class MyMethods {
    
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
