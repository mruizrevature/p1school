/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

@IsTest
private class ReverseStringTest {
    @isTest static void validateReverse() {
        // This is our value for testing
        String testString = 'Hello';

        String validTest = ReverseString.reverse(testString);

        System.assertEquals('olleH', validTest);
    }

    @isTest static void validateReverseWithSpaces() {
        String testString = 'Hello World';
        String validTest = ReverseString.reverse(testString);
        System.assertEquals('dlroW olleH', validTest);
    }

    @isTest static void validateReverseWithNumerics() {
        String testString = '1234567890';
        String validTest = ReverseString.reverse(testString);
        System.assertEquals('0987654321', validTest);
    }

    @isTest static void validateReverseWithSpecialCharacters() {
        // The expected result from this test will be !)(*&^%$#
        String testString = '#$%^&*()!';
        String validTest = ReverseString.reverse(testString);
        System.assertEquals('!)(*&^%$#', validTest);
    }

    @isTest static void validateReverseWithUTF() {
        // The expected result from this test will be 好你
        String testString = '你好';
        String validTest = ReverseString.reverse(testString);
        System.assertEquals('好你', validTest);
    }

    @isTest static void negativeReverseString() {
        string testString = 'Do you wanna build a snowman?';
        String validTest = ReverseString.reverse(testString);
        System.assertNotEquals('?snowman a build wanna you Do', validTest);
    }

    @isTest static void negativeReverseUTF() {
        String testString = '中国三山';
        String validTest = ReverseString.reverse(testString);
        System.assertNotEquals('中三山国', validTest);
    }
}