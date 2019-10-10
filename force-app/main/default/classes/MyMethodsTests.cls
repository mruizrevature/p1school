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
