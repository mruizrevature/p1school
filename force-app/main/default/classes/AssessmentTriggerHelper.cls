public with sharing class AssessmentTriggerHelper {
    /**
        Given a List<Assessment>, check if there is a Class or Assessment using that room at the specified time.
     */
    public static void preventDoubleRoomBooking(List<Assessment__c> assessmentsBeingInserted) {
        checkIfAssessmentIsUsingRoom(assessmentsBeingInserted);
        // checkIfClassIsUsingRoom(assessmentsBeingInserted);
    }

    static void checkIfAssessmentIsUsingRoom(List<Assessment__c> assessmentsBeingInserted) {
        List<Assessment__c> existingAssessments;
        List<Date> listOfDates = new List<Date>();
        List<Time> listOfTimes = new List<Time>();
        List<Id> listOfRooms = new List<Id>();
        List<Assessment__c> assessmentsToBeDenied = new List<Assessment__c>();

        // Store the dates and time, which will be used for the SOQL query and room which be used to match results.
        for (Assessment__c a: assessmentsBeingInserted) {
            listOfDates.add(a.Date__c);
            listOfRooms.add(a.Room__c);
            listOfTimes.add(a.Time__c);
        }

        // Make sure the sure has read access for exising Assessment records.
        if (Schema.sObjectType.Assessment__c.isAccessible()) {
            existingAssessments = [SELECT Id, Date__c, Time__c, Room__c FROM Assessment__c WHERE (Date__c IN: listOfDates) AND (Room__c IN: listOfRooms) AND (Time__c IN: listOfTimes)];
        }

        for (Assessment__c newAssessment: assessmentsBeingInserted) {   
            for (Assessment__c existingAssessment: existingAssessments) {
                if (newAssessment.Room__c == existingAssessment.Room__c) { // same room
                    if (newAssessment.Date__c == existingAssessment.Date__c) { // same date
                        if (newAssessment.Time__c == existingAssessment.Time__c) { // same time
                            assessmentsToBeDenied.add(newAssessment); // double booking
                            break;
                        }
                    }
                }
            }       
        }

        RoomUtilityClass.denyRecordsTryingToDoubleBookRoom(assessmentsToBeDenied);
    } 

    // static void checkIfClassIsUsingRoom(Assessment__c assessmentBeingInserted) {
    //     List<Class__c> existingClasses;

    //     if (Schema.sObjectType.Class__c.isAccessible()) {
    //         existingClasses = [SELECT Id FROM Class__c WHERE (StartDate__c <: assessmentBeingInserted.Date__c) AND (EndDate__c >: assessmentBeingInserted.Date__c) AND (ScheduledTime__c =: assessmentBeingInserted.Time__c)];
    //     }
    //     RoomUtilityClass.checkIfRoomIsBeingUsed(existingClasses,assessmentBeingInserted);
    // }

}