/**
 * Created by gamedevmadeeasy on 10/12/19.
 */

public with sharing class FactorFactorial {
    /**
    * Use recursion to compute the factorial of a given number.
    * */
    public static Integer factorial(Integer n) {
        // if the number we provide is less than or equal to 0, return 1 instead
        // of trying to calculate these values. Which would cause a
        // Maximum stack depth reached error to occur
        if (n == 0) {
            return 1;
        }

        // Since n is never supposed to be less than 0, return -1 to denote a failure status code.
        if (n < 0) {
            return -1;
        }
        // since this is a recursive function. multiply our nth number by the
        // function call of factorial. The value is going to be our nth number
        // minus 1. This will return the proper value for our factorial.
        return n * factorial(n - 1);
    }
}