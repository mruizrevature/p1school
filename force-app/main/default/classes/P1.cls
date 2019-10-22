public class P1 {
    /**
     * Return the nth fiboacci number in the fibonacci sequence.
     * This function uses recursion.
     * */
    public static Integer fibonacci(Integer n) {

        if (n < 0) {//n < 0 returns an error
            System.debug('Please enter an input greater than 0');
            return -1;
        }
        if (n == 1) {//base acse
            return 1;
        }
        if(n > 1) { //reduction step
            return fibonacci(n-1) + fibonacci(n-2);
        }
        return 0;
    }
    
    /**
     * Given a string, return its backwards order.
     * */
    public static String reverseString(String s) {
        
        String oldString = s;
        String newString = '';

        for(Integer i = oldString.length()-1; i >= 0; i--) {
            newString = newString + oldString.substring(i, i+1);
        }
        
        return newString;
    }
    
    /**
     * Use recursion to compute the factorial of a given number.
     * */
    public static Integer factorial(Integer n) {
        //base cases
        if (n < 0){
            return -1;
        }
        else if (n == 0){
            return 0;
        }
        else if (n == 1) {
            return 1;
        }
        else {
            return n * factorial(n-1);
        }
    }
    
    /**
     * Given a string, determine if it is a palindrome.
     * */
    public static Boolean isPalindrome(String s) {
        
        String oldString = s;
        String newString = '';

        for(Integer i = oldString.length()-1; i >= 0; i--) {
            newString = newString + oldString.substring(i, i+1);
        }
        if(newString == oldString){
            return true;
        }else{
            return false;
        }
        
        
    }
    
    /**
     *  Given a state, return the accounts in that state.
     *  I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static Account[] getAccountsForAGivenState(State s) {
        
        Account[] accounts = [SELECT Name, BillingState, (SELECT Contact.Name FROM Contacts WHERE MailingState=:s.name()) 
                                FROM Account WHERE BillingState=:s.name() AND Id IN (SELECT AccountId FROM Contact WHERE MailingState=:s.name())];

        return accounts;
    }
    

    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {

        //Map of all Students and their map of respective classes and grades
        Map<Id, Map<Id, Double>> gradeMap = new Map<Id, Map<Id, Double>>();
        
        /*
            Aggregate Result of all the class enrollments, ClassId and StudentId for each respective enrollment, 
            and an average of all of the grades pointing to the class enrollment.
         */
        AggregateResult[] groupedResults = 
        [SELECT Class_Enrollment__r.Class__c classId, Class_Enrollment__r.Student__c studentId, AVG(Grade__c) courseGrade 
            FROM Grade__c 
                GROUP BY Class_Enrollment__r.Class__c, Class_Enrollment__r.Student__c];
        

        for (AggregateResult courseGrade : groupedResults) {//Create a map for each grade
            Map<Id, Double> courseMap = new Map<Id, Double>();
            //If student already exists in student map, find based on studentId key 
            //and insert grade into existing nested Map<Id, Double>
            if (gradeMap.containsKey((Id)courseGrade.get('studentId'))) {
                gradeMap.get((Id)courseGrade.get('studentId')).put((Id)courseGrade.get('classId'), (Double)courseGrade.get('courseGrade'));
            }else {//otherwise, populate a blank courseMap with the first value and put into gradeMap
                courseMap.put((Id)courseGrade.get('classId'), (Double)courseGrade.get('courseGrade'));
                gradeMap.put((Id)courseGrade.get('studentId'), courseMap);
            }
        }
        return gradeMap;
    }
}