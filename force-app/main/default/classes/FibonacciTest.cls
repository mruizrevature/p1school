@isTest
private class FibonacciTest {
    static testMethod void fibonacciTestForFive() {
        // This is our value for testing
        Integer testInteger = 5;

        Integer validTest = FactorFibonacci.fibonacci(testInteger);

        System.assertEquals(5, validTest);
    }

    static testMethod void fibonacciTestForTwentyFive() {
        // This is our value for testing
        Integer testInteger = 25;

        Integer validTest = FactorFibonacci.fibonacci(testInteger);

        System.assertEquals(75025, validTest);
    }

    static testMethod void fibonacciTestForZero() {
        // This is our value for testing
        Integer testInteger = 0;

        Integer validTest = FactorFibonacci.fibonacci(testInteger);

        System.assertNotEquals(1, validTest);
    }

    static testMethod void fibonacciTestForOne() {
        // This is our value for testing
        Integer testInteger = 1;

        Integer validTest = FactorFibonacci.fibonacci(testInteger);

        System.assertEquals(1, validTest);
    }

    static testMethod void fibonacciTestForNegative() {
        // This is our value for testing
        Integer testInteger = -5;

        Integer validTest = FactorFibonacci.fibonacci(testInteger);

        System.assertNotEquals(-25, validTest);
    }
}
