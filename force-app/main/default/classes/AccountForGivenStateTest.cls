/**
 * Created by gamedevmadeeasy on 10/12/19.
 */

@IsTest
private class AccountForGivenStateTest {
    @TestSetup static void InitTest() {
        Account Luke = new Account(
                Name = 'Luke Durback',
                BillingState = 'VA');
        insert Luke;
        Contact LukeDContact = new Contact(
                LastName = 'Durback',
                MailingState = 'VA',
                AccountId = Luke.id);
        insert LukeDContact;

        Account Jason = new Account(
                Name = 'Jason Yarber',
                BillingState = 'TN');
        insert Jason;
        Contact JasonYContact = new Contact(
                LastName = 'Yarber',
                MailingState = 'NC',
                AccountId = Jason.id);
        insert JasonYContact;

        Account MichellePhan = new Account(
                Name = 'Michelle Phan',
                BillingState = 'ID');
        insert MichellePhan;
        Contact MichellePhanContact = new Contact(
                LastName = 'Phan',
                MailingState = 'CA',
                AccountId = MichellePhan.id);
        insert MichellePhanContact;

    }

    @isTest static void getAccountsForAGivenStateTest(){
        List<Account> customAccountTest = AccountForGivenState.getAccountsForAGivenState(State.VA);
        System.assert(customAccountTest.size() >= 1, 'Actual: ' + customAccountTest.size());
    }
}