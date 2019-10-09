@isTest
public with sharing class TestClass {
  


@TestSetup
static void makeData(){
    
} 

        @isTest
        static void testFibonacci(){
            System.assertEquals(1, Test.fibonacci(1));
            System.assertEquals(2, Test.fibonacci(3));
            System.assertEquals(5, Test.fibonacci(5));


    }

        @isTest
        static void testReverseString(){
           
            System.assertEquals('god', Test.reverseString('dog'));
            System.assertEquals('rats', Test.reverseString('star'));
            System.assertEquals('enohp', Test.reverseString('phone'));

        }

        @isTest
        static void testFactorial(){
           System.assertEquals(1, Test.factorial(0));
           System.assertEquals(120, Test.factorial(5));
           System.assertEquals(6, Test.factorial(3));

        }

        @isTest
        static void testIsPalindrome(){
            System.assertEquals(True, Test.isPalindrome('dod'));
            System.assertEquals(True, Test.isPalindrome('racecar'));
            System.assertEquals(True, Test.isPalindrome('mom'));
            
        }

        @isTest
        static void testGetAccountsForAGivenState(){
           
        }










}