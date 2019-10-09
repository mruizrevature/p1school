/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

@IsTest
private class FibonacciTest {
    static testMethod void fibonacciTestForFive() {
        // This is our value for testing
        Integer testInteger = 5;
        // set the value of our valid Test variable to be the results of our calculate function
        Integer validTest = Fibonacci.calculateFibonacci(testInteger);
        // We know the result should be 5, so we test against that value being equal
        System.assertEquals(5, validTest);
    }

    static testMethod void fibonacciTestForTwentyFive() {
        // This is our value for testing
        Integer testInteger = 25;

        Integer validTest = Fibonacci.calculateFibonacci(testInteger);

        System.assertEquals(75025, validTest);
    }

    static testMethod void fibonacciTestForZero() {
        // This is our value for testing
        Integer testInteger = 0;

        Integer validTest = Fibonacci.calculateFibonacci(testInteger);

        System.assertEquals(0, validTest);
    }

    static testMethod void negativeFibonacciTestForOne() {
        // This is our value for testing
        Integer testInteger = 1;

        Integer validTest = Fibonacci.calculateFibonacci(testInteger);
        // Result should NOT be 0, it should return 1. Test against it to be sure the results are correct
        System.assertNotEquals(0, validTest);
    }

    static testMethod void negativeFibonacciTest() {
        // This is our value for testing
        Integer testInteger = -5;

        Integer validTest = Fibonacci.calculateFibonacci(testInteger);

        System.assertNotEquals(1, validTest);
    }

}