@isTest
public with sharing class MyMethodsTests {

     @isTest static void testFibonacci() {
        // Given
        List<Integer> nums = new List<Integer> {-2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8};
        List<Integer> expected = new List<Integer> {-1, -1, -1, 1, 1, 2, 3, 5, 8, 13, 21};

        // Action
        List<Integer> results = new List<Integer>();
        for (Integer i = 0; i < nums.size(); ++i) {
            results.add(MyMethods.fibonacci(nums[i]));
        }

        // Result
        for (Integer i = 0; i < results.size(); ++i) {
            System.assertEquals(expected[i], results[i]);
        }
     }

     @isTest static void testReverseString() {
        // Given
        List<String> inputStrings = new List<String> {'Hello World', 'Oak', 'Vehicle', 'Dentist', 'Yellow Submarine'};
        List<String> expectedStrings = new List<String> {'dlroW olleH', 'kaO', 'elciheV', 'tsitneD', 'enirambuS wolleY'};

        // Action 
        List<String> results = new List<String>();
        for (Integer i = 0; i < inputStrings.size(); ++i) {
            results.add(MyMethods.reverseString(inputStrings[i]));
        }

        // Result
        for (Integer i = 0; i < results.size(); ++i) {
            System.assertEquals(expectedStrings[i], results[i]);
        }
     }

     @isTest static void testFactorial() {
        // Given
        List<Integer> inputNums = new List<Integer> {-2, -1, 0, 1, 2, 3, 4, 5};
        List<Integer> expectedNums = new List<Integer> {-1, -1, 1, 1, 2, 6, 24, 120};

        // Action
        List<Integer> actualNums = new List<Integer>();
        for (Integer i = 0; i < inputNums.size(); ++i) {
            actualNums.add(MyMethods.factorial(inputNums[i]));
        }

        // Result
        for (Integer i = 0; i < actualNums.size(); ++i) {
            System.assertEquals(expectedNums[i], actualNums[i]);
        }
     }

    @isTest static void testIsPalindrome() {
        // Given
        List<String> inputStrings = new List<String> {'hannah', 'Racecar', 'mountain', 'toot'};
        List<Boolean> expectedResults = new List<Boolean> {true, true, false, true}; 

        // Action
        List<Boolean> actualResults = new List<Boolean>();
        for (Integer i = 0; i < inputStrings.size(); ++i) {
            actualResults.add(MyMethods.isPalindrome(inputStrings[i]));
        }

        // Result
        for (Integer i = 0; i < actualResults.size(); ++i) {
            System.assertEquals(expectedResults[i], actualResults[i]);
        }
    }

    @TestSetup
    static void makeData() {

        /////////////////////////////////////////////
        // Data for getAccountsForAGiven()
        /////////////////////////////////////////////

        // Make an account with a related contact in same state
        Account mockAccount = new Account();
        mockAccount.Name = 'Band of America';
        mockAccount.BillingState = 'CA';
        insert mockAccount;

        Contact mockContact = new Contact();
        mockContact.LastName = 'Herb';
        mockContact.MailingState = 'CA';
        mockContact.AccountId = mockAccount.Id;
        insert mockContact;

        // Make an account with a related contact not in the same state
        mockAccount = new Account();
        mockAccount.Name = 'Wand of Spain';
        mockAccount.BillingState = 'CA';
        insert mockAccount;

        mockContact = new Contact();
        mockContact.LastName = 'Geraldine';
        mockContact.MailingState = 'NC';
        mockContact.AccountId = mockAccount.Id;
        insert mockContact;

        // Make an account with a contact whose state is null
        mockAccount = new Account();
        mockAccount.Name = 'Hand of Japan';
        mockAccount.BillingState = 'CA';
        insert mockAccount;

        mockContact = new Contact();
        mockContact.LastName = 'Rex';
        mockContact.MailingState = null;
        mockContact.AccountId = mockAccount.Id;
        insert mockContact;

        /////////////////////////////////////////////
        // Data for getClassGrades()
        /////////////////////////////////////////////

        // Department
        Department__c department = new Department__c();
        department.Name = 'Angry Dad';
        insert department;

        // Advisor
        Employee__c employee = new Employee__c();
        employee.Name = 'Peg Bundy';
        employee.Department__c = department.Id;
        insert employee;

        // Student
        Student__c student = new Student__c();
        student.Name = 'Al Bundy';
        student.Email__c = 'albundy@gmail.com';
        student.Advisor__c = employee.Id;
        student.Status__c = 'Enrolled';
        insert student;

        // Topic
        Topic__c topic = new Topic__c();
        topic.Name = 'Football';
        insert topic;

        // Class
        Class__c newClass = new Class__c();
        newClass.Name = 'BIO900';
        newClass.DaysPerWeek__c = 5;
        newClass.Department__c = department.Id;
        newClass.EndDate__c = Date.newInstance(2019, 12, 30);
        newClass.StartDate__c = Date.newInstance(2019, 09, 01);
        newClass.Topic__c = topic.Id;
        insert newClass;

        // ClassEnrollment
        ClassEnrollment__c classEnrollment = new ClassEnrollment__c();
        ClassEnrollment.Class__c = newClass.Id;
        classEnrollment.Student__c = student.Id;
        classEnrollment.Credits__c = 4.0;
        classEnrollment.Status__c = 'Enrolled';
        insert classEnrollment;

        // Assessment
        Assessment__c assessment = new Assessment__c();
        assessment.Name = 'HW';
        assessment.Class__c = newClass.Id;
        assessment.Date__c = Date.newInstance(2019, 10, 10);
        assessment.Time__c = Time.newInstance(1, 1, 1, 1);
        insert assessment;

        // Grade
        Grade__c grade = new Grade__c();
        grade.Assessment__c = assessment.Id;
        grade.Class_Enrollment__c = classEnrollment.Id;
        grade.Grade__c = 99.33;
        insert grade; 
    }

    @isTest static void testGetClassGrades() {
        // Given
        // Inserted data in @TestSetup

        // Action
        Map<Id, Map<Id, Double>> newMap = MyMethods.getClassGrades();

        // Result
        System.assertEquals(1, newMap.size());
    }
}
