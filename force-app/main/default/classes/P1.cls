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
            //return ((Math.pow(((1+Math.sqrt((Double)5))/2),n)) - (Math.pow(((1-Math.sqrt((Double)5))/2),n)))/Math.sqrt((Double)5);
            //the formula above is too much of a hassle
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
        //Integer result = 1;
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
             //myReverse.add(s.charAt(i));
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
        List<Account> acc = [SELECT Id, Name, BillingState FROM Account WHERE BillingState =: s.name()];
        //List<Account> acc = [SELECT Id, Name FROM Account WHERE BillingState =: s.name];
        List<Contact> cont = [SELECT MailingState FROM Contact WHERE MailingState =: s.name()];
        //List<Contact> cont2 =[SELECT MailingState FROM Contact WHERE Contact.Account.BillingState =: s.name() AND MailingState=:s.name()];
        List<Account> acct = [SELECT Id, Name, BillingState, (SELECT Name, MailingState FROM Contact) FROM Account WHERE BillingState =: s.name() && MailingState = BillingState];
        List <Account> acct2= new List<Account>();
        for(Account a: acc){
            for (Contact x: cont){
                if (a.BillingState == s.name()){
                    if(a.BillingState == x.MailingState){
                        acct2.add(a);
                    } 
                }
            }
        }
        return acct2;
    }

    /**
     * For each student, get the grade for each of their classes.
     * */
    public static Map<Id, Map<Id, Double>> getClassGrades() {
	    //student id points to grade id
        //grab grade pointed to from the class and then get the one that maps to the student id.
        Student__c mystudent = [SELECT Id, Name, (SELECT Class__c FROM ClassEnrollments__r) FROM Student__c LIMIT 1];
        List <ClassEnrollment__c> enrollments = [SELECT Id, Class__c, Student__c FROM ClassEnrollment__c WHERE Student__c =: mystudent.id];

        // get list of classids
        List<Id> classIds = new List<Id>();
        for(ClassEnrollment__c ce: enrollments){
            classIds.add(ce.Class__c);
        }

        List<Assessment__c> assessments = [SELECT Id, Class__c FROM Assessment__c WHERE Class__c IN: classIds];

        List<Id> assessIds = new List<Id>();
        for(Assessment__c assement : assessments){
            assessIds.add(assement.Id);
        }
        //list of student ids
        List<Id> studentIds = new List<Id>();

        
        List<Grade__c> gr = [SELECT Id, Grade__c, Class_Enrollment__c, Assessment__c FROM Grade__c WHERE Assessment__c IN: assessIds];

        //maybe get the grade from gr and sum it and average it for each student?
        Map<Id, Map<Id, Double>> theGrade = new Map<Id, Map<Id, Double>>();
        Map<Id, Double> classToGrade = new Map<Id, Double>();

        //for(Student__c stu : mystudents){
            for(ClassEnrollment__c ce : enrollments){
                Double sumOfGrades = 0.0;
                Double numOfGrades = 0.0;
                for(Assessment__c assess : assessments){
                    for(Grade__c grades : gr){
                        if(grades.Class_Enrollment__c == ce.Id) { // grade belongs to current ce
                            if (ce.Student__c == mystudent.Id) { // currrent ce belongs to student
                                if (assess.Id == grades.Assessment__c) { // current grade belongs to current assessment
                                    if (assess.Class__c == ce.Class__c) { // assessmsent belongs to class
                                        sumOfGrades += grades.Grade__c;
                                        numOfGrades += 1;
                                        break; // Should I do this
                                    }
                                }
                            }
                            //classToGrade.put(assess.Id,sumOfGrades/numOfGrades);
                        }
                        //classToGrade.put(assess.Id,sumOfGrades/numOfGrades);
                    }
                    //classToGrade.put(assess.Id,sumOfGrades/numOfGrades);
                    
                }
                //classToGrade.put(ce.Id,sumOfGrades/numOfGrades);
            }
        theGrade.put(mystudent.Id, classToGrade);
        return theGrade;
    }
    //private 
}