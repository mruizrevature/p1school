/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

public with sharing class ReverseString {
    /**
     * Given a string, return its backwards order.
     * */
    public static String reverse(String s) {
        // create an empty string
        String reverseString = '';
        // our i value is going to be set to the value of the string s' value.
        // we want to go backwards with our loop so we do i--.
        for (Integer i = s.length() - 1; i >= 0; i--) {
            // we will now make the reverse string take each substring from the
            // backwards motion loop to add the letter that was taken from the original
            // string that was provided.
            reverseString += s.substring(i, i + 1);
        }
        // return the new string value from the results of the loop
        return reverseString;
    }
}