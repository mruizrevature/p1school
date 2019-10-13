/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

public with sharing class accountsForAGivenState {
    /**
     *  Given a state, return the accounts in that state.
     *  I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(State s) {
        String stateString = String.valueOf(s);
        List<Account> getAccountList = [SELECT Id, Name, BillingState,
        (SELECT Id, Name, MailingState FROM Contacts WHERE MailingState =: stateString)
        FROM Account WHERE BillingState =: stateString];
        for (SObject accountData : getAccountList) {
            if (accountData.get('BillingState') == accountData.get('MailingState')) {
                return getAccountList;
            }
        }
    }
}