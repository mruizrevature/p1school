public with sharing class MyMethods {
    
    /**
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
