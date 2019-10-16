public with sharing class ClassEnrollmentTriggerHelper {





    public static void stopDoubleEnroll (List<ClassEnrollment__c> enrollmentInserted){

    }


    public static checkIfStudentIsEnrolled(List<ClassENrollment__c> newEnroll){

        List<ClassEnrollment__c> checkIdStudentEnroll = [SELECT id,Class__c, Student__c
        FROM ClassEnrollment__c
        WHERE Status__c =: 'Enrolled'
        ];
        
        






    }
}
