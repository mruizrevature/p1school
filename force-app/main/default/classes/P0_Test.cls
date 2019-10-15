@isTest

public with sharing class P0_Test {
    @isTest static void testFibonacci(){
       System.assertEquals(0, P0.fibonacci(-1));
   }

    @isTest static void testReverseString(){
       System.assertEquals('enoyreve ih', P0.reverseString('hi everyone'));
   }

    @isTest static void testFactorial(){
       System.assertEquals(120, P0.factorial(5));
   }

    @isTest static void testIsPalindrome(){
       System.assertEquals(true, P0.isPalindrome('racecar'));
   }

    @isTest static void testGetAccountsForAGivenState(){
       System.assertEquals([Select Id, Name, (SELECT Id FROM Contacts WHERE MailingState = 'CA') from Account WHERE BillingState = 'CA'], P0.getAccountsForAGivenState(State.CA));
    }

  //  @isTest static void testGetClassGrades(){
 //      System.assertEquals(13, P0.getClassGrades(7));
 //  }
}
