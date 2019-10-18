
  @isTest

public with sharing class ClassEnrollmentCreator {
    public static void createClassEnrollment() {
        ClassEnrollment__c newClassEnrollment = new ClassEnrollment__c();

        Class__c existingClass = [SELECT Id FROM Class__c WHERE ((DaysPerWeek__c=2) AND (DurationInWeeks__c=12)) LIMIT 1];
        newClassEnrollment.Class__c = existingClass.Id;
        Student__c existingStudent = [SELECT Id FROM Student__c LIMIT 1];
        newClassEnrollment.Student__c = existingStudent.Id;
        
        newClassEnrollment.Credits__c = 4;
        newClassEnrollment.Status__c = 'Pending';


        insert newClassEnrollment;
    }
}

