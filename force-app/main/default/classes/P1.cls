public class P1
{
    /**
     * Return the nth fiboacci number in the fibonacci sequence.
     * It should start 1,1,2,3...
     * */
    public static Integer fibonacci(Integer n) 
    {
        if(n==0 || n==1)
        {
            return n;
        }
        else if(n<0)
        {
            return 0;
        }
        else 
        {
            return fibonacci(n-1) + fibonacci(n-2);    
        }
    }

    /**
     * Given a string, return its backwards order.
     * */
    public static String reverseString(String s) 
    {
        Integer[] chars = s.getChars();
        List<Integer> backwardsChars = new List<Integer>();
        Integer size = chars.size();
        for(Integer i=size-1; i>=0; i--)
        {
            backwardsChars.add(chars[i]);
        }

        return String.fromCharArray(backwardsChars);
    }


    /**
     * Use recursion to compute the factorial of a given number.
     * */
    public static Integer factorial(Integer n) 
    {
        if(n<0)
        {
            return 0;
        }
        else if(n==1)
        {
            return 1;
        }
        else 
        {
            return n * factorial(n-1);
        } 
    }


    /**
     * Given a string, determine if it is a palindrome.
     * */
    public static Boolean isPalindrome(String s) 
    {
        s = s.toLowerCase();
        Integer[] chars = s.getChars();
        Integer size = chars.size();
        for(Integer i=0; i<size; i++)
        {
            if(chars[i]!=chars[size-i-1])
            {
                return false;
            }
        }
        return true;
    }


    /**
     *  Given a state, return the accounts in that state.
     * 	I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(State s) 
    {
        List<Account> acc = [SELECT Name FROM Account WHERE BillingState =: s.name() AND Id IN (SELECT AccountId FROM Contact WHERE MailingState =: s.name())];
        return acc;
    }
}
