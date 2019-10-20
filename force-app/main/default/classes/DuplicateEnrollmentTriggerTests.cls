@isTest
public with sharing class DuplicateEnrollmentTriggerTests {
    
    @TestSetup
    static void makeData() {
        SchoolDataCreator.createData();
    }

    @isTest static void testDuplicateEnrollment() {
        // Get one Class and one Student to make a duplicate enrollment with
        ClassEnrollment__c classEnrollment = [SELECT Student__c, Class__c FROM ClassEnrollment__c LIMIT 1];
        Object duplicateStudent = classEnrollment.get('Student__c');
        Object duplicateClass = classEnrollment.get('Class__c');
        Integer credit = 4;
        String status = 'Enrolled';

        // Put duplicate Student/Class pair in ClassEnrollment
        ClassEnrollment__c mockClassEnrollment = new ClassEnrollment__c(
            Class__c = (Id)duplicateClass
            ,Student__c = (Id)duplicateStudent
            ,Credits__c = credit
            ,Status__c = status
        );

        Database.SaveResult insertResult = Database.insert(mockClassEnrollment, false);
        System.assert(!insertResult.isSuccess());
        System.assertEquals(DuplicateEnrollmentTriggerHelper.DUPLICATE_ENROLLMENT, 
            insertResult.getErrors()[0].getMessage());
        System.assert(insertResult.getErrors().size() > 0);
    }
}
