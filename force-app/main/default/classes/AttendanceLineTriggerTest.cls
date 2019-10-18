@isTest
public with sharing class AttendanceLineTriggerTest {
    @TestSetup
    static void makeData()
    {
        SchoolDataCreator.createData();

    }  
     @isTest static void testAttendanceLineInsert() {
        List<AttendanceLineItem__c> beforeCE = [SELECT Id FROM AttendanceLineItem__c];
		ClassEnrollmentCreator.createClassEnrollment();
        List<AttendanceLineItem__c> afterCE = [SELECT Id FROM AttendanceLineItem__c];
        System.assertEquals(24, afterCE.size() - beforeCE.size());
     }

    @isTest static void testAttendanceLineDelete() {
        ClassEnrollmentCreator.createClassEnrollment();
		ClassEnrollment__c ce = [SELECT Id FROM ClassEnrollment__c LIMIT 1];
        delete ce; 
        List<AttendanceLineItem__c> a1 = [SELECT Id FROM AttendanceLineItem__c WHERE AttendanceLineItem__c.ClassEnrollment__r.Id=:ce.Id];
        System.assert(a1.isempty());
     }
}