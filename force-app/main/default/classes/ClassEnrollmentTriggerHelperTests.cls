@isTest
public with sharing class ClassEnrollmentTriggerHelperTests {
    @TestSetup
    static void makeData() {
        SchoolDataCreator.createData();
        // Class Enrollment creator
        ClassEnrollment__c ce = new ClassEnrollment__c(
            Class__c = [SELECT Id FROM Class__c][0].Id, 
            Student__c = [SELECT Id FROM Student__c][0].Id, 
            Credits__c = 1, 
            Status__c = 'Enrolled'
            ); insert ce;
    }
    
}
