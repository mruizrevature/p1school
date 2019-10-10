@isTest
public with sharing class MyMethodsTests {
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
