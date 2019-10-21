public with sharing class DuplicateClassEnrollmentTriggerHelper {
    public static void preventDuplicateClassEnrollment(ClassEnrollment__c classEnrollmentBeingInserted) {
        List<ClassEnrollment__c> existingClassEnrollments = [SELECT Id, Class__c, Student__c FROM ClassEnrollment__c];
        List<ClassEnrollment__c> denyClassEnrollment = new List<ClassEnrollment__c>();

        for (ClassEnrollment__c classEnrollment : existingClassEnrollments) {
            if (classEnrollment.Student__c == classEnrollmentBeingInserted.Student__c && classEnrollment.Class__c == classEnrollmentBeingInserted.Class__c) {
                denyClassEnrollment.add(classEnrollmentBeingInserted);
                break;
            }
        }

        denyDuplicateClassEnrollment(denyClassEnrollment);
    }

    public static void denyDuplicateClassEnrollment (List<ClassEnrollment__c> denyClassEnrollment) {
        for (ClassEnrollment__c classEnrollment : denyClassEnrollment) {
            classEnrollment.addError(UserPermissionErrors.ALREADY_ENROLLED_IN_THIS_CLASS);
            throw new DuplicateEnrollmentException();
        }
    }
}