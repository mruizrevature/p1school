public with sharing class ClassEnrollmentTriggerHelper {

    public static void stopDoubleEnroll (List<ClassEnrollment__c> enrollmentInserted){
        checkDoubleEnroll(enrollmentInserted);
    }
    //get class id from every class in the list of class enrollment
    private static String getClassID(List<ClassEnrollment__c> enrollment) {
        String classID;
        for (ClassEnrollment__c classes : enrollment) {
            classID = classes.Class__r.Id;
        }
            return classID;
    }

    //Get student id from the list of Classenrollment
    private static String getStudentID(List<ClassEnrollment__c> enrollment) {
        String studentID;
        for (ClassEnrollment__c classes : enrollment) {
            studentID = classes.Student__r.Id;
        }
            return studentID;
    }
    //checks doubleenroll by matching ID of CE and see if it already exist
    public static List<ClassEnrollment__c> checkDoubleEnroll (List<ClassEnrollment__c> enrollmentInserted){

        List<ClassEnrollment__c> checkIdStudentEnroll;

        if(Schema.sObjectType.ClassEnrollment__c.isAccessible()){
            checkIdStudentEnroll = [SELECT id, Student__c, Class__c
                FROM ClassEnrollment__c
                WHERE Class__r.Id =: getClassID(enrollmentInserted) AND Student__r.Id =: getStudentID(enrollmentInserted)
                ];
        }

        if (checkIdStudentEnroll.size() >= 1){
            throw new DuplicateEnrollmentException(UserPermissionErrors.CANNOT_ENROLL_AGAIN);
        } 

        return checkIdStudentEnroll;
    }
}

