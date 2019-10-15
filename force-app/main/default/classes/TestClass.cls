@isTest(seeAllData = true)

public with sharing class TestClass {



// @TestSetup
// static void makeData(){

//     Account mockAccountState = new Account();
//     mockAccountState.Name = 'Him';
//     mockAccountState.BillingState = 'CA';
//     insert mockAccountState;

//     Contact mockContactState = new Contact();
//     mockContactState.lastName ='Toby';
//     mockContactState.MailingState = 'CA';
//     mockContactState.id = mockAccountState.Id;
//     insert mockContactState;

//     mockAccountState.Name = 'Her';
//     mockAccountState.BillingSTate = 'PA';
//     insert mockAccountState;

//     mockAccountState.Name = 'It';
//     mockAccountState.BillingSTate = 'DE';
//     insert mockAccountState;


// } 

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
        mockContactState.id = mockAccountState.Id;
        insert mockContactState;

        mockAccountState.Name = 'Her';
        mockAccountState.BillingSTate = 'PA';
        insert mockAccountState;

        mockAccountState.Name = 'It';
        mockAccountState.BillingSTate = 'DE';
        insert mockAccountState;

        System.assertEquals(1, P1Test.getAccountsForAGivenState(State.CA).size());
        
    }

    @isTest
    static void  testgetClassGrades(){
        System.debug(P1Test.getClassGrades());
    }

}