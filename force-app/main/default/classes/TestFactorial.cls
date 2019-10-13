@isTest
private class TestFactorial {
    static testMethod void validateFactorialWithFive() {
        // create our test variable and set it to be 5.
        Integer testFive = 5;
        // create a new variable that is set to be the value of
        // our factorial method with the parameters set to be our test variable.
        Integer validTest = FactorFactorial.factorial(testFive);
        // For funsies, we can debug for the value to make sure our test code
        // has the same results (and it should). Debug is not required for testing.
        System.debug(validTest);
        // Since we should know the expected value, we input 120 as the first parameter
        // The second parameter is our factorial method call's actual results.
        System.assertEquals(120, validTest);
    }

    static testMethod void validateZeroFactorial() {
        Integer testZero = 0;
        Integer validTest = FactorFactorial.factorial(testZero);
        System.debug(validTest);
        // As specified in our P0 class, any value less than or equal to 0
        // should return the value of 1, so we test that case.
        System.assertEquals(1, validTest);
    }

    static testMethod void negativeFactorialTest() {
        Integer testNegative = -5;
        Integer validTest = FactorFactorial.factorial(testNegative);
        System.debug(validTest);
        // This is an edge case of someone putting an invalid numerical value.
        // We should test to make sure that it does not fail as well.
        System.assertEquals(1, validTest);
    }
}