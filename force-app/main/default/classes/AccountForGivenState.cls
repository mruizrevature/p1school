/**
 * Created by gamedevmadeeasy on 10/12/19.
 */

public with sharing class AccountForGivenState {
    /**
     *  Given a state, return the accounts in that state.
     *  I only want the accounts that have a contact who works at the same place as the account.
     * */
    public static List<Account> getAccountsForAGivenState(State s) {
        return new List<Account>();
    }

    public enum State {
        AL, AK, AZ, AR, CA, CO, CT, DE, FL, GA, HI, ID, IL, IA, KS,
        KY, LA, ME, MD, MA, MI, MN, MS, MO, MT, NE, NV, NH, NJ, NM,
        NY, NC, ND, OH, OK, PA, RI, SC, SD, TN, TX, UT, VT, VA, WA,
        WV, WI, WY
    }
}