public with sharing class MyMethods {

    /**
     * Given a string, determine if it is a palindrome.
     */
    public static Boolean isPalindrome(String s) {
        s = s.toLowerCase();

        Integer i = 0;
        Integer j = s.length() - 1;

        while (i < j && s.charAt(i) == s.charAt(j)) {
            ++i;
            --j;
        }
        return (i >= j);
    }
}
