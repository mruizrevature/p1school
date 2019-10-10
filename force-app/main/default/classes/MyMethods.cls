public with sharing class MyMethods {
    /**
     *  Given a state, return the accounts in that state.
     *  I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(State s) {
        List<Account> accountList = [
            SELECT 
                Id 
            FROM Account 
            WHERE BillingState =: s.name()];

        List<Contact> contactList = [
            SELECT 
                AccountId 
            FROM Contact 
            WHERE MailingState =: s.name()];
            
        List<Account> resultList = new List<Account>();
    
        for (Account account : accountList) {

            Object accountId = account.get('Id');

            Boolean accountHasContact = false;
            Integer i = 0;
            while (!accountHasContact && i < contactList.size()) {
                Object contactsAccountId = contactList[i].get('AccountId');

                if (accountId.equals(contactsAccountId)) {
                    resultList.add(account);
                    accountHasContact = true;
                }
                ++i;
            }
        }
        return resultList;
    }
}
