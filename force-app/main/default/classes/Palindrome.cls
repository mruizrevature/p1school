/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

public with sharing class Palindrome {
    /*
        Given a string, determine if it is a palindrome.
    */
    public static Boolean isPalindrome(String s) {
        String reverseString = '';

        for (Integer i = s.length() - 1; i >= 0; i--) {
            reverseString += s.substring(i, i + 1);
        }

        if (s == reverseString) {
            return true;
        }
        else {
            return false;
        }
    }
}