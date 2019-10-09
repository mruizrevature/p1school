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
        List<Account> getAccountList = [SELECT Id, Name FROM Account WHERE billingState = :stateString];

        return getAccountList;
    }
}