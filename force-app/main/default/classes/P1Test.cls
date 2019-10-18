@isTest
public with sharing class P1Test {

    @TestSetup
    static void makeData(){
        
        DepartmentCreator.createDepartment();
        RoomCreator.createRoom();
        TopicCreator.createTopic();
        ClassCreator.createClass();
        AssessmentCreator.createAssessment();
        AdvisorCreator.createAdvisor();
        StudentCreator.createStudent();
        ClassEnrollmentCreator.createClassEnrollment();
        GradeCreator.createGrades();

        Account mockAccount = new Account();
        mockAccount.Name = 'sForce';
        mockAccount.Phone = '4159017000';
        mockAccount.Site = 'www.sforce.com';
        mockAccount.BillingState = 'CA';
        insert mockAccount;

        Contact mockContact = new Contact();
        mockContact.LastName = 'Siddartha Nedaerk';
        mockContact.MailingState = 'CA';
        mockContact.AccountId = mockAccount.Id;
        insert mockContact;

        Contact mockContactTwo = new Contact();
        mockContactTwo.LastName = 'Jake Llorrac';
        mockContactTwo.MailingState = 'MD';
        mockContactTwo.AccountId = mockAccount.Id;
        insert mockContactTwo;
    }

    @isTest static void testFibonacci() {
        //Given
        Integer fibTestInput = 10;
        //Action
        Integer fibResult = P1.fibonacci(fibTestInput);
        //Result
        System.assertEquals(55, fibResult, 'Fibonacci number not correct. Expected: ' + 55 + ', Actual: ' + fibResult);
    }

    @isTest static void testReverseString() {
        //Given
        String myName = 'Christian';
        //Action
        String testString = P1.reverseString(myName);
        //Result
        System.assertEquals('naitsirhC', testString, 'This string actually came out to ' + testString);
    }

    @isTest static void testFactorial() {
        //Given
        Integer testInteger = 10;
        //Action
        Integer resultInteger = P1.factorial(testInteger);
        //Result
        System.assert(3628800 == resultInteger);
    }

    @isTest static void testPalindrome() {
        //Given
        String s = 'madam';
        //Action
        Boolean isPalindrome = P1.isPalindrome(s);
        //Result should be true, as madam is a palindrome
        System.assertEquals(true, isPalindrome, 'This String is not a palindrome.');
    }

    @isTest static void testGetAccountsForGivenState() {
        Account[] accounts = P1.getAccountsForAGivenState(State.CA);
        Contact expectedContact = [SELECT Id, LastName FROM Contact WHERE LastName='Siddartha Nedaerk' LIMIT 1];
        Contact resultContact;
        for(Contact actualContact: accounts[0].Contacts) {
            resultContact = actualContact;
        }
        System.debug(resultContact);
        System.debug(expectedContact);
        System.assertEquals(resultContact.Id, expectedContact.Id, 'Contacts not the same');
    }

    @isTest static void testGetClassGrades(){
        //Given Test Data with Student Grades 80% and 90%
        List<Student__c> studentId = [SELECT Id FROM Student__c LIMIT 1];
        List<ClassEnrollment__c> cId = [SELECT Class__c FROM ClassEnrollment__c];
        Map<Id, Map<Id, Double>> testedGrades = P1.getClassGrades();
        
        System.assertEquals(85.0, testedGrades.get(studentId[0].Id).get(cId[0].Class__c));
    }
}
