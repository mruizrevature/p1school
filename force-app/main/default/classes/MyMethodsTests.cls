@isTest
public with sharing class MyMethodsTests {

     @isTest static void testFibonacci() {
        // Given
        List<Integer> nums = new List<Integer> {-2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8};
        List<Integer> expected = new List<Integer> {-1, -1, -1, 1, 1, 2, 3, 5, 8, 13, 21};

        // Action
        List<Integer> results = new List<Integer>();
        for (Integer i = 0; i < nums.size(); ++i) {
            results.add(MyMethods.fibonacci(nums[i]));
        }

        // Result
        for (Integer i = 0; i < results.size(); ++i) {
            System.assertEquals(expected[i], results[i]);
        }
     }

     @isTest static void testReverseString() {
        // Given
        List<String> inputStrings = new List<String> {'Hello World', 'Oak', 'Vehicle', 'Dentist', 'Yellow Submarine'};
        List<String> expectedStrings = new List<String> {'dlroW olleH', 'kaO', 'elciheV', 'tsitneD', 'enirambuS wolleY'};

        // Action 
        List<String> results = new List<String>();
        for (Integer i = 0; i < inputStrings.size(); ++i) {
            results.add(MyMethods.reverseString(inputStrings[i]));
        }

        // Result
        for (Integer i = 0; i < results.size(); ++i) {
            System.assertEquals(expectedStrings[i], results[i]);
        }
     }

     @isTest static void testFactorial() {
        // Given
        List<Integer> inputNums = new List<Integer> {-2, -1, 0, 1, 2, 3, 4, 5};
        List<Integer> expectedNums = new List<Integer> {-1, -1, 1, 1, 2, 6, 24, 120};

        // Action
        List<Integer> actualNums = new List<Integer>();
        for (Integer i = 0; i < inputNums.size(); ++i) {
            actualNums.add(MyMethods.factorial(inputNums[i]));
        }

        // Result
        for (Integer i = 0; i < actualNums.size(); ++i) {
            System.assertEquals(expectedNums[i], actualNums[i]);
        }
     }

    @TestSetup
    static void makeData() {
        // Make an account with a related contact in same state
        Account mockAccount = new Account();
        mockAccount.Name = 'Band of America';
        mockAccount.BillingState = 'CA';
        insert mockAccount;

        Contact mockContact = new Contact();
        mockContact.LastName = 'Herb';
        mockContact.MailingState = 'CA';
        mockContact.AccountId = mockAccount.Id;
        insert mockContact;

        // Make an account with a related contact not in the same state
        mockAccount = new Account();
        mockAccount.Name = 'Wand of Spain';
        mockAccount.BillingState = 'CA';
        insert mockAccount;

        mockContact = new Contact();
        mockContact.LastName = 'Geraldine';
        mockContact.MailingState = 'NC';
        mockContact.AccountId = mockAccount.Id;
        insert mockContact;

        // Make an account with a contact whose state is null
        mockAccount = new Account();
        mockAccount.Name = 'Hand of Japan';
        mockAccount.BillingState = 'CA';
        insert mockAccount;

        mockContact = new Contact();
        mockContact.LastName = 'Rex';
        mockContact.MailingState = null;
        mockContact.AccountId = mockAccount.Id;
        insert mockContact;

    }
    @isTest static void testGetAccountsForAGivenState() {
        // Given
        // inserted records in TestSetup

        //Action
        List<Account> accounts = MyMethods.getAccountsForAGivenState(State.CA);

        // Result
        System.assertEquals(1, accounts.size());
    }

}
