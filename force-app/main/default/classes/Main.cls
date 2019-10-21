public with sharing class Main {
    public Main() {
        
        System.debug('number: ' + P1.fibonacci(0));

        System.debug('\nreversed string: ' + P1.reverseString('whats up man'));

        System.debug('\n factorial: ' + P1.factorial(3));

        System.debug('\n is it a palindrome: ' + P1.isPalindrome('racecar'));

        System.debug('\n Accounts from state: ' + P1.getAccountsForAGivenState(State.CA));

        System.debug('\n class grades by student: ' + P1.getClassGrades());


    }
}
