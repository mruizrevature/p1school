@isTest(seeAllData = true)
public with sharing class Part1Test {

    @isTest static void fibonacciTest(){
        System.assertEquals(34, Part1.fibonacci(9));
        System.assertEquals(34, Part1.fibonacci(9));
        System.assertEquals(34, Part1.fibonacci(9));
    }

    @isTest static void reverseStringTest(){
        System.assertEquals('olleH', Part1.reverseString('Hello'));
        System.assertEquals('hsoJ', Part1.reverseString('Josh'));
        System.assertEquals('tseb eht si tantiF', Part1.reverseString('Fitnat is the best'));
        }

    @isTest static void isPalindromeTest(){

        System.assertEquals(true, Part1.isPalindrome('lol'));
        System.assertEquals(true, Part1.isPalindrome('bob'));
        System.assertEquals(false, Part1.isPalindrome('loosl'));


    }
    @isTest static void factorialTest(){
        System.assertEquals(120, Part1.factorial(5));
    
    }

    @isTest static void getAccountsForAGivenStateTest(){

        List<Account> j = Part1.getAccountsForAGivenState(State.CA);
        System.assert(j.size()>=1, 'Actual: ' + j.size());
    }

}
