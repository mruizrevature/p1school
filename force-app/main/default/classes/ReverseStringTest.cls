/**
 * Created by gamedevmadeeasy on 10/12/19.
 */

@IsTest
private class ReverseStringTest {
    @IsTest static void validateReverse() {
        // This is our value for testing
        String testString = 'Hello';
        String validTest = ReverseString.reverse(testString);
        System.assertEquals('olleH', validTest);
    }

    @IsTest static void negativeReverse() {
        // This is our value for testing
        String testString = 'GameDevMadeEasy';
        String validTest = ReverseString.reverse(testString);
        System.assertNotEquals('EasyMadeDevGame', validTest);
    }

    @IsTest static void validateReverseWithSpaces() {
        String testString = 'Hello World';
        String validTest = ReverseString.reverse(testString);
        System.assertEquals('dlroW olleH', validTest);
    }

    @IsTest static void negativeReverseWithSpaces() {
        String testString = 'Hello World';
        String validTest = ReverseString.reverse(testString);
        System.assertNotEquals('World Hello', validTest);
    }

    @IsTest static void validateReverseWithNumerics() {
        String testString = '1234567890';
        String validTest = ReverseString.reverse(testString);
        System.assertEquals('0987654321', validTest);
    }

    @IsTest static void negativeReverseWithNumerics() {
        String testString = '1234567890';
        String validTest = ReverseString.reverse(testString);
        System.assertNotEquals('8675309', validTest);
    }

    @IsTest static void validateReverseWithSpecialCharacters() {
        // The expected result from this test will be !)(*&^%$#
        String testString = '#$%^&*()!';
        String validTest = ReverseString.reverse(testString);
        System.assertEquals('!)(*&^%$#', validTest);
    }

    @IsTest static void negativeReverseWithSpecialCharacters() {
        // The expected result from this test will be !)(*&^%$#
        String testString = '#$%^&*()!';
        String validTest = ReverseString.reverse(testString);
        System.assertNotEquals('!).^(*&^%$#', validTest);
    }

    @IsTest static void validateReverseWithUTF() {
        // The expected result from this test will be 好你
        String testString = '你好';
        String validTest = ReverseString.reverse(testString);
        System.assertEquals('好你', validTest);
    }

    @IsTest static void negativeReverseTestUTF() {
        // The expected result from this test will be 他爱只我
        String testString = '我只爱他';
        String validTest = ReverseString.reverse(testString);
        System.assertNotEquals('我他只爱', validTest);
    }
}