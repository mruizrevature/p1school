@isTest

public with sharing class TestClass {

    @isTest
    static void testFibonacci(){
        System.assertEquals(1, P1Test.fibonacci(1));
        System.assertEquals(2, P1Test.fibonacci(3));
        System.assertEquals(5, P1Test.fibonacci(5));


}

    @isTest
    static void testReverseString(){
        
        System.assertEquals('god', P1Test.reverseString('dog'));
        System.assertEquals('rats', P1Test.reverseString('star'));
        System.assertEquals('enohp', P1Test.reverseString('phone'));

    }

    @isTest
    static void testFactorial(){
        System.assertEquals(1, P1Test.factorial(0));
        System.assertEquals(120, P1Test.factorial(5));
        System.assertEquals(6, P1Test.factorial(3));

    }

    @isTest
    static void testIsPalindrome(){
        System.assertEquals(True, P1Test.isPalindrome('dod'));
        System.assertEquals(True, P1Test.isPalindrome('racecar'));
        System.assertEquals(True, P1Test.isPalindrome('mom'));
        
    }

    @isTest
    static void testGetAccountsForAGivenState(){

        Account mockAccountState = new Account();
        mockAccountState.Name = 'Him';
        mockAccountState.BillingState = 'CA';
        insert mockAccountState;

        Contact mockContactState = new Contact();
        mockContactState.lastName ='Toby';
        mockContactState.MailingState = 'CA';
        mockContactState.AccountId = mockAccountState.Id;
        insert mockContactState;

        mockAccountState = new Account();
        mockAccountState.Name = 'Her';
        mockAccountState.BillingSTate = 'PA';
        insert mockAccountState;

        mockAccountState = new Account();
        mockAccountState.Name = 'It';
        mockAccountState.BillingSTate = 'DE';
        insert mockAccountState;

        //size is 1
        System.assertEquals(1, P1Test.getAccountsForAGivenState(State.CA).size());
        
    }

    @isTest(SeeAllData = true) 
    static void  testgetClassGrades(){

        //SchoolDataCreator.createData();
        Student__c studentID = [SELECT id FROM Student__c LIMIT 1];
        Class__c classID = [SELECT id FROM Class__c LIMIT 1];
        //need mock data of student, grade, CE
        ClassEnrollment__c mockCE = new ClassEnrollment__c(
            Class__c = classID.Id,
            Student__c = studentID.Id,
            Credits__c = 4,
            Status__c = 'Enrolled'
        );
        insert mockCE;

        Map<Id, Map<Id, Double>> getSameGrade = P1Test.getClassGrades();
        
        for(Map<Id, Double> getGradeAndDouble : getSameGrade.values()){
            //returns size 2
            //System.assertEquals(0, getGradeAndDouble.size(), 'student: ');
            for(Double getExistingGrade : getGradeAndDouble.values()){
                //Grade is 70 or 80
                System.assertNotEquals(60,getExistingGrade);

            }
        }
    }



}