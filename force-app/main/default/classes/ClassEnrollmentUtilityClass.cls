public with sharing class ClassEnrollmentUtilityClass {
    public static void denyRecordsCreatingDuplicateEnrollment(List<sObject> classEnrollmentsToBeDenied) {
        for (sObject obj: classEnrollmentsToBeDenied) {
            denyRecordCreatingDuplicateInserion(obj);
        }
    }

    public static void denyRecordCreatingDuplicateInserion(sObject classEnrollmentsToBeDenied) {
        classEnrollmentsToBeDenied.addError('already enrolled');
    }
}
