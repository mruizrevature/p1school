/**
 * Created by gamedevmadeeasy on 10/12/19.
 */

@IsTest
private class AccountForGivenStateTest {
    @isTest static void getAccountsForAGivenStateTest(){

        List<Account> j = AccountForGivenState.getAccountsForAGivenState(State.CA);
        System.assert(j.size()>=1, 'Actual: ' + j.size());
    }
}