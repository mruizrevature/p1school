public with sharing class DegreeTriggerHelper {
    public static void preventUnrelatedClassSubject(List<ClassEnrollment__c> enrollmentBeingInserted) {
        checkIfClassSubjectMatchesStudentMajor(enrollmentBeingInserted);
    }

    public static void preventUnrelatedClassSubject(ClassEnrollment__c enrollmentBeingInserted) {
        checkIfClassSubjectMatchesStudentMajor(enrollmentBeingInserted);
    }



}
