@isTest
public with sharing class ClassEnrollmentTriggerHelperTests {
    @TestSetup
    static void makeData() {
        SchoolDataCreator.createData();
    }

    @isTest static void testAddAttendanceLines() {

        List<AttendanceLineItem__c> a0 = [SELECT Id FROM AttendanceLineItem__c];
        // System.debug('attendance before: ' + a0);

        // Class Enrollment creator
        ClassEnrollment__c ce = new ClassEnrollment__c(
            Class__c = [SELECT Id FROM Class__c][0].Id, 
            Student__c = [SELECT Id FROM Student__c][0].Id, 
            Credits__c = 1, 
            Status__c = 'Enrolled'
        ); insert ce;
        
        List<AttendanceLineItem__c> a1 = [SELECT Id FROM AttendanceLineItem__c];
        // System.debug('attendance after: ' + a1);

        System.assertEquals(2, a1.size() - a0.size(), 'attendance items');
    }
}
