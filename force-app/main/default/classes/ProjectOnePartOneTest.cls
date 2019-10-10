@istest
public with sharing class ProjectOnePartOneTest {
    
    @istest static void fibonacciTest(){
        System.assertEquals(3, ProjectOnePartOne.fibonacci(4), 'Value is wrong');
        System.assertEquals(5, ProjectOnePartOne.fibonacci(5), 'Value is wrong');
    }

    @istest static void reverseStringTest(){
        System.assertEquals('god', ProjectOnePartOne.reverseString('dog'), 'method didnt reverse');
        System.assertEquals('now', ProjectOnePartOne.reverseString('won'), 'method didnt reverse');
    }

    @istest static void factorialTest(){
        System.assertEquals(1, ProjectOnePartOne.factorial(1), 'factorial didnt factorize');
        System.assertEquals(2, ProjectOnePartOne.factorial(2), 'factorial didnt factorize');
        System.assertEquals(6, ProjectOnePartOne.factorial(3), 'factorial didnt factorize');
        System.assertEquals(120, ProjectOnePartOne.factorial(5), 'factorial didnt factorize');
    }
    
    @istest static void isPalindromeTest(){
        System.assertEquals(false, ProjectOnePartOne.isPalindrome('dog'), 'palindrome false positive');
        System.assertEquals(true, ProjectOnePartOne.isPalindrome('mom'), 'palindrome false negative');
    }

    @istest static void getAccountsForAGivenStateTest(){
        //case for no matching state
        Account a1 = new Account();
        a1.Name = 'Stateless inc';
        a1.BillingState = 'MD';
        insert a1;
        System.assertEquals(0,ProjectOnePartOne.getAccountsForAGivenState(State.VA).size(), 'false positive for account');
        //case for matching state for accounts but not contacts
        Contact c1 = new Contact();
        c1.LastName = 'Beck';
        c1.MailingState = 'VA';
        c1.AccountId = a1.Id;
        insert c1;
        System.assertEquals(0,ProjectOnePartOne.getAccountsForAGivenState(State.MD).size(), 'false positive for matching account + unmatching contact');
        //case for matching state for contacts but not not accounts
        System.assertEquals(0,ProjectOnePartOne.getAccountsForAGivenState(State.VA).size(), 'false positive for unmatching account + matching contact');
        //case for matching state for accounts + SOME contacts
        Contact c2 = new Contact();
        c2.LastName = 'Jith';
        c2.MailingState = 'MD';
        c2.AccountId = a1.Id;
        insert c2;
        System.assertEquals(1,ProjectOnePartOne.getAccountsForAGivenState(State.MD).size(), 'false negative for matching account + SOME matching contacts');
        //case for matching state for accounts + ALL contacts
        c1.MailingState = 'MD';
        update c1;
        System.assertEquals(1,ProjectOnePartOne.getAccountsForAGivenState(State.MD).size(), 'false negative for matching account + ALL matching contacts');
    }



}
