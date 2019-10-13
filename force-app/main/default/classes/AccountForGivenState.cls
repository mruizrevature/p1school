/**
 * Created by gamedevmadeeasy on 10/12/19.
 */

public with sharing class AccountForGivenState {
    /**
     *  Given a state, return the accounts in that state.
     *  I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(State s) {
        String stateString = String.valueOf(s);
        List<Account> validatedData = new List<Account>();
        List<Contact> getContactList =
        [SELECT Id, Name, MailingState
        FROM Contact WHERE MailingState =: stateString];
        List<Account> getAccountList =
        [SELECT Id, Name, BillingState
        FROM Account WHERE BillingState =: stateString];

        for (Account accountData : getAccountList) {
            for (Contact contactData : getContactList) {
                if (accountData.BillingState == contactData.MailingState) {
                    validatedData.add(accountData);
                }
            }
        }
        return validatedData;
    }
}