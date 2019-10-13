/**
 * Created by gamedevmadeeasy on 10/12/19.
 */

public with sharing class FactorFibonacci {
    /**
  * Return the nth fiboacci number in the fibonacci sequence.
  * It should start 1,1,2,3...
  * */
    public static Integer fibonacci(Integer n) {
        // seq1, seq2 are the counting values for facoring for fibonacci numbers.
        // result will be the final result after calculation.
        Integer seq1 = 0, seq2 = 1, result = 0;

        // if our value is 0, make sure to return 0
        if (n == 0) {
            return 0;
        }
        // if our value is 1, make sure to return 1
        if (n == 1) {
            return 1;
        }

        // set our i value to 2 and make sure it is greater than or equal to the
        // nth number we designate.
        for (Integer i = 2; i <= n; i++)
        {
            // let the result be the value of seq1 and seq2 added together
            result = seq1 + seq2;
            // set seq1 to be the value of seq2
            seq1 = seq2;
            // now set the value of result to be the value of seq2
            seq2 = result;
            // this will happen each iteration until we reach the nth count
        }
        // return the results that were stored.
        return result;
    }
}