@isTest
public class P1Tests 
{

    @TestSetup
    static void makeData()
    {
        Account a = new Account();
        a.name = 'Billy';
        a.BillingState = 'AZ';
        a.phone = '1234567890';
        insert a;

        a = new Account();
        a.name = 'Steven';
        a.BillingState = 'CO';
        a.phone = '1111111111111';
        insert a;

        a = new Account();
        a.name = 'Steven';
        a.BillingState = 'AZ';
        a.phone = '1111111111111';
        insert a;

        Contact c = new Contact();
        c.lastName = 'Chris';
        c.accountId = a.Id;
        c.MailingState = 'AZ';
        insert c;

        c = new Contact();
        c.lastName = 'Quentin';
        c.accountId = a.Id;
        c.MailingState = 'PA';
        insert c;

        c = new Contact();
        c.lastName = 'Roderigo';
        c.accountId = a.Id;
        c.MailingState = 'CO';
        insert c;
    }

    @isTest
    public static void testFibonacci()
    {
        System.assertEquals(0, P1.fibonacci(0));
        System.assertEquals(1, P1.fibonacci(1));
        System.assertEquals(0, P1.fibonacci(-7));
        System.assertEquals(21, P1.fibonacci(8));
    }

    @isTest
    public static void testReverseString()
    {
        System.assertEquals('olleh', P1.reverseString('hello'));
        System.assertEquals('OlLeH', P1.reverseString('HeLlO'));
        System.assertNotEquals('penguin', P1.reverseString('penguin'));
        System.assertNotEquals('Niugnep', P1.reverseString('Penguin'));
    }

    @isTest
    public static void testFactorial()
    {
        System.assertEquals(0, P1.factorial(0));
        System.assertEquals(1, P1.factorial(1));
        System.assertEquals(0, P1.factorial(-37));
        System.assertEquals(5040, P1.factorial(7));
    }

    @isTest
    public static void testIsPalindrome()
    {
        System.assertEquals(true, P1.isPalindrome('anna'));
        System.assertEquals(true, P1.isPalindrome('Racecar'));
        System.assertEquals(true, P1.isPalindrome('TACOCAT'));
        System.assertEquals(true, P1.isPalindrome('0110'));
        System.assertEquals(false, p1.isPalindrome('FISH'));
    }

    @isTest
    public static void testGetAccountsForAGivenState()
    {
        System.assertEquals(1, P1.getAccountsForAGivenState(State.AZ).size());
        System.assertEquals(0, P1.getAccountsForAGivenState(State.WY).size());
        System.assertEquals(0, P1.getAccountsForAGivenState(State.CO).size());
        System.assertEquals(0, P1.getAccountsForAGivenState(State.PA).size());
    }


}
