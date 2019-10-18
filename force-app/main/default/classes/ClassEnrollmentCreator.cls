@isTest
public with sharing class ClassEnrollmentCreator {
    
    public static void createClassEnrollment(){
        ClassEnrollment__c newEnrollment = new ClassEnrollment__c();
        Class__c existingClass = [SELECT Id FROM Class__c LIMIT 1];
        Student__c existingStudent = [SELECT Id FROM Student__c LIMIT 1];
        newEnrollment.Class__c = existingClass.Id;
        newEnrollment.Student__c = existingStudent.Id;
        newEnrollment.Credits__c = 3.0;
        insert newEnrollment;
    }
}
