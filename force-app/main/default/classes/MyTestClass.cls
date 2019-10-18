@isTest
//Test Class for the methods implemented in P1.cls
public with sharing class MyTestClass {

    @isTest
    public static void fibonacciTest()
    {
        //test data
        List<Integer> fibVals = new Integer[]{1,1,2,3,5,8,13,21,34};
        //checking data
        for(Integer x=0; x<fibVals.size(); x++)
        {
            System.assertEquals(P1.fibonacci(x+1), fibVals[x],'Fibonacci does not work');
        }
        
    }

    @isTest
    public static void reverseStringTest()
    {
        //test data
        List<String> tests = new String[]{'Jake','hf9d28hosaj', 'racecar', 'SADJFAS9ije32355'};
        //checking data
        for(String test:tests)
        {
            System.assertEquals(test.reverse(),P1.reverseString(test),'Reverse String did not work');
        }
    }

    @isTest
    public static void factorialTest()
    {
        //test data
        List<Integer> factVals = new Integer[]{1,1,2,6,24,120,720,5040};
        //checking data
        for(Integer i=0; i<factVals.size();i++)
        {
            System.assertEquals(factVals[i],P1.factorial(i),'Factorial did not work');
        }
    }

    @isTest 
    public static void isPalindromeTest()
    {
        String test = 'Racecar';
        System.assertEquals(P1.isPalindrome(test),true,'Palindrome not working');

        test = 'aslkncoiuwno3298u39821lmlkxloksjdo';
        test+=test.reverse();
        System.assertEquals(P1.isPalindrome(test),true,'Palindrome not working');

        test = 'RacecarCat';
        System.assertEquals(P1.isPalindrome(test),false,'Palindrome not working');
        
    }

    @isTest
    public static void getAccountsFromStateTest()
    {
        Test.startTest();

        //test data
        List<Account> testAccounts = new List<Account>{
            new Account(Name = 'CA Account',BillingState = 'CA', ShippingState = 'CA'),
            new Account(Name = 'CANY Account',BillingState = 'NY', ShippingState = 'CA'),
            new Account(Name = 'NY Account',BillingState = 'NY', ShippingState = 'NY'),
            new Account(Name = 'VA Account',BillingState = 'VA', ShippingState = 'VA')
        };
        Database.insert(testAccounts);
        List<Contact> testContacts= new List<Contact>{
            new Contact(FirstName = 'CAman', LastName = '1',MailingState='CA',AccountId=testAccounts[0].Id),
            new Contact(FirstName = 'VAman', LastName = '1',MailingState='VA',AccountId=testAccounts[1].Id),
            new Contact(FirstName = 'NYman', LastName = '2',MailingState = 'NY',AccountId=testAccounts[2].Id)
        };
        Database.insert(testContacts);
     
        //CA and NY have a contact in same state, VA does not have any contacts, CANY has VA contact so doesn't count
        List<Account> CAexp =  new List<Account>{testAccounts[0]};
        List<Account> NYexp = new List<Account>{testAccounts[2]};


        //run tests
        List<Account> CAresult;
        List<Account> NYresult;
        List<Account> VAresult;

        CAresult= P1.getAccountsForAGivenState(State.CA);
        NYresult= P1.getAccountsForAGivenState(State.NY);
        VAresult= P1.getAccountsForAGivenState(State.VA);


        //checking data
        System.assertEquals(VAresult.size(),0,'Should be no VA accounts matching');

        System.assertEquals(CAresult.size(),CAexp.size(),'CA accounts not matching');
        System.assertEquals(CAresult.get(0).Id,CAexp.get(0).Id,'CA accounts not matching');

        System.assertEquals(NYresult.size(),NYexp.size(),'CA accounts not matching');
        System.assertEquals(NYresult.get(0).Id,NYexp.get(0).Id,'NY accounts not matching');
        
        Test.stopTest();

        
    }

    @isTest
    public static void getClassGradesTest()
    {
        Test.startTest();
        //test data
        //1 department, employee, degree, room
        //3 students
        //2 classes
        //3 class enrollments 
        //3 assessments
        //4 grades 
        Department__c department = new Department__c(Name='The Department');
        Database.insert(department);

        Employee__c advisor = new Employee__c(Name='Advisor Employee', Department__c=department.Id);
        Database.insert( advisor);

        Degree__c theDegree = new Degree__c(Name = 'Degree', Department__c = department.Id);
        Database.insert( theDegree);

        Room__c theRoom = new Room__c();
        Database.insert( theRoom);
        
        Topic__c theTopic=new Topic__c(Name='theTopic',Degree__c=theDegree.Id);
        insert theTopic;

        List<Student__c> testStudents= new List<Student__c> {
            new Student__c(Name = 'Student1',Status__c = 'Enrolled',Advisor__c = advisor.id,Email__c = 'j1@jjj.com'),
            new Student__c(Name = 'Student2',Status__c='Enrolled', Advisor__c = advisor.id, Email__c = 'j2@jjj.com'),
            new Student__c(Name = 'Student3',Status__c='Enrolled', Advisor__c = advisor.id, Email__c = 'j3@jjj.com')
        };
        
        List<sObject> testClasses = new List<Class__c> {
            new Class__c(Name='Class #1',daysPerWeek__c = 1,
                StartDate__c = Date.newInstance(2050,1,1), EndDate__c = Date.newInstance(2050,1, 10), ScheduledTime__c = Time.newInstance(9,0,0,0),
                Room__c = theRoom.Id, Department__c = department.Id, Topic__c = theTopic.Id),
            new Class__c(Name='Class #2',daysPerWeek__c = 1,
                StartDate__c = Date.newInstance(2040,1,1), EndDate__c = Date.newInstance(2040,1, 10), ScheduledTime__c = Time.newInstance(10,0,0,0),
                Room__c = theRoom.Id, Department__c = department.Id, Topic__c = theTopic.Id)
        };
        Database.insert( testStudents);
        Database.insert( testClasses);
        //student 1: class 1&2; student2: class 1
        List<ClassEnrollment__c> testCEs = new List<ClassEnrollment__c> {
            new ClassEnrollment__c(Student__c=testStudents[0].Id,Class__c=testClasses[0].Id,Credits__c = 4, Status__c = 'Enrolled'),
            new ClassEnrollment__c(Student__c=testStudents[0].Id,Class__c=testClasses[1].Id,Credits__c = 4, Status__c = 'Enrolled'),
            new ClassEnrollment__c(Student__c=testStudents[1].Id,Class__c=testClasses[0].Id,Credits__c = 4, Status__c = 'Enrolled')
        };
        Database.insert(testCEs);

        List<Assessment__c> tests = new Assessment__c[] {
            new Assessment__c(Class__c=testClasses[0].Id, Date__c=Date.newInstance(2040,1, 10), Time__c=Time.newInstance(12,0,0,0)),
            new Assessment__c(Class__c=testClasses[0].Id, Date__c=Date.newInstance(2040,2, 10), Time__c=Time.newInstance(13,0,0,0)),
            new Assessment__c(Class__c=testClasses[1].Id, Date__c=Date.newInstance(2040,3, 10), Time__c=Time.newInstance(11,0,0,0))
        };
        Database.insert( tests);
        
        //student 1: grades 1-3, student 2: grade 4
        List<Grade__c> testGrades = new List<Grade__c>{
            new Grade__c(Assessment__c=tests[0].Id, Class_Enrollment__c=testCEs[0].Id, Grade__c=90),
            new Grade__c(Assessment__c=tests[1].Id, Class_Enrollment__c=testCEs[0].Id, Grade__c=91),
            new Grade__c(Assessment__c=tests[2].Id, Class_Enrollment__c=testCEs[1].Id, Grade__c=92),
            new Grade__c(Assessment__c=tests[0].Id, Class_Enrollment__c=testCEs[2].Id, Grade__c=80)
        };
        Database.insert( testGrades);

        //initializing the expected
        Map<Id, Map<Id, Double>> testdata= new Map<Id, Map<Id,Double>>();
        //student 1: grades 1,2,3
        Map<Id, Double> gs=new Map<Id, Double>();
        gs.put(testGrades[0].Id, testGrades[0].Grade__c);
        gs.put(testGrades[1].Id, testGrades[1].Grade__c);
        gs.put(testGrades[2].Id, testGrades[2].Grade__c);
        testdata.put(testStudents[0].Id, gs);

        //student 2: grade 4
        gs=new Map<Id, Double>();
        gs.put(testGrades[3].Id, testGrades[3].Grade__c);
        testdata.put(testStudents[1].Id,gs);

        //student 3: no grades
        testdata.put(testStudents[2].Id,new Map<Id, Double>());


        //testing the method
        Map<Id, Map<Id, Double>> testResult = new  Map<Id, Map<Id, Double>>();
        testResult= P1.getClassGrades();

        //checking result against expected
        try{
            for(Id s: testData.keySet())
            {
                for(Id g: testData.get(s).keySet())
                {
                    System.assertEquals(testResult.get(s).get(g),testdata.get(s).get(g),'Grades returned do not match');
                }
            }
        }catch(Exception e)
        {
            System.assert(false,'Returned grades not correct');
        }
        
        Test.stopTest();
    }


}
