/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

@IsTest
private class FactorialTest {
    @isTest static void validateFactorialWithFive() {
        factorial fact = new factorial();
        // create our test variable and set it to be 5.
        Integer testFive = 5;
        // create a new variable that is set to be the value of
        // our factorial method with the parameters set to be our test variable.
        Integer validTest = fact.calculateFactorial(testFive);
        // Since we should know the expected value, we input 120 as the first parameter
        // The second parameter is our factorial method call's actual results.
        System.assertEquals(120, validTest);
    }

    @isTest static void validateZeroFactorial() {
        factorial fact = new factorial();
        Integer testZero = 0;
        Integer validTest = fact.calculateFactorial(testZero);
        // As specified in our P0 class, any value less than or equal to 0
        // should return the value of 1, so we test that case.
        System.assertEquals(1, validTest);
    }

    @isTest static void negativeNumberFactorialTest() {
        factorial fact = new factorial();
        Integer testNegative = -5;
        Integer validTest = fact.calculateFactorial(testNegative);
        // This is an edge case of someone putting an invalid numerical value.
        // We should test to make sure that it does not fail as well.
        System.assertEquals(1, validTest);
    }

    @isTest static void negativeFactorialCase() {
        factorial fact = new factorial();
        Integer testNegative = -5;
        Integer validTest = fact.calculateFactorial(testNegative);
        // Negative test case to make sure the value does not result in 0 from a negative number
        System.assertNotEquals(0, validTest);
    }

    @isTest static void negativeWithZeroFactorialCase() {
        factorial fact = new factorial();
        Integer testNegative = 0;
        Integer validTest = fact.calculateFactorial(testNegative);
        // Negative test case to make sure the value is not 0 with the input value being 0, it should
        // return 1.
        System.assertNotEquals(0, validTest);
    }

}