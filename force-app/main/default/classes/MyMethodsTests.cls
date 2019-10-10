
@isTest
public with sharing class MyMethodsTests {

    @isTest static void testIsPalindrome() {
        // Given
        List<String> inputStrings = new List<String> {'hannah', 'Racecar', 'mountain', 'toot'};
        List<Boolean> expectedResults = new List<Boolean> {true, true, false, true}; 

        // Action
        List<Boolean> actualResults = new List<Boolean>();
        for (Integer i = 0; i < inputStrings.size(); ++i) {
            actualResults.add(MyMethods.isPalindrome(inputStrings[i]));
        }

        // Result
        for (Integer i = 0; i < actualResults.size(); ++i) {
            System.assertEquals(expectedResults[i], actualResults[i]);


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

@isTest 
public with sharing class MyMethodsTests {
    @isTest static void testFibonacci() {
        // Given
        List<Integer> nums = new List<Integer> {-2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8};
        List<Integer> expected = new List<Integer> {-1, -1, -1, 1, 1, 2, 3, 5, 8, 13, 21};

        // Action
        List<Integer> results = new List<Integer>();
        for (Integer i = 0; i < nums.size(); ++i) {
            results.add(MyMethods.fibonacci(nums[i]));
        }

        // Result
        for (Integer i = 0; i < results.size(); ++i) {
            System.assertEquals(expected[i], results[i]);


        }
    }
}
