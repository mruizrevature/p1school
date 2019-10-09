/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

public with sharing class Factorial {
    public Integer calculateFactorial(Integer n) {

        // If the value is less than 0, return -1 since we can't calculate it.
        if (n < 0) {
            return -1;
        }

        // If the value is 0, return 1 as it is a valid number, but cannot calculate further
        if (n == 0) {
            return 1;
        }

        // On a successful factorial run, 0 and 1 should never be the final result.
        return n * calculateFactorial(n - 1);
    }
}