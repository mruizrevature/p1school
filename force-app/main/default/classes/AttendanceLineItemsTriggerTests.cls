@isTest
public with sharing class AttendanceLineItemsTriggerTests 
{
    @TestSetup
    static void makeData()
    {
        SchoolDataCreator.createData();    
    }


    // if a student is successfully enrolled attendance line items should be created for that class enrollment
    @isTest
    public static void testAddAttendanceLineItemsOnEnrolledStudent()
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

        // make sure line items are added when the enrolled student is inserted
        insert ce;
        Decimal numberOfAttendanceLineItems = [Select Id FROM AttendanceLineItem__c].size();
        System.assertEquals(expectedNumberOfAttendanceLineItems, numberOfAttendanceLineItems);
        // make sure line items are deleted when the enrollment is deleted
        delete ce;
        numberOfAttendanceLineItems = [Select Id FROM AttendanceLineItem__c].size();
        System.assertEquals(0, numberOfAttendanceLineItems);
        Test.stopTest();
    }


    @isTest
    public static void testAddAttendanceLineItemsOnDeniedStudent()
    {
        Class__c c = [SELECT Name, Id, DaysPerWeek__c, DurationInWeeks__c FROM Class__c WHERE Name = 'EDU200'];
        Student__c s = [SELECT Name, Id FROM Student__c WHERE Name = 'Peter Jetson'];
    
        Test.startTest();
        ClassEnrollment__c ce = new ClassEnrollment__c();
        ce.Student__c = s.Id;
        ce.Class__c = c.Id;
        ce.Credits__c = 6;
        ce.Status__c = 'Denied';

        // make sure denied students dont generate attendance line items
        insert ce;
        Decimal numberOfAttendanceLineItems = [Select Id FROM AttendanceLineItem__c].size();
        System.assertEquals(0, numberOfAttendanceLineItems);
        Test.stopTest();
    }
}
