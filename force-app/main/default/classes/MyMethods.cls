public with sharing class MyMethods {
    
    /**
     * Given a string, return its backwards order.
     */
    public static String reverseString(String s) {
        String stringReversed = '';

        for (Integer i = s.length() - 1; i >= 0; --i) {
            stringReversed += s.substring(i, i + 1);
        }

        return stringReversed;
    }
}
