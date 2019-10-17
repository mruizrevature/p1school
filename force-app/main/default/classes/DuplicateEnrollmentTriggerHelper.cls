public with sharing class DuplicateEnrollmentTriggerHelper {
   
    public final static String DUPLICATE_ENROLLMENT = 'Student cannot be enrolled in the same class twice.';

    public static void preventDoubleEnrollment(ClassEnrollment__c enrollmentsBeingInserted) {
        checkForDoubleEnrollment(enrollmentsBeingInserted);
    }

    public static void checkForDoubleEnrollment(ClassEnrollment__c enrollmentsBeingInserted) {
        try {
            List<ClassEnrollment__c> existingRecords = [
                SELECT 
                    Class__c 
                    ,Student__c 
                FROM ClassEnrollment__c 
                WHERE Class__c =: enrollmentsBeingInserted.Class__c
                    AND Student__c =: enrollmentsBeingInserted.Student__c
            ];

            if (existingRecords.size() > 0) {
                enrollmentsBeingInserted.addError(DUPLICATE_ENROLLMENT);
                //throw new DuplicateEnrollmentException(DUPLICATE_ENROLLMENT);
            }
        } catch (DuplicateEnrollmentException dee) {
            System.debug(dee.getMessage());
        }
    }
}
