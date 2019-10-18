@isTest

public with sharing class AleenaTestClass {
    @TestSetup
    static void makeData(){
            // creating Accounts
          Account a = new Account(Name = 'Antony Philip', BillingState = 'NY');
          insert a;
          Account b = new Account(Name = 'Collin Matthew', BillingState = 'NJ');
          insert b;
          Account c = new Account(Name = 'Philip Thomas', BillingState = 'CA');
          insert c;   
          // creating contacts
          Contact aContact = new Contact(LastName = 'Philip',MailingState = 'NY',AccountId = a.id);
          insert aContact;    
          Contact bContact = new Contact(LastName = 'Matthew',MailingState = 'NJ',AccountId = b.id);
          insert bContact;  
          Contact cContact = new Contact(LastName = 'Thomas',MailingState = 'VA',AccountId = c.id);
          insert cContact;   

        SchoolDataCreator.createData();
        ClassEnrollmentCreator.createClassEnrollment();
        //AssessmentCreator.createAssessment();
        List<Grade__c> gradeList = new List<Grade__c>();
        for (Integer i = 0; i < 5; i++) {
            Grade__c grade = new Grade__c();
            List<Assessment__c> mockAssessments = [SELECT Id FROM Assessment__c LIMIT 1];
            List<ClassEnrollment__c> mockEnrollment = [SELECT Id FROM ClassEnrollment__c LIMIT 1];
            grade.Assessment__c = mockAssessments[0].Id;
            grade.Class_Enrollment__c = mockEnrollment[0].Id;
            grade.Grade__c = 20*i;
            gradeList.add(grade);
        }
        insert gradeList;
    } 
    
    // Return the nth fiboacci number in the fibonacci sequence.
    @isTest static void testFibonacci(){
        Integer num = P0.Fibonacci(10);
        
        System.assertEquals(55,num);
    }
    
      //Given a string, return its backwards order.
     @isTest static void testreverseString(){
         List<String> reversedString = new List<String>{P0.reverseString('Aleena')}; 
             List<String> stringCheck = new List<String>{'aneelA'};
        System.assertEquals(stringCheck,reversedString);
    }
    
    //Given a string, determine if it is a palindrome
    @isTest static void testisPalindrome(){
         Boolean reversedString = P0.isPalindrome('Aleena'); 
        System.assertEquals(false,reversedString);
        reversedString = P0.isPalindrome('Hannah');
          System.assertEquals(true,reversedString);
          
    }
    //computes the factorial of a given number using recursion.
    @isTest static void testfactorial(){
         Integer factorialOfNumber = P0.factorial(5); 
        System.assertEquals(120,factorialOfNumber);
    } 

    //Given a state, return the accounts in that state
    @isTest static void testgetAccountsForAGivenState(){
        List<Account> testAccount = P0.getAccountsForAGivenState(State.NY);
        System.assertEquals(1, testAccount.size());
    }

    //For each student, get the grade for each of their classes
    @isTest static void testgetClassGrades(){
        Map<Id, Map<Id, Double>> grades = P0.getClassGrades();
        for (Map<Id, Double> gradeTest : grades.values()) {
            for (Double d : gradeTest.values()) {
                System.assertEquals(d, 40);
            }
        }
    }
}
