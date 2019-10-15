public with sharing class Main {
    public Main() {
        
        System.debug('number: ' + P0.fibonacci(0));

        System.debug('\nreversed string: ' + P0.reverseString('whats up man'));

        System.debug('\n factorial: ' + P0.factorial(3));

        System.debug('\n is it a palindrome: ' + P0.isPalindrome('racecar'));

        System.debug('\n Accounts from state: ' + P0.getAccountsForAGivenState(State.CA));

        System.debug('\n class grades by student: ' + P0.getClassGrades());


    }
}
