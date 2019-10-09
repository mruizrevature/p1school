/**
 * Created by gamedevmadeeasy on 10/9/19.
 */

@IsTest
private class accountsForAGivenStateTest {
    @TestSetup static void makeData(){
        Account BillyJoe = new Account(
                Name = 'Billy Joe',
                BillingState = 'PA');
        insert BillyJoe;
        Account BillyMae = new Account(
                Name = 'Billy Mae',
                BillingState = 'VA');
        insert BillyMae;
        Account BillyJean = new Account(
                Name = 'Billy Jean',
                BillingState = 'DE');
        insert BillyJean;
        Account RalphWaldo = new Account(
                Name = 'Ralph Waldo',
                BillingState = 'AL');
        insert RalphWaldo;
        Account BobDillan = new Account(
                Name = 'Bob Dillan',
                BillingState = 'WI');
        insert BobDillan;
        Account NaoUka = new Account(
                Name = 'Nao Uka',
                BillingState = 'DE');
        insert NaoUka;
        Account KeithUrban = new Account(
                Name = 'Keith Urban',
                BillingState = 'AL');
        insert KeithUrban;
        Account DonaldDuck = new Account(
                Name = 'Donald Duck',
                BillingState = 'AL');
        insert DonaldDuck;
        Account WangPinPin = new Account(
                Name = 'Wang Pin Pin',
                BillingState = 'WI');
        insert WangPinPin;
        Account WangPan = new Account(
                Name = 'Wang Pan',
                BillingState = 'DE');
        insert WangPan;
        Account KokiNakane = new Account(
                Name = 'Koki Nakane',
                BillingState = 'AL');
        insert KokiNakane;
        Account LukeDurback = new Account(
                Name = 'Luke Durback',
                BillingState = 'WI');
        insert LukeDurback;
        Account Josephine = new Account(Name = 'Josephine');
        insert Josephine;
    }

    @IsTest static void testAccountsForAllStates() {
        List<Account> allAccounts = [SELECT Id, Name FROM Account];
        System.assertEquals(13, allAccounts.size(), 'total accounts = 13');
    }

    @IsTest static void testAccountsForStatePA() {
        List<Account> accounts = accountsForAGivenState.getAccountsForAGivenState(State.PA);
        System.assertEquals(1, accounts.size());
    }

    @IsTest static void testAccountsForStateDE() {
        List<Account> accounts = accountsForAGivenState.getAccountsForAGivenState(State.DE);
        System.assertEquals(3, accounts.size());
    }

    @IsTest static void testAccountsForStateAL() {
        List<Account> accounts = accountsForAGivenState.getAccountsForAGivenState(State.AL);
        System.assertEquals(4, accounts.size());
    }

    @IsTest static void negativeTestAccountsForStateWI() {
        List<Account> accounts = accountsForAGivenState.getAccountsForAGivenState(State.WI);
        System.assertEquals(3, accounts.size());
    }

    @IsTest static void negativeTestAccountsForAllStates() {
        List<Account> allAccounts = [SELECT Id, Name FROM Account];
        System.assertNOTEquals(5, allAccounts.size(), 'total accounts = 13');
    }
}