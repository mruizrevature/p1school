public with sharing class ClassEnrollmentTriggerHelper {

    public static void stopDoubleEnroll (List<ClassEnrollment__c> enrollmentInserted){
        checkDoubleEnroll(enrollmentInserted);
    }
 


    public static List<ClassEnrollment__c> checkDoubleEnroll (List<ClassEnrollment__c> enrollmentInserted){
        String classID;
        String studentID;
        
        for (ClassEnrollment__c classes : enrollmentInserted) {
            classID = classes.Class__r.Id;
            studentID = classes.Student__r.Id;
        }
        List<ClassEnrollment__c> checkIdStudentEnroll;

        if(Schema.sObjectType.ClassEnrollment__c.isAccessible()){
            checkIdStudentEnroll = [SELECT id, Student__c, Class__c
                FROM ClassEnrollment__c
                WHERE Class__r.Id =: classID AND Student__r.Id =: studentID
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

