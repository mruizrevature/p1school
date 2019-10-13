@isTest

public with sharing class AleenaTestClass {
    
    @isTest static void testFibonacci(){
        Integer num = P0.Fibonacci(10);
        
        System.assertEquals(55,num);
    }
    
     @isTest static void testreverseString(){
         List<String> reversedString = new List<String>{P0.reverseString('Aleena')}; 
             List<String> stringCheck = new List<String>{'aneelA'};
        System.assertEquals(stringCheck,reversedString);
    }
    
    @isTest static void testisPalindrome(){
         Boolean reversedString = P0.isPalindrome('Aleena'); 
        System.assertEquals(false,reversedString);
        reversedString = P0.isPalindrome('Hannah');
          System.assertEquals(true,reversedString);
          
    }
    
    @isTest static void testfactorial(){
         Integer factorialOfNumber = P0.factorial(5); 
        System.assertEquals(120,factorialOfNumber);
    }  
}
