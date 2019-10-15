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
    
    //*** complete */
    public static String reverseString(String s) {
    	return s.reverse();
    }
    
    //*** complete */
    public static Integer factorial(Integer n) {
        if(n==0){
            return 1;
        }
        else{
        	return(n*factorial(n-1));
    	}
    }

    //*** complete */    
    public static Boolean isPalindrome(String s) {
        return s==s.reverse();
    }
    
    
    //*** complete */
    public static List<Account> getAccountsForAGivenState(State s) {
        String state = s.name();
        List<Contact> Contacts = [SELECT MailingStreet FROM Contact WHERE AccountAddMatch__c = TRUE AND MailingState = :state ];
        List<Account> Accounts = [SELECT Name, ID, BillingStreet FROM Account WHERE BillingState= :state]; 
        List<Account> returnList = new List<Account>();
        for (Account Account:Accounts){
            for(Contact Contact:Contacts){
                if (Account.Billingstreet==Contact.Mailingstreet){
                returnList.add(Account);
                }
            }
        }
        return returnList;
    }
    
    /**
     * For each student, get the grade for each of their classes.
    
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        List<Grade__c> grades = [SELECT Class_Enrollment__c,Grade__c FROM Grade__c];
        Map<Id, Double> gradeTotal = new Map<Id, Double>();
        for(Grade__c grade : grades){
            
        }
      
            
        }
     return returnMap;
    }
     * */


    
}