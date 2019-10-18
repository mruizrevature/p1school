@isTest
public with sharing class P1Tests {
    @isTest static void testFibonacciThree(){
        Integer actual = P1.fibonacci(3);
        System.assertEquals(2, actual);
    }

    @isTest static void testFibonacciZero(){
        Integer actual = P1.fibonacci(0);
        System.assertEquals(0, actual);
    }

    @isTest static void testFibonacciOne(){
        Integer actual = P1.fibonacci(1);
        System.assertEquals(1, actual);
    }

    @isTest static void testFibonacciNegative(){
        Integer actual = P1.fibonacci(-2);
        System.assertEquals(-1, actual);
    }

    @isTest static void testFibonacciNotSeven(){
        Integer actual = P1.fibonacci(7);
        System.assertNotEquals(10, actual);
    }

    @isTest static void testFactorialFive(){
        Integer actual = P1.factorial(5);
        System.assertEquals(120, actual);
    }

    @isTest static void testFactorialZero(){
        Integer actual = P1.factorial(0);
        System.assertEquals(1, actual);
    }

    @isTest static void testFactorialOne(){
        Integer actual = P1.factorial(1);
        System.assertEquals(1, actual);
    }

    @isTest static void testFactorialNegativeTwo(){
        Integer actual = P1.factorial(-2);
        System.assertEquals(-1, actual);
    }

    @isTest static void testReverseString(){
        String exact = P1.reverseString('powerful');
        System.assertEquals('lufrewop', exact);
    }
    @isTest static void testReverseStringFalse(){
        String exact = P1.reverseString('pneumonia');
        System.assertNotEquals('hkfshda', exact);
    }

    @isTest static void testIsPalindromeTrue(){
        Boolean exact = P1.isPalindrome('racecar');
        System.assert(exact == true);
    }
     @isTest static void testIsPalindromeFalse(){
        Boolean exact = P1.isPalindrome('hellomom');
        System.assert(exact == false);
    }

    @isTest static void testAccountByState(){
        Account acct = new Account();
        acct.Name = 'mockAccount';
        acct.BillingState = 'CA';
        insert acct;
        Contact cont = new Contact(LastName = 'Dorsey', MailingState = 'CA');
        cont.AccountId = acct.Id;
        insert cont;
        Contact cont2 = new Contact(LastName = 'Attkinsen', MailingState = 'DE');
        cont2.AccountId = acct.Id;
        insert cont2;
        
        System.assertEquals(1, P1.getAccountsForAGivenState(State.CA).size());
    }

    @isTest static void testGetClassGrade(){
        SchoolDataCreator.CreateData();
        //get classes and students
        Student__c mockStudent = [SELECT Id FROM Student__c LIMIT 1];
        Class__c mockClass = [SELECT Id FROM Class__c LIMIT 1];
        ClassEnrollment__c mockEnrollment = new ClassEnrollment__c();
        mockEnrollment.Student__c = mockStudent.Id;
        mockEnrollment.Class__c=mockClass.Id;
        mockEnrollment.Credits__c = 4;
        mockEnrollment.Status__c = 'Enrolled';
        insert mockEnrollment;
        for(integer i =0; i < 3; i++){
            Grade__c gr = new Grade__c(Assessment__c = [SELECT Id FROM Assessment__c][i].Id,
                                        Class_Enrollment__c = [SELECT Id FROM ClassEnrollment__c][0].Id,
                                        Grade__c = 25 * (1 + i) 
            );
            insert gr;
        }
        Map<Id,Map<Id,Double>> studentGrades = P1.getClassGrades();
        List<Map<Id, Double>> classGrades = studentGrades.values();
        for(Map<Id, Double> gr : classGrades){
            for(Double grade : gr.values()){
                System.assertNotEquals(65,grade);
            }
        }
        
    }    

}
