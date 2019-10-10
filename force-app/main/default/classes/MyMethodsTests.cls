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
        }
    }
}
