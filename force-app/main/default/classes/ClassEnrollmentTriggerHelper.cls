public with sharing class ClassEnrollmentTriggerHelper {

    public static void stopDoubleEnroll (ClassEnrollment__c enrollmentInserted){
        
        List<ClassEnrollment__c> checkIdStudentEnroll;
        
        
        if(Schema.sObjectType.ClassEnrollment__c.isAccessible()){
            checkIdStudentEnroll = [SELECT id,Class__c, Student__c
                FROM ClassEnrollment__c
                WHERE Class__C =: enrollmentInserted.Class__c AND Student__c =: enrollmentInserted.Student__c
                ];
        }
        if (checkIdStudentEnroll.size() > 1){
            enrollmentInserted.addError(UserPermissionErrors.CANNOT_ENROLL_AGAIN);
        } else{
            enrollmentInserted.addError(UserPermissionErrors.CANNOT_CREATE_ENROLL);
        }


    }
}
