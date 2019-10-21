public with sharing class P1 {
    /**
     * Return the nth fiboacci number in the fibonacci sequence.
     * It should start 1,1,2,3...
     * */
    public static Integer fibonacci(Integer n) {
        Integer nextSeq = 0, fibo = 0, seq = 1;

        for (Integer i=0; i<n; i++) {
            nextSeq = fibo + seq;
            seq = fibo;
            fibo = nextSeq;
        }
        return fibo;
    }
    
    /**
     * Given a string, return its backwards order.
     * */
    public static String reverseString(String s) {
        String s2 = '';

        for (Integer i=(s.length()-1); i>=0; i--) {
            s2 += s.substring(i, i+1);
        }

        return s2;
    }
    
    /**
     * Use recursion to compute the factorial of a given number.
     * */
    public static Integer factorial(Integer n) {
        Integer fac = n;

        for (Integer i=(n-1); i>0; i--) {
            fac *= i;
        }

        return fac;
    }
    
    /**
     * Given a string, determine if it is a palindrome.
     * */
    public static Boolean isPalindrome(String s) {
        s.trim();
        s = s.replaceAll('\\s', '');
        String s2 = reverseString(s);

        if (s.equals(s2))
            return true;
        else 
            return false;
    }
    
    /**
     *  Given a state, return the accounts in that state.
     * 	I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(States s) {
        List<Account> accList = [SELECT Name FROM Account WHERE BillingState =: s.name() AND Id IN (SELECT AccountId FROM Contact WHERE MailingState =: s.name())];
        return accList;
    }
    
    /**
     * For each student, get the grade for each of their classes.
     * Map< Id(Student), Map< Id(Class), Double(Grade) >>
     * Get a List of Students - What classes are they enrolled in 
     *                          - What Assessments they've taken 
     *                            - Average Grade across Assessments
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        return new Map<Id, Map<Id, Double>>();
    }
}