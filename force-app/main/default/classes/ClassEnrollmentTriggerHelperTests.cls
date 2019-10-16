@isTest
public with sharing class ClassEnrollmentTriggerHelperTests {
    @TestSetup
    static void makeData() {
        SchoolDataCreator.createData();
    }

    @isTest static void testAddAttendanceLines() {
        Integer numAttendance = 2;
        List<AttendanceLineItem__c> a0 = [SELECT Id FROM AttendanceLineItem__c];

        // Class Enrollment creator
        ClassEnrollment__c ce = new ClassEnrollment__c(
            Class__c = [SELECT Id FROM Class__c WHERE DaysPerWeek__c = :numAttendance][0].Id, 
            Student__c = [SELECT Id FROM Student__c][0].Id, 
            Credits__c = 1, 
            Status__c = 'Enrolled'
        );
        try { insert ce; } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }

        List<AttendanceLineItem__c> a1 = [SELECT Id FROM AttendanceLineItem__c];

        System.assertEquals(numAttendance, a1.size() - a0.size(), 'attendance items');
    }

    @isTest static void testRemoveAttendanceLines() {
        List<AttendanceLineItem__c> a0 = [SELECT Id FROM AttendanceLineItem__c];
        ClassEnrollment__c ce = [SELECT Id FROM ClassEnrollment__c][0];
        
        List<AttendanceLineItem__c> a3 = [SELECT Id FROM AttendanceLineItem__c WHERE ClassEnrollment__c =: ce.Id];
        System.assertEquals(2, a3.size());

        try { delete ce; } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }

        List<AttendanceLineItem__c> a1 = [SELECT Id FROM AttendanceLineItem__c];
        System.assertEquals(2, a0.size() - a1.size(), 'attendance items');
    }
}
