public with sharing class EnrollmentTriggerHelper {
    public static void preventDoubleEnrollment(ClassEnrollment__c EnrollmentsBeingInserted) {
        checkIfEnrollmentIsAlreadyCreated(EnrollmentsBeingInserted);
    }
    // public static void preventDoubleEnrollment(List<ClassEnrollment__c> EnrollmentsBeingInserted) {
    //     checkIfEnrollmentIsAlreadyCreated(EnrollmentsBeingInserted);
    // }
    static void checkIfEnrollmentIsAlreadyCreated(ClassEnrollment__c newEnrollment) {
       List<ClassEnrollment__c> existingEnrollments;

       // Make sure the user has read access for exising Class Enrollment records.
       if (Schema.sObjectType.ClassEnrollment__c.isAccessible()) {
           existingEnrollments = [SELECT Id, Class__c, Student__c FROM ClassEnrollment__c WHERE Class__c =: newEnrollment.Class__c AND Student__c =: newEnrollment.Student__c];
       }
       if (existingEnrollments != null) { // User has at least read access
           if (existingEnrollments.size() > 1) { // Double Enrollments
            DuplicateEnrollment.denyRecordTryingToDoubleEnrollAClass(newEnrollment);
            //add error
            newEnrollment.addError(UserPermissionErrors.CANNOT_DUPLICATE_ENROLLMENTS);
            throw new DuplicateEnrollmentException('This student has already been enrolled in this class');
            
           }
       } else { // User cannot read Class Enrollment  
           newEnrollment.addError(UserPermissionErrors.CANNOT_READ_ENROLLMENTS);
       }
        
    }
}
