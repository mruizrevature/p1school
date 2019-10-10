@isTest
public with sharing class MyMethodsTests {

    @isTest static void testFactorial() {
        // Given
        List<Integer> inputNums = new List<Integer> {-2, -1, 0, 1, 2, 3, 4, 5};
        List<Integer> expectedNums = new List<Integer> {-1, -1, 1, 1, 2, 6, 24, 120};

        // Action
        List<Integer> actualNums = new List<Integer>();
        for (Integer i = 0; i < inputNums.size(); ++i) {
            actualNums.add(MyMethods.factorial(inputNums[i]));
        }

        // Result
        for (Integer i = 0; i < actualNums.size(); ++i) {
            System.assertEquals(expectedNums[i], actualNums[i]);
        }
    }
}
