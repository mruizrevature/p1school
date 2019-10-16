public with sharing class DuplicateEnrollmentTriggerHelper {
   
    public static void preventDoubleEnrollment(List<ClassEnrollment__c> enrollmentsBeingInserted) {
        checkForDoubleEnrollment(enrollmentsBeingInserted);
    }

    public static void checkForDoubleEnrollment(List<ClassEnrollment__c> enrollmentsBeingInserted) {
        try {
            for (ClassEnrollment__c classEnrollment : enrollmentsBeingInserted) {        
                // Grab the student and class from the current class enrollment
                Object currentStudent = classEnrollment.get('Student__c');
                Object currentClass = classEnrollment.get('Class__c');

                // Check for duplicate enrollments. 
                // If one exists, throw an exception and don't insert the record
                for (ClassEnrollment__c ce : enrollmentsBeingInserted) {

                    if ((Id)currentStudent == (Id)ce.get('Student__c') &&
                        (Id)currentClass == (Id)ce.get('Class__c')) {

                        ce.addError(DuplicateEnrollmentTriggerTests.DUPLICATE_ENROLLMENT);
                        //throw new DuplicateEnrollmentException(DuplicateEnrollmentTriggerTests.DUPLICATE_ENROLLMENT);
                    }
                }
            }
        } catch (Exception e) {
            //System.debug(dee.getMessage());
            System.debug(e.getMessage());
        }
    }
}
