/**
 * Created by gamedevmadeeasy on 10/12/19.
 */

@IsTest
private class PalindromeTest {
    @IsTest static void validateSingleStringPalindrome() {
        // This is our value for testing
        String testString = 'anna';

        Boolean validTest = Palindrome.isPalindrome(testString);

        System.assertEquals(true, validTest);
    }

    @IsTest static void negativeSingleStringPalindrome() {
        // This is our value for testing
        String testString = 'Hello';

        Boolean validTest = Palindrome.isPalindrome(testString);

        System.assertNotEquals(true, validTest);
    }

    @IsTest static void numericalPalindrome() {
        String testString = '1367631';
        Boolean validTest = Palindrome.isPalindrome(testString);
        System.assertEquals(true, validTest);
    }

    @IsTest static void negativeNumericalPalindrome() {
        String testString = '1367631';
        Boolean validTest = Palindrome.isPalindrome(testString);
        System.assertNotEquals(false, validTest);
    }

    @IsTest static void sentencePalindrome() {
        String testString = 'murder for a jar of red rum';
        Boolean validTest = Palindrome.isPalindrome(testString);
        System.assertEquals(false, validTest);
    }

    @IsTest static void negativeSentencePalindrome() {
        String testString = 'murder for a jar of red rum';
        Boolean validTest = Palindrome.isPalindrome(testString);
        System.assertNotEquals(true, validTest);
    }

    @IsTest static void utcPalindrome() {
        String testString = '我爱妈妈，妈妈爱我 ';
        Boolean validTest = Palindrome.isPalindrome(testString);
        System.assertEquals(true, validTest);
    }

    @IsTest static void negativeUTCPalindrome() {
        String testString = '我爱妈妈，妈妈爱我 ';
        Boolean validTest = Palindrome.isPalindrome(testString);
        System.assertNotEquals(true, validTest);
    }
}