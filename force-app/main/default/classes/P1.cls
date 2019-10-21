public class P1 {
    /**
* Return the nth fibonacci number in the fibonacci sequence.
* It should start 1,1,2,3...
* */
    public static Integer fibonacci(Integer n) {
        if (n < 0){
            return -1;
        }
        else if (n == 0 ){
            return 0;
        }
        else if(n == 1){
            return 1;
        }
        else if ( n >= 2){
            
            //the formula above was too much of a hassle
            return  fibonacci(n-1) + fibonacci(n-2);
        }
        else{
            return 0;
        }
    }
    
    /**
* Use recursion to compute the factorial of a given number.
* */
    public static Integer factorial(Integer n) {
        if (n < 0){
            return -1;
        }
        if( (n == 0) || (n == 1)){
            return 1;
        }
        if (n > 1){
            return n * factorial(n-1);
        }
        return 0;
    }
    
    
    /**
* Given a string, return its backwards order.
* */
    public static String reverseString(String s) {
        List<String> myReverse = new List<String>();
        for (Integer i = s.length()-1; i >= 0; i--){
            myReverse.add(s.substring(i,i+1));
        }
        String y ='';
        for(String x : myReverse){
            y = y + x;
        }
        return y;
    }
    
    
    /**
* Given a string, determine if it is a palindrome.
* */
    public static Boolean isPalindrome(String s) {
        String x = reverseString(s);
        if (x.equals(s)){
            return true;
        }else{
            
            return false;
        }
    }
    
    /**
*  Given a state, return the accounts in that state.
* 	I only want the accounts that have a contact who works at the same place as the account.
* */
    public static List<Account> getAccountsForAGivenState(State s) {
        //State is an enum
        //String state = String.valueOf(s);
        List<Account> acct = [SELECT Id, Name, BillingState FROM Account WHERE (BillingState =: s.name()) AND Id IN( SELECT AccountId FROM Contact WHERE MailingState=: s.name())];
        return acct;
    }
    
    /**
* For each student, get the grade for each of their classes.
* */  
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        //student id points to grade id
        //grab grade pointed to from the class and then get the one that maps to the student id.
      
        AggregateResult[] gr = [SELECT  AVG(Grade__c)avgGrade, Class_Enrollment__c, Class_Enrollment__r.Student__c 
                                FROM Grade__c 
                                GROUP BY Class_Enrollment__c, Class_Enrollment__r.Student__c
                                ];


        //maybe get the grade from gr and sum it and average it for each student?
        Map<Id, Map<Id, Double>> theGrade = new Map<Id, Map<Id, Double>>();
        for(AggregateResult grades: gr){
            Map<Id, Double> classToGrade = new Map<Id, Double>();
            classToGrade.put((Id)grades.get('Class_Enrollment__c'), (Double)grades.get('avgGrade'));
            theGrade.put((Id)grades.get('Student__c'), classToGrade);
        }        
         return theGrade;    //private 
   }
    
}