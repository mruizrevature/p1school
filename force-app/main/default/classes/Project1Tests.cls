@isTest//(seeAllData=true)
public with sharing class Project1Tests {
    @TestSetup
    static void makeData(){
        Account acc = new Account(
            Name = 'test', 
            BillingState = 'CA');
        insert acc;
        Contact cc = new Contact(
            LastName = 'test', 
            MailingState = 'CA',
            AccountId = acc.id);
        insert cc;
        Account acc2 = new Account(Name = 'test');
        insert acc2;
        
        SchoolDataCreator.createData();
        // Class Enrollment creator
        ClassEnrollment__c ce = new ClassEnrollment__c(
            Class__c = [SELECT Id FROM Class__c][0].Id, 
            Student__c = [SELECT Id FROM Student__c][0].Id, 
            Credits__c = 1, 
            Status__c = 'Enrolled'
            ); insert ce;
        // Grade creator
        for (Integer i = 0; i < 3; i++) {
            Grade__c g = new Grade__c(
                Assessment__c = [SELECT Id FROM Assessment__c][0].Id,
                Class_Enrollment__c = [SELECT Id FROM ClassEnrollment__c][0].Id,
                Grade__c = 70 + 10 * i
            ); insert g;
        }
    }
    @isTest static void testFibonacci() {
        Integer zeroth = Project1.fibonacci(0);
        Integer first = Project1.fibonacci(1);
        Integer eighth = Project1.fibonacci(46); 
        Integer negative = Project1.fibonacci(-1);

        System.assertEquals(0, zeroth);
        System.assertEquals(1, first);
        System.assertEquals(1836311903, eighth);
        System.assertEquals(-1, negative);
    }
    @isTest static void testReverseString() {
        String even = Project1.reverseString('Hello world!');
        String odd = Project1.reverseString('Racecar');
        String empty = Project1.reverseString('');

        System.assertEquals('Hello world!'.reverse(), even);
        System.assertEquals('Racecar'.reverse(), odd);
        System.assertEquals(''.reverse(), empty);
    }
    @isTest static void testFactorial() {
        Integer zeroth = Project1.factorial(0);
        Integer first = Project1.factorial(1);
        Integer fifth = Project1.factorial(5);
        Integer negative = Project1.factorial(-4);

        System.assertEquals(1, zeroth);
        System.assertEquals(1, first);
        System.assertEquals(120, fifth);
        System.assertEquals(-1, negative);
    }
    @isTest static void testPalindrome() {
        String even = Project1.reverseString('anna');
        String odd = Project1.reverseString('racecar');
        String empty = Project1.reverseString('');

        System.assertEquals('anna', even);
        System.assertEquals('racecar', odd);
        System.assertEquals('', empty);
    }
    @isTest static void testStateAccounts() {
        List<Account> all = [SELECT Id, Name FROM Account];
        List<Account> accounts = Project1.getAccountsForAGivenState(State.CA);

        System.assertEquals(2, all.size(), 'all accounts');
        System.assertEquals(1, accounts.size(), 'CA accounts');
    }
    @isTest static void testStudentClassGrades() {
        Map<Id, Map<Id, Double>> classGrades = Project1.getClassGrades();
        for (Map<Id, Double> m : classGrades.values()) {
            for (Double d : m.values()) {
                System.assertEquals(true, d < 100 && d > 50, 'Average');
            }
        }
    }
}
