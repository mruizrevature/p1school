public with sharing class DuplicateEnrollment {
    public static final String ENROLLMENT_ALREADY_CREATED = 'This class enrollment for said student has already been created. Please choose another.';

     /**
        Given a list of Class Enrollments, return an error to view stating that the class enrollment has been created before.
    */
    public static void denyRecordsTryingToDoubleEnrollAClass(List<sObject> classEnrollmentsToBeDenied) {
        for (sObject obj: classEnrollmentsToBeDenied) {
            denyRecordTryingToDoubleEnrollAClass(obj);
        }
    }

    public static void denyRecordTryingToDoubleEnrollAClass(sObject classEnrollmentsToBeDenied) {
        classEnrollmentsToBeDenied.addError(ENROLLMENT_ALREADY_CREATED);
    }
}
