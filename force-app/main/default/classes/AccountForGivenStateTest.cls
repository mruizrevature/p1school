/**
 * Created by gamedevmadeeasy on 10/12/19.
 */

@IsTest
private class AccountForGivenStateTest {
    @TestSetup static void InitTest() {

    }

    @isTest static void getAccountsForAGivenStateTest(){
        List<Account> customAccountTest = AccountForGivenState.getAccountsForAGivenState(State.VA);
        System.assert(customAccountTest.size() >= 1, 'Actual: ' + customAccountTest.size());
    }
}