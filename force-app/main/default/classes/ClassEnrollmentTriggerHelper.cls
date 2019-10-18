public with sharing class ClassEnrollmentTriggerHelper {

    public static void stopDoubleEnroll (List<ClassEnrollment__c> enrollmentInserted){
        try{
            checkDoubleEnroll(enrollmentInserted);
        }catch (DuplicateEnrollmentException dp){
           System.debug(UserPermissionErrors.CANNOT_ENROLL_AGAIN);
        }
    }
    //get class id from every class in the list of class enrollment
    private static Id getClassID(List<ClassEnrollment__c> enrollment) {
        Id classID;
        for (ClassEnrollment__c classes : enrollment) {
            classID = classes.Class__c;
        }
            return classID;
    }

    //Get student id from the list of Classenrollment
    private static Id getStudentID(List<ClassEnrollment__c> enrollment) {
        Id studentID;
        for (ClassEnrollment__c classes : enrollment) {
            studentID = classes.Student__c;
        }
            return studentID;
    }
    //checks doubleenroll by matching ID of CE and see if it already exist
    public static List<ClassEnrollment__c> checkDoubleEnroll (List<ClassEnrollment__c> enrollmentInserted){

        List<ClassEnrollment__c> checkIdStudentEnroll;

        //if(Schema.sObjectType.ClassEnrollment__c.isAccessible()){
            checkIdStudentEnroll = [SELECT id, Student__c, Class__c
                FROM ClassEnrollment__c
                WHERE Class__c =: getClassID(enrollmentInserted) AND Student__c =: getStudentID(enrollmentInserted)
                ];
                System.debug(checkIdStudentEnroll);
        //}

        if (checkIdStudentEnroll.size() >= 1){
            System.debug('hi');
            enrollmentInserted[0].addError(UserPermissionErrors.CANNOT_ENROLL_AGAIN);
            //throw new DuplicateEnrollmentException(UserPermissionErrors.CANNOT_ENROLL_AGAIN);
        } 

        return checkIdStudentEnroll;
    }
}

