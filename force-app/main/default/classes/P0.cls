public with sharing class P0 {
    
    // Return the nth fiboacci number in the fibonacci sequence.
    public static integer Fibonacci(integer n) { 
        integer num1 = 1;
        integer num2 = 1;
        for (integer i=2; i<n; i++) {
            integer fibo = num2 + num1;
            num1 = num2;
            num2 = fibo;
        }
        return num2;
    }

    //Given a string, return its backwards order.
    public static String reverseString(String s) {
        integer stringLength = s.length();
        String[] arrayOfString = new List<String>();
        for(integer i=stringLength-1; i>=0; i--) {
            arrayOfString.add(s.substring(i,i+1));
        }
        s = String.join(arrayOfString,'');
        return s;
    }

    //Given a string, determine if it is a palindrome
    public static Boolean isPalindrome(String s) {
        if(P0.reverseString(s)==s)
        return true;
        else {
            return false;
        }
    }

    //computes the factorial of a given number using recursion.
    public static Integer factorial(Integer n) {
        if(n>=1){
            return n*factorial(n-1);
        }
        else {
            return 1;
        }
    }

    //Given a state, return the accounts in that state
    public static List<Account> getAccountsForAGivenState(State s) {
       Account[] acc = [SELECT Account.Name, ( SELECT FirstName, LastName FROM Contacts WHERE MailingState=:s.name() ) FROM Account WHERE BillingState=:s.name()];
        return acc;
    }


    //For each student, get the grade for each of their classes
    public static Map<Id, Map<Id, Double>> getClassGrades() {
        
        List<ClassEnrollment__c> classenrollments = [SELECT Name, Id,ClassEnrollment__c.Class__r.Id, ClassEnrollment__c.Student__r.Name, ClassEnrollment__c.Student__r.Id FROM ClassEnrollment__c];// 
        List<Grade__c> grades = [SELECT Name, Grade__c, Grade__c.Class_Enrollment__r.Student__c, Grade__c.Class_Enrollment__r.Name,Grade__c.Class_Enrollment__r.Id, Grade__c.Assessment__r.Name FROM Grade__c];
        List<Student__c> students = [SELECT Id FROM Student__c];
        Map<Id, Map<Id, Double>> avgGradeForStudent = new Map<Id, Map<Id, Double>>();
        for(Student__c stud : students){ // For each student
             Map<Id, Double> averageGradeForClass = new Map<Id, Double>();
        	for (ClassEnrollment__c ce : classenrollments) { // For each class enrollment
            	Double sumOfGrade = 0.0;
            	Double numberOfGrades = 0.0;
            	Double avgGrade = 0.0;
                if(ce.Student__c == stud.Id){
            	for (Grade__c gr : grades) {
                	if((ce.Id == gr.Class_Enrollment__c)){
                    	sumOfGrade += gr.Grade__c;
                    	numberOfGrades += 1;
                    	avgGrade = sumOfGrade/numberOfGrades; //Average Grade
                    } 
                averageGradeForClass.put(ce.Id,avgGrade);// Average grade for each class enrollments   
                }
                avgGradeForStudent.put(ce.Student__c, averageGradeForClass); 
                }
            } 

        }
        return avgGradeForStudent; 
    }
}
