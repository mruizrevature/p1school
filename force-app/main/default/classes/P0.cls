

public class P0 {

    /**

     * Return the nth fiboacci number in the fibonacci sequence.

     * It should start 1,1,2,3...

     * */

    public static Integer fibonacci(Integer amount) {
        if(amount<0)
            return 0;   //a bad index
        else if(amount<=2)
            return 1;   //first 2
        else{
            Integer onebefore=1;
            Integer twobefore=1;
            Integer fib = 0;
            for(Integer count=2;count<amount;count++)
            {
                //compute through loop sum of two previous fib numbers
                fib = onebefore + twobefore;
                twobefore=onebefore;
                onebefore=fib;
            }
            return fib;
        }

    }

    

    /**

     * Given a string, return its backwards order.

     * */

    public static String reverseString(String s) {

        if(s.length()<2)
        {
            return s;       //1 letter string already reversed
        }
        else
        {
            //reverse = last letter + reverse(the rest of the string)
            return s.right(1) + reverseString(s.left(s.length()-1));  
        }

    }

    

    public static Integer factorial(Integer n) {
        if(n>1)
            return n*factorial(n-1);
        else
            return 1;   //1! = 0! = 1

    }

    

    /**

     * Given a string, determine if it is a palindrome.

     * */

    public static Boolean isPalindrome(String s) {

        //ignore case
        s.toLowerCase();

        for(Integer c=0;c<s.length()/2;c++)
        {
            //left most letter = right most letter, loop goes towards middle
            if(s.charAt(c)!=s.charAt(s.length()-1-c))
                return false;
        }
        return true;

    }

    

    /**

     *  Given a state, return the accounts in that state.

     *  I only want the accounts that have a contact who works at the same place as the account.

     * */

    public static List<Account> getAccountsForAGivenState(State s) {
        
        return [SELECT ID FROM Account];

    }

    

    /**

     * For each student, get the grade for each of their classes.

     * */

    public static Map<Id, Map<Id, Double>> getClassGrades() {

        return new Map<Id, Map<Id, Double>>();

    }

}

