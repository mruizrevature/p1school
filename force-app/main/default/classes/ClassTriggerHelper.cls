public with sharing class ClassTriggerHelper {

    // public static void preventDoubleRoomBooking(Class__c classBeingInserted) {
    //     checkIfAssessmentIsUsingRoom(classBeingInserted);
    //     checkIfClassIsUsingRoom(classBeingInserted);
    // }

    // static void checkIfAssessmentIsUsingRoom(Class__c classBeingInserted) {
    //     List<Assessment__c> existingAssessments;

    //     if (Schema.sObjectType.Assessment__c.isAccessible()) {
    //         existingAssessments = [SELECT Id FROM Assessment__c WHERE (Date__c >=: classBeingInserted.StartDate__c) AND (Date__c <=: classBeingInserted.EndDate__c) AND (Time__c =: classBeingInserted.ScheduledTime__c)];
    //     }

    //     RoomUtilityClass.checkIfRoomIsBeingUsed(existingAssessments,classBeingInserted);
    // }

    // static void checkIfClassIsUsingRoom(Class__C classBeingInserted) {
    //     List<Class__c> existingClasses;

    //     if (Schema.sObjectType.Class__c.isAccessible()) {
    //         existingClasses = [SELECT Id FROM Class__c WHERE (StartDate__c <=: classBeingInserted.StartDate__c) AND (EndDate__c >=: classBeingInserted.StartDate__c) AND (ScheduledTime__c =: classBeingInserted.ScheduledTime__c)];
    //     }
    //     RoomUtilityClass.checkIfRoomIsBeingUsed(existingClasses,classBeingInserted);
    // }

    // SchoolDataCreator.createData();
}