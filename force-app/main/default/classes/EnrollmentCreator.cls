@isTest
public with sharing class EnrollmentCreator {
    public static void createClassEnrollment(){
        SchoolDataCreator.createData();
        Student__c mockExistingStudent = [SELECT Id FROM Student__c LIMIT 1];
        Class__c mockExistingClass = [SELECT Id FROM Class__c LIMIT 1];
        ClassEnrollment__c mockExistingClassEnrollment = new ClassEnrollment__c();
        mockExistingClassEnrollment.Class__c = mockExistingClass.Id;
        mockExistingClassEnrollment.Student__c = mockExistingStudent.Id;
        mockExistingClassEnrollment.Credits__c = 4;
        mockExistingClassEnrollment.Status__c = 'Enrolled';
        System.debug('MockExistingClassEnrollment: ' + mockExistingClassEnrollment);
        insert mockExistingClassEnrollment;
        
    }
}
