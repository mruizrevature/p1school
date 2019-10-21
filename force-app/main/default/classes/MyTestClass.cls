@isTest

public with sharing class MyTestClass {
    @isTest static void testFibonacci(){
       System.assertEquals(0, P1.fibonacci(-1));
   }

    @isTest static void testReverseString(){
       System.assertEquals('enoyreve ih', P1.reverseString('hi everyone'));
   }

    @isTest static void testFactorial(){
       System.assertEquals(120, P1.factorial(5));
   }

    @isTest static void testIsPalindrome(){
       System.assertEquals(true, P1.isPalindrome('racecar'));
   }

    @isTest static void testGetAccountsForAGivenState(){
       System.assertEquals([Select Id, Name, (SELECT Id FROM Contacts WHERE MailingState = 'CA') from Account WHERE BillingState = 'CA'], P1.getAccountsForAGivenState(State.CA));
    }

  //  @isTest static void testGetClassGrades(){
 //      System.assertEquals(13, P1.getClassGrades(7));
 }