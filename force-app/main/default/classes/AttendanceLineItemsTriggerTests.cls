@isTest
public with sharing class AttendanceLineItemsTriggerTests 
{
    @TestSetup
    static void makeData()
    {
        SchoolDataCreator.createData();    
    }


    @isTest
    public static void testEnrolledStudent()
    {
        Class__c c = [SELECT Name, Id, DaysPerWeek__c, DurationInWeeks__c FROM Class__c WHERE Name = 'BIO100'];
        Student__c s = [SELECT Name, Id FROM Student__c WHERE Name = 'Peter Jetson'];
        Decimal expectedNumberOfAttendanceLineItems = c.DaysPerWeek__c * c.DurationInWeeks__c;
    
        Test.startTest();
        ClassEnrollment__c ce = new ClassEnrollment__c();
        ce.Student__c = s.Id;
        ce.Class__c = c.Id;
        ce.Credits__c = 6;
        ce.Status__c = 'Enrolled';
        insert ce;
        Decimal numberOfAttendanceLineItems = [Select Id FROM AttendanceLineItem__c].size();
        System.assertEquals(expectedNumberOfAttendanceLineItems, numberOfAttendanceLineItems);
        Test.stopTest();
    }


    @isTest
    public static void testDeniedStudent()
    {
        Class__c c = [SELECT Name, Id, DaysPerWeek__c, DurationInWeeks__c FROM Class__c WHERE Name = 'EDU200'];
        Student__c s = [SELECT Name, Id FROM Student__c WHERE Name = 'Peter Jetson'];
    
        Test.startTest();
        ClassEnrollment__c ce = new ClassEnrollment__c();
        ce.Student__c = s.Id;
        ce.Class__c = c.Id;
        ce.Credits__c = 6;
        ce.Status__c = 'Denied';
        insert ce;
        Decimal numberOfAttendanceLineItems = [Select Id FROM AttendanceLineItem__c].size();
        System.assertEquals(0, numberOfAttendanceLineItems);
        Test.stopTest();
    }
}
