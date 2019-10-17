@isTest()
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

        schoolDataCreator.createData();
        schoolDataCreator.createClassEnrollments();
        List<ClassEnrollment__c> ceList = [SELECT Id FROM ClassEnrollment__c];
        List<Assessment__c> assessmentList = [SELECT Id FROM Assessment__c];
        List<Grade__c> gradeList = new List<Grade__c>();
        
        Grade__c g1 = new Grade__c();
        g1.Assessment__c = assessmentList[0].Id;
        g1.Class_Enrollment__c = ceList[0].Id;
        g1.Grade__c = 60;
        gradeList.add(g1);
        Grade__c g2 = new Grade__c();
        g2.Assessment__c = assessmentList[1].Id;
        g2.Class_Enrollment__c = ceList[0].Id;
        g2.Grade__c = 70;
        gradeList.add(g2);
        Grade__c g3 = new Grade__c();
        g3.Assessment__c = assessmentList[0].Id;
        g3.Class_Enrollment__c = ceList[1].Id;
        g3.Grade__c = 100;
        gradeList.add(g3);
        Grade__c g4 = new Grade__c();
        g4.Assessment__c = assessmentList[1].Id;
        g4.Class_Enrollment__c = ceList[1].Id;
        g4.Grade__c = 80;
        gradeList.add(g4);


        insert gradeList;
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

    @isTest()
    public static void testGetClassGrades()
    {
        Map<Id, Map<Id, Double>> studentGrades = P1.getClassGrades();
        List<Grade__c> grades = [SELECT Id, Class_Enrollment__c FROM Grade__c];
        Set<Id> ce1 = new Set<Id>();
        for(Grade__c g: grades)
        {
            ce1.add(g.Class_Enrollment__c);
        }
        List<ClassEnrollment__c> ce = [SELECT Id, Student__c, Class__c FROM ClassEnrollment__c WHERE Id IN :ce1];
        System.assertEquals(2, studentGrades.size());
        
        System.assertEquals(65, studentGrades.get(ce[0].Student__c).get(ce[0].Class__c));
        System.assertEquals(90, studentGrades.get(ce[1].Student__c).get(ce[1].Class__c));
    }


}