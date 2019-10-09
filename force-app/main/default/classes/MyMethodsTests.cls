@isTest
public with sharing class MyMethodsTests {
    
    @isTest static void testReverseString() {
        // Given
        List<String> inputStrings = new List<String> {'Hello World', 'Oak', 'Vehicle', 'Dentist', 'Yellow Submarine'};
        List<String> expectedStrings = new List<String> {'dlroW olleH', 'kaO', 'elciheV', 'tsitneD', 'enirambuS wolleY'};

        // Action 
        List<String> results = new List<String>();
        for (Integer i = 0; i < inputStrings.size(); ++i) {
            results.add(MyMethods.reverseString(inputStrings[i]));
        }

        // Result
        for (Integer i = 0; i < results.size(); ++i) {
            System.assertEquals(expectedStrings[i], results[i]);
        }
    }
}
