public with sharing class RoomUtilityClass {
    public static void checkIfRoomIsBeingUsed(List<sObject> classesOrAssessmentsAlreadyExisting, sObject assessmentOrClassBeingInserted) {
        if (classesOrAssessmentsAlreadyExisting != null) { // User has at least read access
            if (classesOrAssessmentsAlreadyExisting.size() > 0) { // Double booking
                assessmentOrClassBeingInserted.addError('This room will be occupied during that time. Please choose another.');
            }
        } else { // User cannot read Class  
            if (assessmentOrClassBeingInserted instanceOf Assessment__c) { 
                assessmentOrClassBeingInserted.addError('You do not have access to see Assessment records. Please contact System Administrator for more details.');
            } else if (assessmentOrClassBeingInserted instanceOf Class__c) {
                assessmentOrClassBeingInserted.addError('You do not have access to see Class records. Please contact System Administrator for more details.');
            }
        }
    }

    /**
        Given a list of Assessments or Classes, return an error to view stating that the room has been double booked.
    */
    public static void denyRecordsTryingToDoubleBookRoom(List<sObject> classesOrAssessmentsToBeDenied) {
        for (sObject obj: classesOrAssessmentsToBeDenied) {
            obj.addError('This room will be occupied during that time. Please choose another.');
        }
    }
}