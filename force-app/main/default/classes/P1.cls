public with sharing class P1 {
	/*** complete* */ 
	public static Integer fibonacci(Integer n) {       
        if(n<0){
            return null;
        }
        Integer fib0=0,fib1=1,fib2=1;
        for(Integer i=1;i<n;++i){    
 			fib2=fib0+fib1;        
  			fib0=fib1;    
  			fib1=fib2;    
 		}    
  		return fib2; 
	}
    
    /*** complete* */ 
    public static String reverseString(String s) {
    	return s.reverse();
    }
    
    /*** complete* */ 
    public static Integer factorial(Integer n) {
        if(n==0){
            return 1;
        }
        else{
        	return(n*factorial(n-1));
    	}
    }
        
    /*** complete**/
    public static Boolean isPalindrome(String s) {
        if(s==s.reverse()){
            return true;
        }
        return false;
    }
    
    /**
     *  Given a state, return the accounts in that state.
     *  I only want the accounts that have a contact who works at the same place as the account.
     * */
    /** public static List<Account> getAccountsForAGivenState(State s) {
        return new List<Account>();
    }
    
    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        return new Map<Id, Map<Id, Double>>();
    }
    
}