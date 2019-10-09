/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

@IsTest
private class PalindromeTest {
    @isTest static void validateSingleStringPalindrome() {
        // This is our value for testing
        String testString = 'anna';

        Boolean validTest = Palindrome.isPalindrome(testString);

        System.assertEquals(true, validTest);
    }

    @isTest static void numericalPalindrome() {
        String testString = '1367631';
        Boolean validTest = Palindrome.isPalindrome(testString);
        System.assertEquals(true, validTest);
    }

    @isTest static void negativeSingleStringPalindrome() {
        // This is our value for testing
        String testString = 'lool';
        Boolean validTest = Palindrome.isPalindrome(testString);
        System.assertNotEquals(false, validTest);
    }

    @isTest static void negativeNumericalPalindrome() {
        // This is our value for testing
        String testString = '13433552';

        Boolean validTest = Palindrome.isPalindrome(testString);

        System.assertNotEquals(true, validTest);
    }

    @isTest static void negativeSentencePalindrome() {
        String testString = 'murder for a jar of red rum';
        Boolean validTest = Palindrome.isPalindrome(testString);
        System.assertNotEquals(true, validTest);
    }
}