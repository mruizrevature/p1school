public class P1 {
    /**
     * Return the nth fiboacci number in the fibonacci sequence.
     * It should start 1,1,2,3...
     * */
    public static Integer fibonacci(Integer n) {
        if (n < 0 ) {return 0;}
        else {
            switch on n{
                when null {return 0;}
                when 0 { return 0;}
                when 1 { return 1;}
                when else { return fibonacci(n-1) + fibonacci(n-2);}
            }
        }
    }

   
    
    /**
     * Given a string, return its backwards order.
     * */
    public static String reverseString(String s) {
        String[] orig = s.split(''); 
        String[] reversed = new String[orig.size()];

        Integer i = 0;
        for (Integer j = orig.size() - 1; j >= 0; j--){
            reversed[i] = orig[j];
            i++;
        }

        return String.join(reversed, '');
    } 
    
    /**
     * Use recursion to compute the factorial of a given number.
     * */
    public static Integer factorial(Integer n) {
        if (n == 0 || n == 1) return 1;
        return n * factorial(n-1);
    }
    
    /**
     * Given a string, determine if it is a palindrome.
     * */
    public static Boolean isPalindrome(String s) {
        return (s == P1.reverseString(s) ? True:False);
    }
    
    /**
     *  Given a state, return the accounts in that state.
     *  I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(State s) {
        
        //SELECT MailingState from Contact

        return [SELECT Id, Name, (SELECT Id FROM Contacts WHERE MailingState =: s.Name()) FROM Account WHERE BillingState =: s.Name()];
        
   }
    
    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() { // student id, class id, grade
        // Get classes student is enrolled in
        // get assessments for each class
        // get grades for each assessment
        // for each student, for each class, for each assessment, for each grade, if gradeCE.student = student.id && a.class == grade.ce.class
        return [SELECT Id, (SELECT Id, AVG(grade)  from Assessment Group BY Id) FROM Student GROUP BY Id];
    }
}