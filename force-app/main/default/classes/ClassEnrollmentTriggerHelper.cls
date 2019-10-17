public with sharing class ClassEnrollmentTriggerHelper {

    public static void stopDoubleEnroll (List<ClassEnrollment__c> enrollmentInserted){
        checkDoubleEnroll(enrollmentInserted);
    }
 
    private static String getClassID(List<ClassEnrollment__c> enrollment) {
        String classID;
        for (ClassEnrollment__c classes : enrollment) {
            classID = classes.Class__r.Id;
        }
            return classID;
    }

    private static String getStudentID(List<ClassEnrollment__c> enrollment) {
        String studentID;
        for (ClassEnrollment__c classes : enrollment) {
            studentID = classes.Student__r.Id;
        }
            return studentID;
    }

    public static List<ClassEnrollment__c> checkDoubleEnroll (List<ClassEnrollment__c> enrollmentInserted){

        List<ClassEnrollment__c> checkIdStudentEnroll;

        if(Schema.sObjectType.ClassEnrollment__c.isAccessible()){
            checkIdStudentEnroll = [SELECT id, Student__c, Class__c
                FROM ClassEnrollment__c
                WHERE Class__r.Id =: getClassID(enrollmentInserted) AND Student__r.Id =: getStudentID(enrollmentInserted)
                ];
        }
        if (checkIdStudentEnroll.size() > 1){
            enrollmentInserted[0].addError(UserPermissionErrors.CANNOT_ENROLL_AGAIN);
        } else{
            enrollmentInserted[0].addError(UserPermissionErrors.CANNOT_CREATE_ENROLL);
        }

        return checkIdStudentEnroll;
    }
}

