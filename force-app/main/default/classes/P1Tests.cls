@isTest
public with sharing class P1Tests {
    @TestSetup
    static void makeData () {
        Account mockAccount = new Account();
        Contact mockContact = new Contact();
        Account mockAccount2 = new Account();
        Contact mockContact2 = new Contact();

        mockAccount.Name = 'GenePoint';
        mockAccount.BillingState = 'CA';
        insert(mockAccount);

        mockContact.LastName = 'Bond';
        mockContact.AccountId = mockAccount.Id;
        mockContact.MailingState = 'CA';
        insert(mockContact);

        mockAccount2.Name = 'Edge';
        mockAccount2.BillingState = 'NY';
        insert(mockAccount2);

        mockContact2.LastName = 'Allen';
        mockContact2.AccountId = mockAccount.Id;
        mockContact2.MailingState = 'NJ';
        insert(mockContact2);
    }

    @isTest static void testFibonacci () {
        // Action
        Integer fibNo = P1.fibonacci(12);

        // Result
        System.assertEquals(144, fibNo);
    }

    @isTest static void testReverseString () {
        // Action
        String str = P1.reverseString('Hello World!');

        // Result
        System.assertEquals('!dlroW olleH', str);
    }

    @isTest static void testFactorial () {
        // Action
        Integer fact = P1.factorial(4);

        // Result
        System.assertEquals(24, fact);
    }

    @isTest static void testIsPalindrome () {
        // Action
        Boolean pal = P1.isPalindrome('a toyota');

        // Result
        System.assertEquals(true, pal);
    }

    @isTest static void testGetAccountsForAGivenState () {
        // Action
        List<Account> accList = P1.getAccountsForAGivenState(States.CA);

        // Result
        System.assertEquals(1, accList.size());
    }
}