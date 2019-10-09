public with sharing class AssessmentTrigger {
    public static void preventDoubleBooking(Assessment__c assessmentBeingInserted){
        checkIfAssessmentIsUsingRoom(assessmentBeingInserted);
        checkIfClassIsUsingRoom(assessmentBeingInserted);
    }
    static void checkIfAssessmentIsUsingRoom(Assessement__c assessmentBeingInserted){

    }
    static void checkIfClassIsUsingRoom(Assessement__c assessmentBeingInserted){
    }

 }
