public with sharing class DuplicateEnrollmentTriggerHelper {
   
    public final static String DUPLICATE_ENROLLMENT = 'Student cannot be enrolled in the same class twice.';

    public static void preventDoubleEnrollment(List<ClassEnrollment__c> enrollmentsBeingInserted) {
        checkForDoubleEnrollment(enrollmentsBeingInserted);
    }

    public static void checkForDoubleEnrollment(List<ClassEnrollment__c> enrollmentsBeingInserted) {
        try {

            // Get the list of classes and list of students in Trigger.New 
            // (enrollmentsBeingInserted) and use those Ids to get a list of 
            // existing records with those same Ids. 
            // If any records exist already, then there is a duplicate enrollment
            List<Id> listOfClasses = new List<Id>();
            List<Id> listOfStudents = new List<Id>();

            for (ClassEnrollment__c classEnrollment : enrollmentsBeingInserted) {
                listOfClasses.add(classEnrollment.Class__c);
                listOfStudents.add(classEnrollment.Student__c);
            }

            List<ClassEnrollment__c> existingRecords = [
                SELECT 
                    Class__c 
                    ,Student__c 
                FROM ClassEnrollment__c 
                WHERE Class__c IN: listOfClasses
                    AND Student__c IN: listOfStudents
            ];

            if (existingRecords.size() > 0) {
                enrollmentsBeingInserted[0].addError(DUPLICATE_ENROLLMENT);
                //throw new DuplicateEnrollmentException(DUPLICATE_ENROLLMENT);
            }
        } catch (DuplicateEnrollmentException dee) {
            System.debug(dee.getMessage());
        }
    }
}
