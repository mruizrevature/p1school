public with sharing class ClassTriggerHelper {
    // /**
    //     Given an Assessment, check if there is a Class or Assessment using that room at the specified time.
    //  */
    // public static void preventDoubleRoomBooking(Class__c assessmentBeingInserted) {
    //     // Get existing assessment
    //     List<Assessment__c> existingAssessments;
         
    //     if (Schema.sObjectType.Assessment__c.isAccessible()) {
    //         existingAssessments = [SELECT Id FROM Assessment__c WHERE Date__c =: assessmentBeingInserted.Date__c AND Time__c =: assessmentBeingInserted.Time__c];
    //     }

    //     if (existingAssessments != null && existingAssessments.size() > 0) {
    //         assessmentBeingInserted.addError('This room will be occupied during that time. Please choose another.');
    //     }

    //     checkIfClassIsScheduledDuringAssessment(assessmentBeingInserted);

    // }


    // static void checkIfClassIsScheduledDuringAssessment(Assessment__c assessmentBeingInserted) {
    //     List<Class__c> existingClasses;

    //     if (Schema.sObjectType.Class__c.isAccessible()) {
    //         existingClasses = [SELECT Id FROM Class__c WHERE (StartDate__c <: assessmentBeingInserted.Date__c) AND (EndDate__c >: assessmentBeingInserted.Date__c) AND (ScheduledTime__c =: assessmentBeingInserted.Time__c)];
    //     }
    //     if (existingClasses != null && existingClasses.size() > 0) {
    //         assessmentBeingInserted.addError('This room will be occupied during that time. Please choose another.');
    //     }
    // } 
}